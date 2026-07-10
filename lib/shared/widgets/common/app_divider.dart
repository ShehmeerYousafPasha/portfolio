import 'package:flutter/material.dart';
import '../typography/app_text.dart';

/// Themed horizontal divider, consistent with the portfolio design system.
///
/// Variants:
/// - [AppDivider] — plain full-width line
/// - [AppDivider.withLabel] — line with a centered text label
///   (used between section groups, e.g. skill categories)
///
/// ```dart
/// AppDivider()
///
/// AppDivider.withLabel(label: 'Mobile Development')
/// ```
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
  }) : _label = null;

  const AppDivider.withLabel({
    super.key,
    required String label,
    this.height = 24,
    this.color,
  })  : _label = label,
        indent = 0,
        endIndent = 0;

  final double height;
  final double indent;
  final double endIndent;
  final Color? color;
  final String? _label;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.outlineVariant;

    if (_label != null) {
      return Row(
        children: [
          Expanded(child: Divider(color: effectiveColor, height: height)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppText.labelSmall(
              _label,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(child: Divider(color: effectiveColor, height: height)),
        ],
      );
    }

    return Divider(
      height: height,
      indent: indent,
      endIndent: endIndent,
      color: effectiveColor,
    );
  }
}
