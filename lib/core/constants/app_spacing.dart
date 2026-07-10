/// Spacing constants following an 8-point grid system.
///
/// All spacing values are multiples of 4 or 8 to ensure
/// visual consistency across the portfolio.
abstract class AppSpacing {
  AppSpacing._();

  // ---------------------------------------------------------------------------
  // Base Scale
  // ---------------------------------------------------------------------------
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
  static const double huge = 80.0;
  static const double massive = 120.0;

  // ---------------------------------------------------------------------------
  // Section Vertical Spacing
  // ---------------------------------------------------------------------------
  static const double sectionVertical = 96.0;
  static const double sectionVerticalMobile = 64.0;

  // ---------------------------------------------------------------------------
  // Section Horizontal Padding (responsive)
  // ---------------------------------------------------------------------------
  static const double sectionHorizontalMobile = 20.0;
  static const double sectionHorizontalTablet = 48.0;
  // A professional desktop canvas should feel spacious without leaving the
  // content stranded in the middle of wide displays. These are gutters, not
  // a second content-width constraint.
  static const double sectionHorizontalDesktop = 56.0;
  static const double sectionHorizontalLarge = 72.0;

  // ---------------------------------------------------------------------------
  // Content Width Constraints
  // ---------------------------------------------------------------------------
  // Wide enough for modern desktop portfolio layouts while retaining a clear
  // reading measure on standard laptop screens.
  static const double maxContentWidth = 1440.0;
  static const double maxNarrowWidth = 780.0;

  // ---------------------------------------------------------------------------
  // Component-Specific
  // ---------------------------------------------------------------------------
  static const double cardPadding = 24.0;
  static const double cardPaddingMobile = 16.0;
  static const double navHeight = 64.0;
  static const double chipHorizontal = 12.0;
  static const double chipVertical = 6.0;
  static const double borderRadius = 12.0;
  static const double borderRadiusSm = 8.0;
  static const double borderRadiusLg = 16.0;
}
