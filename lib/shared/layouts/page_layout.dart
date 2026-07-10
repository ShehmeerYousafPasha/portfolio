import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/responsive_utils.dart';

/// Constrains content to [maxWidth] and applies responsive horizontal padding.
///
/// All sections should wrap their content in [PageLayout] to ensure
/// consistent alignment and spacing across breakpoints.
///
/// Default max width: 1200px (set in [AppSpacing.maxContentWidth]).
class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.child,
    this.maxWidth = AppSpacing.maxContentWidth,
    this.applyVerticalPadding = false,
  });

  final Widget child;
  final double maxWidth;

  /// Optionally adds standard vertical section padding.
  final bool applyVerticalPadding;

  @override
  Widget build(BuildContext context) {
    final hPad = responsiveValue<double>(
      context,
      mobile: AppSpacing.sectionHorizontalMobile,
      tablet: AppSpacing.sectionHorizontalTablet,
      desktop: AppSpacing.sectionHorizontalDesktop,
      largeDesktop: AppSpacing.sectionHorizontalLarge,
    );

    final vPad = applyVerticalPadding
        ? responsiveValue<double>(
            context,
            mobile: AppSpacing.sectionVerticalMobile,
            desktop: AppSpacing.sectionVertical,
          )
        : 0.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          child: child,
        ),
      ),
    );
  }
}
