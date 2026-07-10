import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/skill_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/badges/tech_chip.dart';
import '../../../../../shared/widgets/cards/hover_card.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';

/// Skills section — technologies grouped by category, exactly as
/// defined in `lib/data/skills.dart` (Mobile Development, Backend &
/// APIs, Databases, Tools, Web, Other).
///
/// Source data: read via [skillCategoriesProvider] rather than the
/// raw data file, consistent with the rest of the app.
///
/// Each skill renders as a [TechChip] — skills marked `advanced` or
/// `expert` in the data layer use the highlighted [TechChip.primary]
/// variant, giving recruiters an at-a-glance read on strongest areas
/// without resorting to percentage bars or invented statistics.
class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(skillCategoriesProvider);

    return SectionContainer(
      id: 'skills',
      child: AsyncValueWidget<List<SkillCategory>>(
        value: categoriesAsync,
        data: (categories) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SectionHeader(
              title: AppStrings.sectionSkills,
              subtitle: 'Core technologies and tools I work with daily.',
              alignment: CrossAxisAlignment.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _SkillsGrid(categories: categories),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Responsive grid — exact card widths computed from available space
// ---------------------------------------------------------------------------

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid({required this.categories});

  final List<SkillCategory> categories;

  @override
  Widget build(BuildContext context) {
    final columns = responsiveValue<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    final spacing = responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      desktop: AppSpacing.md,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalGapWidth = spacing * (columns - 1);
        final cardWidth = (constraints.maxWidth - totalGapWidth) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: categories
              .map(
                (category) => SizedBox(
                  width: cardWidth,
                  child: _SkillCategoryCard(category: category),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Individual category card
// ---------------------------------------------------------------------------

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  _iconForCategory(category.name),
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText.titleLg(category.name, maxLines: 2),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Skill chips — highlighted chip for advanced/expert skills
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: category.skills
                .map(
                  (skill) => _isStrong(skill.level)
                      ? TechChip.primary(label: skill.name)
                      : TechChip(label: skill.name),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  bool _isStrong(SkillLevel level) =>
      level == SkillLevel.advanced || level == SkillLevel.expert;

  /// Maps a category name to a representative icon.
  ///
  /// Falls back to a neutral icon for any future category not yet
  /// mapped, so adding a 7th category later never breaks rendering.
  IconData _iconForCategory(String name) => switch (name) {
        'Mobile Development' => Icons.smartphone_rounded,
        'Backend & APIs' => Icons.api_rounded,
        'Databases' => Icons.storage_rounded,
        'Tools' => Icons.build_rounded,
        'Web' => Icons.language_rounded,
        'Other' => Icons.security_rounded,
        _ => Icons.category_rounded,
      };
}
