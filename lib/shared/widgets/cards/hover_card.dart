import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_shadows.dart';
import '../../../core/constants/app_spacing.dart';

/// Interactive card with a desktop hover state.
///
/// On pointer enter:
/// - Border brightens to a semi-transparent primary color
/// - Card scales up 1.2% (subtle lift)
/// - Shadow deepens (light theme only)
///
/// Accessibility: when [onTap] is provided, wrapped in [Semantics]
/// with button role so screen readers identify it as interactive.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBg = widget.backgroundColor ?? theme.cardTheme.color;
    final effectivePadding =
        widget.padding ?? const EdgeInsets.all(AppSpacing.cardPadding);

    final borderColor = _isHovered
        ? AppColors.primary.withValues(alpha: 0.45)
        : cs.outline;

    final boxShadow = _isHovered
        ? (isDark ? AppShadows.elevatedDark : AppShadows.elevatedLight)
        : (isDark ? AppShadows.cardDark : AppShadows.cardLight);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedScale(
        scale: _isHovered ? 1.012 : 1.0,
        duration: AppDurations.hoverTransition,
        curve: AppDurations.hover,
        child: Semantics(
          button: widget.onTap != null,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: AppDurations.hoverTransition,
              curve: AppDurations.hover,
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: effectiveBg,
                borderRadius: AppRadius.mdBorderRadius,
                border: Border.all(color: borderColor, width: 1),
                boxShadow: boxShadow,
              ),
              child: ClipRRect(
                borderRadius: AppRadius.mdBorderRadius,
                child: Padding(
                  padding: effectivePadding,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
