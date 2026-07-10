{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  // ── Renderer ──────────────────────────────────────────────────────────
  // "auto" → canvaskit on desktop/tablet, html on mobile.
  // This gives the best trade-off: sharp text on desktop, fast initial
  // load on mobile. Override with "canvaskit" or "html" if needed.
  renderer: "auto",

  // ── Service Worker / PWA ──────────────────────────────────────────────
  serviceWorkerSettings: {
    // "offline-first": cached assets are served from SW cache on repeat
    // visits, then updated in the background. Gives near-instant loads
    // after the first visit and works without a network connection.
    serviceWorkerVersion: "{{flutter_service_worker_version}}",
  },

  // ── Loading UX ────────────────────────────────────────────────────────
  onEntrypointLoaded: function(engineInitializer) {
    engineInitializer.initializeEngine().then(function(appRunner) {
      appRunner.runApp();
      // Let Flutter paint its first frame, then reveal the portfolio.
      window.setTimeout(window.hideAppLoader, 800);
    });
  },
});
