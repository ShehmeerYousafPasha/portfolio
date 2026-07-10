import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';

/// Compact technology label chip.
///
/// Used in project cards ("Flutter", "Dart", "Supabase") and
/// experience entries to show the tech stack at a glance.
///
/// Two variants:
/// - [TechChip] — standard outlined chip (default)
/// - [TechChip.primary] — filled brand-color chip for featured/highlighted tech
///
/// ```dart
/// Wrap(
///   spacing: 6,
///   runSpacing: 6,
///   children: project.technologies
///       .map((t) => TechChip(label: t))
///       .toList(),
/// )
/// ```
class TechChip extends StatelessWidget {
  const TechChip({
    super.key,
    required this.label,
    this.onTap,
  }) : _isPrimary = false;

  const TechChip.primary({
    super.key,
    required this.label,
    this.onTap,
  }) : _isPrimary = true;

  final String label;
  final VoidCallback? onTap;
  final bool _isPrimary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final Color bgColor;
    final Color borderColor;
    final Color textColor;

    if (_isPrimary) {
      bgColor = AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.10);
      borderColor = AppColors.primary.withValues(alpha: 0.35);
      textColor = AppColors.primary;
    } else {
      bgColor = isDark
          ? cs.surfaceContainerHighest.withValues(alpha: 0.5)
          : cs.surfaceContainerHighest;
      borderColor = cs.outline;
      textColor = cs.onSurfaceVariant;
    }

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.xsBorderRadius,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: chip);
    }

    return chip;
  }
}
