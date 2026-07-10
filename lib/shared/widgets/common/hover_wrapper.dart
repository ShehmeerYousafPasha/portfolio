import 'package:flutter/material.dart';

/// Generic hover state wrapper using a [MouseRegion].
///
/// Exposes [isHovered] to the child via a builder function, letting
/// any widget react to pointer enter/exit without managing its own
/// [StatefulWidget] + [MouseRegion] boilerplate.
///
/// On touch devices [MouseRegion] is a zero-cost no-op, so [isHovered]
/// will always be false — safe to use unconditionally.
///
/// ```dart
/// HoverWrapper(
///   builder: (context, isHovered) => AnimatedContainer(
///     color: isHovered ? hoverColor : defaultColor,
///     child: ...,
///   ),
/// )
/// ```
class HoverWrapper extends StatefulWidget {
  const HoverWrapper({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.basic,
    this.onTap,
  });

  final Widget Function(BuildContext context, bool isHovered) builder;
  final MouseCursor cursor;
  final VoidCallback? onTap;

  @override
  State<HoverWrapper> createState() => _HoverWrapperState();
}

class _HoverWrapperState extends State<HoverWrapper> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : widget.cursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: widget.builder(context, _isHovered),
      ),
    );
  }
}
