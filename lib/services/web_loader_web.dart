import 'dart:js_interop';

@JS('hideAppLoader')
external void _hideAppLoader();

/// Removes the HTML startup loader once Flutter's first screen is ready.
void hideWebLoader() {
  try {
    _hideAppLoader();
  } catch (_) {}
}
