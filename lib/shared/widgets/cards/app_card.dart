import 'package:flutter/material.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_durations.dart';

/// Base card widget for the portfolio design system.
///
/// Reads all colors from the active [ThemeData] — works in both
/// light and dark mode without any manual color switching.
///
/// Supports:
/// - Optional [onTap] with ripple effect
/// - Custom [padding] override
/// - Custom [borderColor] for highlighted states
/// - [elevation] toggle for shadow display
///
/// ```dart
/// AppCard(
///   child: Column(children: [...]),
/// )
///
/// AppCard(
///   padding: EdgeInsets.all(AppSpacing.md),
///   onTap: () => context.go('/projects'),
///   child: ProjectSummary(),
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderColor,
    this.backgroundColor,
    this.width,
    this.height,
    this.showShadow = false,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;

  /// Defaults to [AppSpacing.cardPadding] if null.
  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  /// Override the border stroke color — useful for hover and primary states.
  final Color? borderColor;

  /// Override the card background — defaults to [ThemeData.cardTheme.color].
  final Color? backgroundColor;

  final double? width;
  final double? height;

  /// Show a [AppShadows] box shadow. Usually off for dark theme cards.
  final bool showShadow;

  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBg = backgroundColor ?? theme.cardTheme.color;
    final effectiveBorder = borderColor ?? cs.outline;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppSpacing.cardPadding);

    Widget content = Container(
      width: width,
      height: height,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(color: effectiveBorder, width: 1),
        boxShadow: showShadow ? AppShadows.card(context) : null,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        borderRadius: AppRadius.mdBorderRadius,
        clipBehavior: clipBehavior,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdBorderRadius,
          splashColor: cs.primary.withValues(alpha: isDark ? 0.08 : 0.06),
          highlightColor: cs.primary.withValues(alpha: isDark ? 0.04 : 0.03),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: effectiveBg,
              borderRadius: AppRadius.mdBorderRadius,
              border: Border.all(color: effectiveBorder, width: 1),
              boxShadow: showShadow ? AppShadows.card(context) : null,
            ),
            child: Padding(
              padding: effectivePadding,
              child: child,
            ),
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: AppDurations.hoverTransition,
      child: content,
    );
  }
}
