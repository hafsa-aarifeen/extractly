# Extractly

A Flutter Android app that turns a photo of a receipt into structured, editable,
locally-stored data using Google's Gemini API. Point the camera at a receipt and
the app extracts the merchant, date, totals, and line items as schema-constrained
JSON, validates the result, lets you correct anything, and saves it to an on-device
database.

The interesting engineering here isn't "call an LLM" — it's making an LLM's output
**reliable**: constraining it to a schema, validating it independently, and handling
every way the call can fail.

---

## What it does

- **Scan** a receipt with the camera or pick one from the gallery.
- **Extract** structured data (merchant, address, date, currency, subtotal/tax/tip/total,
  payment method, and individual line items) via Gemini.
- **Review and edit** every field before saving — the model's output is a starting
  point, never the final word.
- **Flag for review** automatically when totals don't reconcile or a core field is
  missing.
- **Store** everything locally in SQLite; the receipt list updates itself reactively.
- **Browse and delete** saved receipts, with line items shown in a detail view.

Works fully offline once a receipt is saved — only the extraction step needs a network.

---

## Architecture

The app is organised into three layers with a strict dependency direction
(`presentation → domain / data`), so business logic never leaks into widgets and
storage details stay swappable and testable.

```
lib/
├── main.dart                     # app entry, ProviderScope root
├── data/
│   ├── database/
│   │   ├── tables.dart           # Drift table definitions (Receipts, ReceiptItems)
│   │   └── app_database.dart     # database + generated query code
│   ├── gemini/
│   │   ├── gemini_config.dart    # build-time API key (never committed)
│   │   ├── receipt_schema.dart   # the JSON schema + system instruction
│   │   └── gemini_extraction_service.dart   # the extraction engine
│   └── receipt_repository.dart   # the single entry point for persistence
├── domain/
│   ├── parsed_receipt.dart       # model output, independent of the database
│   ├── extraction_result.dart    # sealed result type (success / not-a-receipt / failure)
│   └── receipt_validator.dart    # independent "does this reconcile?" checks
└── presentation/
    ├── providers.dart            # Riverpod dependency injection
    ├── home_screen.dart          # reactive receipt list + capture entry
    ├── capture_controller.dart   # pick image → extract → expose state
    ├── review_screen.dart        # editable extracted fields
    └── detail_screen.dart        # full receipt view + delete
```

### The extraction pipeline

This is the core of the app. Each numbered step is a deliberate reliability decision.

1. **Compress before upload.** The captured image is downscaled to a 1600px max
   edge before it's sent — smaller payloads, faster calls, lower token usage.
2. **Constrain, don't hope.** The request sends a `responseSchema` with
   `responseMimeType: application/json`, so Gemini is *constrained* to emit JSON of
   the exact shape — not merely asked to. Every field except `status` and each item's
   `description` is nullable, and the system instruction forbids inventing values.
3. **Retry the retryable, fail fast on the permanent.** Rate limits (HTTP 429),
   server errors (5xx), network failures, and unparseable responses are retried with
   exponential backoff plus jitter. Client errors (4xx, e.g. a bad key) fail
   immediately — retrying them is pointless.
4. **Never trust the model blindly.** Successful responses are run through an
   independent validator that checks the numbers reconcile
   (`subtotal + tax + tip ≈ total`, within tolerance) and that core fields are
   present. If anything is off, the receipt is flagged `needsReview` and surfaced to
   the user rather than silently trusted.
5. **Exhaustive result handling.** The pipeline returns a sealed `ExtractionResult`
   (`ExtractionSuccess` / `ExtractionNotAReceipt` / `ExtractionFailure`), so the UI
   is forced by the compiler to handle every outcome — there is no path where a
   result silently does nothing.

---

## Tech stack

| Concern | Choice | Why |
|---|---|---|
| Framework | Flutter (stable) | Single codebase, native performance |
| State management | Riverpod | Compile-safe DI, testable providers, reactive |
| Local database | Drift (SQLite) | Type-safe queries + reactive streams |
| LLM | Gemini (`gemini-3.6-flash`) via REST | Free tier, multimodal, schema-constrained output |
| HTTP | `http` | No SDK lock-in; direct control over the request |
| Image capture | `image_picker` | Camera + gallery with permission handling |

**Why the raw REST API instead of an SDK?** Google's official
`google_generative_ai` Dart package is deprecated (superseded by `firebase_ai`,
which requires a full Firebase project). Calling the REST endpoint directly with
`http` avoids that dependency, needs no Firebase setup, and keeps the schema and
response handling fully under my control — which is the whole point of the app.

---

## Key decisions

- **Schema-constrained output over prompt-and-hope.** The difference between
  "please return JSON" and an enforced `responseSchema` is the difference between a
  demo and something dependable.
- **A validation layer separate from the model.** The app has its own opinion about
  whether an extraction is trustworthy, independent of what the model claims.
- **One reliability mechanism, two jobs.** The retry/backoff loop handles both
  malformed responses *and* free-tier rate limits (429) — the same code, two failure
  modes.
- **Transactional saves.** A receipt and its line items are inserted in a single
  transaction, so the database can never hold a receipt with half its items.
- **Cascade deletes at the schema level.** Deleting a receipt removes its line items
  via a foreign-key cascade, not manual cleanup code.
- **Reactive reads.** The receipt list is a Drift `.watch()` stream, so the UI
  updates the instant the database changes — no manual refresh.
- **The model name lives in exactly one constant.** This turned out to matter (see
  below).

---

## Running locally

Requires the Flutter SDK and a physical Android device (the app targets the camera).

1. **Get a Gemini API key** from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. **Create `env.json`** in the project root (it is gitignored and never committed):
   ```json
   { "GEMINI_API_KEY": "your-key-here" }
   ```
3. **Run**, injecting the key at build time:
   ```bash
   flutter run --dart-define-from-file=env.json
   ```

The key is read via `String.fromEnvironment` and is never hardcoded or committed.

---

## Testing

```bash
flutter test
```

The suite covers the two pieces that carry the app's reliability guarantees:

- **`ReceiptValidator`** — reconciliation math, rounding tolerance, and each
  missing-field flag.
- **`GeminiExtractionService`** — using a fake HTTP client (no network, no key) to
  assert: valid responses map to success, `not_a_receipt` is handled, malformed JSON
  is retried up to the limit, a 429-then-success recovers, and a 400 fails fast
  without wasting retries.

The service takes its `http.Client` and validator via constructor injection
specifically so these tests can run deterministically offline.

---

## Engineering notes & honest limitations

**The API key ships in the client.** For a portfolio build the key is injected at
build time and kept out of git, which is fine for demonstration. The production-correct
approach is to proxy the Gemini call through a backend that holds the key server-side
(so it never reaches the device) and to add abuse protection. That's a deliberate,
named trade-off, not an oversight.

**Free-tier data usage.** On Gemini's free tier, prompts may be used to improve
Google's models. Fine for scanning sample receipts; something to change (paid tier or
a proxy) before handling anything sensitive.

**Things I'd add next:** a proper `HomeScreen` widget test using Riverpod provider
overrides to inject a fake repository; storing and displaying the receipt image
alongside its data; export (CSV) of saved receipts; and multi-document-type support
(business cards, nutrition labels) via a schema registry, since the pipeline is
already generic enough to extend.

### A few things that broke, and what they taught me

- **Model drift mid-project.** `gemini-2.5-flash` was closed to new API users while
  I was building — the call started returning 404. Because the model name lived in a
  single constant, the fix was one line (`gemini-3.6-flash`). A good argument for not
  scattering magic strings.
- **A cross-drive Kotlin build failure.** The Flutter pub cache was on `C:` and the
  project on `D:`; the Kotlin incremental compiler can't compute a relative path
  across drive letters, so builds failed once a plugin shipping Kotlin source was
  added. Fixed by disabling Kotlin incremental compilation in `gradle.properties`.
- **Gradle out-of-memory on a constrained machine.** The default Gradle config asked
  for more heap than the machine had, causing thrashing. Capping the Gradle and Kotlin
  daemon heap in `gradle.properties` made builds reliable.

