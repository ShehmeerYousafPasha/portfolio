/// Google Analytics 4 event names and parameter keys used by [AnalyticsService].
///
/// All event names follow GA4 naming conventions:
/// - lowercase_with_underscores
/// - ≤ 40 characters
/// - No spaces or special characters
///
/// Custom parameters must also be registered as custom dimensions/metrics
/// in the GA4 property UI before they appear in reports.
abstract class AnalyticsEvents {
  AnalyticsEvents._();

  // ---------------------------------------------------------------------------
  // Event names
  // ---------------------------------------------------------------------------

  /// Fired on every GoRouter navigation.
  /// GA4 built-in: automatically sent by gtag when configured — we send
  /// manually so we control the [Params.pageTitle] field precisely.
  static const String pageView = 'page_view';

  /// Resume PDF opened in browser tab.
  static const String resumeView = 'resume_view';

  /// Resume PDF download triggered.
  static const String resumeDownload = 'resume_download';

  /// A social / contact link clicked (email, WhatsApp, LinkedIn, GitHub).
  static const String contactLinkClick = 'contact_link_click';

  /// A project card's "View on GitHub" link clicked.
  static const String projectGithubClick = 'project_github_click';

  /// A project card's "View Live" link clicked.
  static const String projectLiveClick = 'project_live_click';

  /// The "Case Study" ghost link clicked on the Featured Project card.
  static const String projectCaseStudyClick = 'project_case_study_click';

  /// "Hire Me" CTA clicked anywhere (nav bar or hero).
  static const String hireMeClick = 'hire_me_click';
}

// ---------------------------------------------------------------------------
// Parameter keys
// ---------------------------------------------------------------------------

/// Parameter key namespace.
abstract class Params {
  Params._();

  // Standard GA4 page_view params
  static const String pageTitle = 'page_title';
  static const String pagePath = 'page_path';
  static const String pageLocation = 'page_location';

  // Custom — register in GA4 UI as custom dimensions
  static const String projectName = 'project_name';
  static const String projectId = 'project_id';
  static const String contactPlatform = 'contact_platform';
  static const String linkUrl = 'link_url';
  static const String section = 'section';
}
