import 'dart:js_interop_unsafe';

import 'package:flutter/foundation.dart';
import 'package:shehmeer_portfolio/services/analytics_events.dart';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// Google Analytics 4 tracking service for the portfolio.
///
/// Uses the GA4 `gtag.js` SDK loaded in `web/index.html`.
/// All calls are no-ops on Android, iOS, and desktop — safe to call
/// unconditionally throughout the app without platform guards.
abstract class AnalyticsService {
  AnalyticsService._();

  static const String _measurementId = String.fromEnvironment(
    'GA_MEASUREMENT_ID',
    defaultValue: 'G-XXXXXXXXXX',
  );

  static void trackPageView({
    required String path,
    required String title,
  }) {
    _gtag('event', AnalyticsEvents.pageView, {
      Params.pagePath: path,
      Params.pageTitle: title,
      Params.pageLocation: '${_origin()}$path',
    });
  }

  static void trackResumeView() {
    _gtag('event', AnalyticsEvents.resumeView, {
      Params.section: 'resume',
    });
  }

  static void trackResumeDownload() {
    _gtag('event', AnalyticsEvents.resumeDownload, {
      Params.section: 'resume',
    });
  }

  static void trackContactClick({
    required String platform,
    required String url,
    String section = 'contact',
  }) {
    _gtag('event', AnalyticsEvents.contactLinkClick, {
      Params.contactPlatform: platform,
      Params.linkUrl: url,
      Params.section: section,
    });
  }

  static void trackProjectClick({
    required String eventName,
    required String projectId,
    required String projectName,
    String? url,
  }) {
    _gtag('event', eventName, {
      Params.projectId: projectId,
      Params.projectName: projectName,
      if (url != null) Params.linkUrl: url,
    });
  }

  static void trackHireMeClick({String section = 'nav'}) {
    _gtag('event', AnalyticsEvents.hireMeClick, {
      Params.section: section,
    });
  }

  static void _gtag(
    String command,
    String eventName,
    Map<String, String> parameters,
  ) {
    if (!kIsWeb || !_analyticsEnabled) return;

    try {
      final jsParams = _toJsObject(parameters);
      _callGtag(command, eventName, jsParams);
    } catch (_) {}
  }

  static JSObject _toJsObject(Map<String, String> map) {
    final obj = JSObject();
    for (final entry in map.entries) {
      obj.setProperty(entry.key.toJS, entry.value.toJS);
    }
    return obj;
  }

  static String _origin() {
    try {
      return web.window.location.origin;
    } catch (_) {
      return 'https://shehmeeryousafpasha.github.io/portfolio';
    }
  }

  static bool get _analyticsEnabled =>
      _measurementId.isNotEmpty && _measurementId != 'G-XXXXXXXXXX';
}

@JS('gtag')
external void _callGtag(String command, String name, JSObject params);
