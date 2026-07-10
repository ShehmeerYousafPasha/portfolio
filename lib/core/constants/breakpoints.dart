/// Responsive breakpoints for the portfolio.
///
/// Design philosophy: Desktop-first with excellent mobile experience.
///
/// Tier mapping:
/// - Mobile:       width < 600
/// - Tablet:       600 ≤ width < 1024
/// - Desktop:      1024 ≤ width < 1440
/// - LargeDesktop: width ≥ 1440
abstract class Breakpoints {
  Breakpoints._();

  static const double mobile = 600.0;
  static const double tablet = 1024.0;
  static const double desktop = 1440.0;
  static const double largeDesktop = 1920.0;
}

/// Semantic device type derived from screen width.
enum DeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop;

  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop || this == DeviceType.largeDesktop;
  bool get isTabletOrAbove => this != DeviceType.mobile;
  bool get isDesktopOrAbove => this == DeviceType.desktop || this == DeviceType.largeDesktop;
}
