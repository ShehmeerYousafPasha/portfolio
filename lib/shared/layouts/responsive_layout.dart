import 'package:flutter/material.dart';
import '../../core/constants/breakpoints.dart';

/// Renders a different widget depending on the available width.
///
/// Uses [LayoutBuilder] (not [MediaQuery]) so it responds to its
/// parent's constraints — safe inside columns, scrollviews, etc.
///
/// Fallback order (when a tier is omitted):
///   largeDesktop → desktop → tablet → mobile
///
/// Example:
/// ```dart
/// ResponsiveLayout(
///   mobile: MobileNav(),
///   tablet: TabletNav(),
///   desktop: DesktopNav(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w >= Breakpoints.desktop) {
          return largeDesktop ?? desktop ?? tablet ?? mobile;
        }
        if (w >= Breakpoints.tablet) {
          return desktop ?? tablet ?? mobile;
        }
        if (w >= Breakpoints.mobile) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
