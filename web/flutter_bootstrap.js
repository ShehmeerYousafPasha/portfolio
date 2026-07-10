{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  // ── Renderer ──────────────────────────────────────────────────────────
  // "auto" → canvaskit on desktop/tablet, html on mobile.
  // This gives the best trade-off: sharp text on desktop, fast initial
  // load on mobile. Override with "canvaskit" or "html" if needed.
  // ── Loading UX ────────────────────────────────────────────────────────
  onEntrypointLoaded: function(engineInitializer) {
    engineInitializer.initializeEngine().then(function(appRunner) {
      window.addEventListener('flutter-first-frame', window.hideAppLoader, {
        once: true,
      });
      appRunner.runApp();
      // The loader is dismissed by Flutter's first rendered frame event.
    });
  },
});
