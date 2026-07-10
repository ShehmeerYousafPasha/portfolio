import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/profile_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/cards/hover_card.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';

/// Quick Snapshot section — a scannable row of key facts recruiters
/// look for first: role, specialization, education, CGPA, current
/// employer, and availability.
///
/// Source data: [ProfileModel.quickSnapshotItems] (defined in
/// `lib/data/profile.dart`), read here via [profileProvider].
///
/// Layout: a self-sizing responsive grid — 2 columns on mobile,
/// 3 columns on tablet and desktop — built with [LayoutBuilder]
/// rather than [GridView] so each card's exact width is computed
/// from the available space, guaranteeing no overflow at any width.
class QuickSnapshotSection extends ConsumerWidget {
  const QuickSnapshotSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return SectionContainer(
      id: 'quick-snapshot',
      child: AsyncValueWidget<ProfileModel>(
        value: profileAsync,
        data: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SectionHeader(
              title: AppStrings.sectionQuickSnapshot,
              alignment: CrossAxisAlignment.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _SnapshotGrid(items: profile.quickSnapshotItems),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Responsive grid — exact card widths computed from available space
// ---------------------------------------------------------------------------

class _SnapshotGrid extends StatelessWidget {
  const _SnapshotGrid({required this.items});

  final List<SnapshotItem> items;

  @override
  Widget build(BuildContext context) {
    final columns = responsiveValue<int>(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 3,
    );

    final spacing = responsiveValue<double>(
      context,
      mobile: AppSpacing.sm,
      desktop: AppSpacing.md,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalGapWidth = spacing * (columns - 1);
        final cardWidth = (constraints.maxWidth - totalGapWidth) / columns;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: cardWidth,
                  child: _SnapshotCard(item: item),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Individual snapshot card
// ---------------------------------------------------------------------------

class _SnapshotCard extends StatelessWidget {
  const _SnapshotCard({required this.item});

  final SnapshotItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardPadding = responsiveValue<double>(
      context,
      mobile: AppSpacing.cardPaddingMobile,
      desktop: AppSpacing.cardPadding,
    );

    final minHeight = responsiveValue<double>(
      context,
      mobile: 110,
      desktop: 130,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: HoverCard(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
                borderRadius: AppRadius.smBorderRadius,
              ),
              alignment: Alignment.center,
              child: Icon(
                _iconForLabel(item.label),
                size: 20,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Label (caption)
            AppText.labelSmall(
              item.label.toUpperCase(),
              color: theme.colorScheme.onSurfaceVariant,
            ),

            const SizedBox(height: 4),

            // Value (the highlighted fact)
            AppText.titleLg(item.value, maxLines: 2),
          ],
        ),
      ),
    );
  }

  /// Maps a snapshot label to a representative icon.
  ///
  /// Falls back to a neutral icon for any future label not yet mapped,
  /// so adding new snapshot items later never breaks rendering.
  IconData _iconForLabel(String label) => switch (label) {
        'Role' => Icons.smartphone_rounded,
        'Specialization' => Icons.widgets_rounded,
        'Education' => Icons.school_rounded,
        'CGPA' => Icons.grade_rounded,
        'Currently At' => Icons.business_center_rounded,
        'Status' => Icons.public_rounded,
        _ => Icons.info_outline_rounded,
      };
}
