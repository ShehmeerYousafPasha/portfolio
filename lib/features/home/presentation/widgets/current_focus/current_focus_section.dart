import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
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

/// Current Focus section — what Shehmeer is actively working on right now.
///
/// Source data: [ProfileModel.currentFocusAreas] (defined in
/// `lib/data/profile.dart`), read here via [profileProvider].
///
/// Unlike the equal-width grid in Quick Snapshot, focus items render as
/// content-sized pills in a flowing [Wrap] — visually distinct, and
/// appropriate since these are loosely-related tags rather than fixed
/// stats. Rendered on an alternate (elevated) background to break up
/// the page rhythm after the Hero and Quick Snapshot sections.
class CurrentFocusSection extends ConsumerWidget {
  const CurrentFocusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return SectionContainer(
      id: 'current-focus',
      isAlternate: true,
      child: AsyncValueWidget<ProfileModel>(
        value: profileAsync,
        data: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SectionHeader(
              title: AppStrings.sectionCurrentFocus,
              subtitle: 'What I\u2019m actively building and sharpening right now.',
              alignment: CrossAxisAlignment.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _FocusWrap(areas: profile.currentFocusAreas),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Flowing wrap of focus pills
// ---------------------------------------------------------------------------

class _FocusWrap extends StatelessWidget {
  const _FocusWrap({required this.areas});

  final List<String> areas;

  @override
  Widget build(BuildContext context) {
    final spacing = responsiveValue<double>(
      context,
      mobile: AppSpacing.sm,
      desktop: AppSpacing.md,
    );

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing,
      runSpacing: spacing,
      children: areas.map((area) => _FocusItem(label: area)).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Individual focus pill — icon badge + label, sized to its content
// ---------------------------------------------------------------------------

class _FocusItem extends StatelessWidget {
  const _FocusItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hPad = responsiveValue<double>(context, mobile: 16, desktop: 20);
    const vPad = 14.0;

    return HoverCard(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              _iconForFocus(label),
              size: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          AppText.titleMd(label),
        ],
      ),
    );
  }

  /// Maps a focus area label to a representative icon.
  ///
  /// Falls back to a neutral icon for any future focus area not yet
  /// mapped, so adding a 7th item later never breaks rendering.
  IconData _iconForFocus(String label) => switch (label) {
        'Flutter Development' => Icons.code_rounded,
        'Mobile Applications' => Icons.smartphone_rounded,
        'Performance Optimization' => Icons.speed_rounded,
        'Production App Development' => Icons.rocket_launch_rounded,
        'Clean Architecture' => Icons.architecture_rounded,
        'API Integration' => Icons.api_rounded,
        _ => Icons.bolt_rounded,
      };
}
