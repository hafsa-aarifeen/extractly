/// Reads build-time configuration injected via --dart-define-from-file.
///
/// The key is never hardcoded or committed; it comes from env.json at build
/// time. In production you'd instead proxy calls through your own backend so
/// the key never ships in the client at all.
class GeminiConfig {
  const GeminiConfig._();

  static const String apiKey = String.fromEnvironment('GEMINI_API_KEY');

  static bool get hasKey => apiKey.isNotEmpty;
}
