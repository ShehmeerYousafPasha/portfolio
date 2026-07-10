import 'package:flutter/material.dart';
import '../../../core/constants/app_durations.dart';

/// Outlined secondary button — theme-aware border, no fill.
///
/// Used for secondary actions: "View Resume", "View Projects".
/// Sits alongside [PrimaryButton] in hero CTAs.
///
/// ```dart
/// SecondaryButton(
///   label: 'View Resume',
///   icon: Icons.description_outlined,
///   onPressed: () => context.go(AppRoutes.resume),
/// )
/// ```
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isFullWidth = false,
    this.size = ButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final ButtonSize size;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (hPad, vPad, iconSize) = switch (widget.size) {
      ButtonSize.small => (16.0, 10.0, 14.0),
      ButtonSize.medium => (24.0, 14.0, 16.0),
      ButtonSize.large => (32.0, 18.0, 18.0),
    };

    final child = widget.icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: iconSize),
              const SizedBox(width: 8),
              Text(widget.label),
            ],
          )
        : Text(widget.label);

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.hoverTransition,
        curve: AppDurations.hover,
        decoration: BoxDecoration(
          color: _isHovered
              ? cs.onSurface.withValues(alpha: 0.04)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
            side: BorderSide(
              color:
                  _isHovered ? cs.primary.withValues(alpha: 0.6) : cs.outline,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );

    if (widget.isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}

enum ButtonSize { small, medium, large }
