import 'package:flutter/material.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_radius.dart';

/// Compact icon + label button for external link CTAs.
///
/// Used for: "View on GitHub", "WhatsApp", "LinkedIn".
/// Renders as a small outlined tile with an icon on the left.
///
/// Accessibility: wrapped in [Semantics] so screen readers announce
/// it as an interactive button with the correct label.
class IconTextButton extends StatefulWidget {
  const IconTextButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.isFullWidth = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final bool isFullWidth;

  @override
  State<IconTextButton> createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final iconColor = widget.iconColor ?? cs.onSurfaceVariant;

    Widget button = Semantics(
      button: true,
      label: widget.label,
      excludeSemantics: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: AppDurations.hoverTransition,
            curve: AppDurations.hover,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? cs.primary.withValues(alpha: 0.06)
                  : Colors.transparent,
              borderRadius: AppRadius.smBorderRadius,
              border: Border.all(
                color: _isHovered ? cs.primary.withValues(alpha: 0.5) : cs.outline,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color: _isHovered ? cs.primary : iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: _isHovered ? cs.primary : cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
