/// Centralized route path constants.
///
/// All navigation must go through these constants —
/// never hard-code string paths in widgets.
abstract class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String projects = '/projects';
  static const String experience = '/experience';
  static const String certificates = '/certificates';
  static const String resume = '/resume';
  static const String contact = '/contact';

  // ---------------------------------------------------------------------------
  // Future routes — architecture is ready, implementation deferred
  // ---------------------------------------------------------------------------
  // static const String blog = '/blog';
  // static const String blogPost = '/blog/:slug';
  // static const String caseStudy = '/case-studies/:id';
}
