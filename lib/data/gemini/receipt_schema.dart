/// The response schema Gemini must conform to, and the system instruction
/// that governs extraction behaviour.
///
/// The schema is sent as `responseSchema` with `responseMimeType:
/// application/json`, so the model is *constrained* to emit JSON of this
/// shape — not merely asked to. This is the difference between "please
/// return JSON" (unreliable) and schema-enforced structured output.
library;

/// OpenAPI-subset schema describing a receipt. Everything except `status`
/// and each item's `description` is nullable: the model returns null for
/// anything it can't read, and never invents a value.
const Map<String, Object?> receiptResponseSchema = {
  'type': 'OBJECT',
  'properties': {
    'status': {
      'type': 'STRING',
      'enum': ['ok', 'not_a_receipt'],
    },
    'merchant': {
      'type': 'OBJECT',
      'nullable': true,
      'properties': {
        'name': {'type': 'STRING', 'nullable': true},
        'address': {'type': 'STRING', 'nullable': true},
        'phone': {'type': 'STRING', 'nullable': true},
      },
    },
    'currency': {'type': 'STRING', 'nullable': true},
    'date': {'type': 'STRING', 'nullable': true},
    'time': {'type': 'STRING', 'nullable': true},
    'items': {
      'type': 'ARRAY',
      'items': {
        'type': 'OBJECT',
        'properties': {
          'description': {'type': 'STRING'},
          'quantity': {'type': 'NUMBER', 'nullable': true},
          'unit_price': {'type': 'NUMBER', 'nullable': true},
          'total': {'type': 'NUMBER', 'nullable': true},
        },
        'required': ['description'],
      },
    },
    'totals': {
      'type': 'OBJECT',
      'nullable': true,
      'properties': {
        'subtotal': {'type': 'NUMBER', 'nullable': true},
        'tax': {'type': 'NUMBER', 'nullable': true},
        'tip': {'type': 'NUMBER', 'nullable': true},
        'total': {'type': 'NUMBER', 'nullable': true},
      },
    },
    'payment_method': {'type': 'STRING', 'nullable': true},
  },
  'required': ['status'],
};

/// System instruction: the rules the model follows while extracting.
const String receiptSystemInstruction = '''
You are a receipt data extraction engine. You are given a single image and must
return only data that conforms to the provided response schema.

Rules:
1. Extract only what is visibly present in the image. Never invent or guess a
   value. If a field is not legible or not present, set it to null.
2. If the image is not a receipt (a person, a landscape, a random object, etc.),
   set "status" to "not_a_receipt" and leave the other fields null.
3. Monetary values are numbers, not strings, with at most two decimals. Do not
   include currency symbols in the numbers; put the currency in the "currency"
   field as a 3-letter ISO code (e.g. "LKR", "USD") if determinable, else null.
4. "date" must be ISO 8601 (YYYY-MM-DD) if a date is visible, else null.
5. Each line item must have a description. Do not merge separate items or split a
   single item across rows.
''';
