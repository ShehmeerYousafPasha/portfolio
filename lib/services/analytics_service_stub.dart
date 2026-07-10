abstract class AnalyticsService {
  AnalyticsService._();

  static void trackPageView({required String path, required String title}) {}

  static void trackResumeView() {}

  static void trackResumeDownload() {}

  static void trackContactClick({
    required String platform,
    required String url,
    String section = 'contact',
  }) {}

  static void trackProjectClick({
    required String eventName,
    required String projectId,
    required String projectName,
    String? url,
  }) {}

  static void trackHireMeClick({String section = 'nav'}) {}
}
