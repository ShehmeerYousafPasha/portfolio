import 'package:flutter/material.dart';
import '../../../core/constants/app_durations.dart';

/// Text-only ghost button — lowest visual weight.
///
/// Used for inline links, "See all projects →", nav text links.
/// Does not carry the brand color by default — uses theme foreground.
///
/// ```dart
/// GhostButton(
///   label: 'See all projects',
///   trailingIcon: Icons.arrow_forward_rounded,
///   onPressed: () => context.go(AppRoutes.projects),
/// )
/// ```
class GhostButton extends StatefulWidget {
  const GhostButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.usePrimaryColor = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  /// When true, renders in the primary brand color (#0C7029).
  final bool usePrimaryColor;

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveColor =
        widget.usePrimaryColor ? cs.primary : cs.onSurface;

    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedOpacity(
          opacity: _isHovered ? 0.75 : 1.0,
          duration: AppDurations.hoverTransition,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leadingIcon != null) ...[
                  Icon(
                    widget.leadingIcon,
                    size: 16,
                    color: effectiveColor,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: effectiveColor,
                        decoration: _isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: effectiveColor,
                      ),
                ),
                if (widget.trailingIcon != null) ...[
                  const SizedBox(width: 4),
                  AnimatedSlide(
                    offset: _isHovered
                        ? const Offset(0.2, 0)
                        : Offset.zero,
                    duration: AppDurations.hoverTransition,
                    curve: AppDurations.hover,
                    child: Icon(
                      widget.trailingIcon,
                      size: 14,
                      color: effectiveColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}
