import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';

/// Generic status badge with a colored dot and label.
///
/// Used for:
/// - Project status: "Completed", "In Progress"
/// - Experience: "Current Role"
/// - Certificate: "Verified"
///
/// Factory constructors cover the most common portfolio states.
///
/// ```dart
/// StatusBadge.completed()
/// StatusBadge.inProgress()
/// StatusBadge.current()
/// StatusBadge(label: 'Verified', color: AppColors.info)
/// ```
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
  });

  /// "Completed" — success/brand green.
  const StatusBadge.completed({Key? key})
      : this(key: key, label: 'Completed', color: AppColors.success);

  /// "In Progress" — warning amber.
  const StatusBadge.inProgress({Key? key})
      : this(key: key, label: 'In Progress', color: AppColors.warning);

  /// "Current Role" — info blue.
  const StatusBadge.current({Key? key})
      : this(key: key, label: 'Current Role', color: AppColors.info);

  /// "Featured" — brand primary green.
  const StatusBadge.featured({Key? key})
      : this(key: key, label: 'Featured', color: AppColors.primary);

  final String label;

  /// The dot color and tint for the badge background/border.
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.14 : 0.10),
        borderRadius: AppRadius.fullBorderRadius,
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
