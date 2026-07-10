import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/experience_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/badges/status_badge.dart';
import '../../../../../shared/widgets/badges/tech_chip.dart';
import '../../../../../shared/widgets/common/app_divider.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';

/// Professional Experience section.
///
/// Renders each [ExperienceModel] as a detailed card containing:
/// - Company name + role + duration + location
/// - "Current Role" badge for active positions
/// - Description paragraph
/// - Responsibilities list
/// - Grouped production apps (Transportation / Logistics / Delivery)
/// - Technology chips
///
/// Source data: [allExperienceProvider] via Riverpod.
/// Sits on an alternate background for visual rhythm after Skills.
class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experienceAsync = ref.watch(allExperienceProvider);

    return SectionContainer(
      id: 'experience',
      isAlternate: true,
      child: AsyncValueWidget<List<ExperienceModel>>(
        value: experienceAsync,
        data: (entries) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Where I\'ve worked',
              title: AppStrings.sectionExperience,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _ExperienceList(entries: entries),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Vertical list of experience entries with a timeline connector
// ---------------------------------------------------------------------------

class _ExperienceList extends StatelessWidget {
  const _ExperienceList({required this.entries});

  final List<ExperienceModel> entries;

  @override
  Widget build(BuildContext context) {
    final isDesktop = deviceTypeOf(context).isDesktop;

    return isDesktop
        ? _DesktopTimeline(entries: entries)
        : _MobileList(entries: entries);
  }
}

// ---------------------------------------------------------------------------
// Desktop — left accent line with cards inset to the right
// ---------------------------------------------------------------------------

class _DesktopTimeline extends StatelessWidget {
  const _DesktopTimeline({required this.entries});

  final List<ExperienceModel> entries;

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).colorScheme.outlineVariant;

    // Draw the vertical rail with a Stack so the gutter does not need flex
    // in an unbounded-height parent.
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.5, top: 34),
              child: Container(width: 1, color: lineColor),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 14,
              child: _TimelineDot(
                isCurrent: entries.isNotEmpty && entries.first.isCurrent,
              ),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              child: Column(
                children: entries
                    .asMap()
                    .entries
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              e.key < entries.length - 1 ? AppSpacing.xl : 0,
                        ),
                        child: _ExperienceCard(entry: e.value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile — plain stacked list (no gutter, no intrinsic height cost)
// ---------------------------------------------------------------------------

class _MobileList extends StatelessWidget {
  const _MobileList({required this.entries});

  final List<ExperienceModel> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(
                bottom: e.key < entries.length - 1 ? AppSpacing.xl : 0,
              ),
              child: _ExperienceCard(entry: e.value),
            ),
          )
          .toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Timeline dot indicator
// ---------------------------------------------------------------------------

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({required this.isCurrent});

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent
            ? AppColors.primary
            : Theme.of(context).colorScheme.outlineVariant,
        border: Border.all(
          color: isCurrent
              ? AppColors.primary.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outlineVariant,
          width: 3,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Full experience card
// ---------------------------------------------------------------------------

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.entry});

  final ExperienceModel entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceCard : AppColors.lightSurfaceCard,
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(
          color: entry.isCurrent
              ? AppColors.primary.withValues(alpha: 0.30)
              : cs.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: _ExperienceHeader(entry: entry),
          ),

          AppDivider(
            color: entry.isCurrent
                ? AppColors.primary.withValues(alpha: 0.12)
                : cs.outlineVariant,
          ),

          // ── Body ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: _ExperienceBody(entry: entry),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card header — company, role, duration, badges
// ---------------------------------------------------------------------------

class _ExperienceHeader extends StatelessWidget {
  const _ExperienceHeader({required this.entry});

  final ExperienceModel entry;

  @override
  Widget build(BuildContext context) {
    final isDesktop = deviceTypeOf(context).isDesktop;

    return isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CompanyBadge(company: entry.company),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: _RoleDetails(entry: entry)),
              if (entry.isCurrent) ...[
                const SizedBox(width: AppSpacing.md),
                const StatusBadge.current(),
              ],
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CompanyBadge(company: entry.company),
                  const Spacer(),
                  if (entry.isCurrent) const StatusBadge.current(),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _RoleDetails(entry: entry),
            ],
          );
  }
}

class _CompanyBadge extends StatelessWidget {
  const _CompanyBadge({required this.company});

  final String company;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: AppRadius.smBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        company.substring(0, 1).toUpperCase(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _RoleDetails extends StatelessWidget {
  const _RoleDetails({required this.entry});

  final ExperienceModel entry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.titleLg(entry.company),
        const SizedBox(height: 2),
        AppText.titleMd(entry.role, color: AppColors.primary),
        const SizedBox(height: AppSpacing.sm),
        // Duration + location row
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 13, color: cs.onSurfaceVariant),
                const SizedBox(width: 5),
                AppText.bodySmall(entry.duration),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined,
                    size: 13, color: cs.onSurfaceVariant),
                const SizedBox(width: 5),
                AppText.bodySmall(entry.location),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Card body — description, responsibilities, apps, technologies
// ---------------------------------------------------------------------------

class _ExperienceBody extends StatelessWidget {
  const _ExperienceBody({required this.entry});

  final ExperienceModel entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        AppText.body(
          entry.description,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),

        const SizedBox(height: AppSpacing.xl),

        // Production apps — grouped by category
        if (entry.projects.isNotEmpty) ...[
          _ProductionApps(groups: entry.projects),
          const SizedBox(height: AppSpacing.xl),
        ],

        // Responsibilities
        _ResponsibilitiesList(items: entry.responsibilities),

        const SizedBox(height: AppSpacing.xl),

        // Technologies
        _TechnologiesRow(technologies: entry.technologies),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Grouped production apps grid
// ---------------------------------------------------------------------------

class _ProductionApps extends StatelessWidget {
  const _ProductionApps({required this.groups});

  final List<ExperienceProjectGroup> groups;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.label(AppStrings.productionApps),
        const SizedBox(height: AppSpacing.md),
        ...groups.map(
          (group) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category row
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.fullBorderRadius,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppText.labelSmall(
                      group.category.toUpperCase(),
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                // App name chips
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children:
                      group.apps.map((app) => _AppNameChip(name: app)).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AppNameChip extends StatelessWidget {
  const _AppNameChip({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: AppRadius.xsBorderRadius,
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.phone_iphone_rounded,
              size: 12, color: cs.onSurfaceVariant),
          const SizedBox(width: 5),
          AppText.labelSmall(name),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Responsibilities — bullet list
// ---------------------------------------------------------------------------

class _ResponsibilitiesList extends StatelessWidget {
  const _ResponsibilitiesList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.label(AppStrings.responsibilities),
        const SizedBox(height: AppSpacing.md),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppText.body(
                    item,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Technologies row — existing TechChip widget
// ---------------------------------------------------------------------------

class _TechnologiesRow extends StatelessWidget {
  const _TechnologiesRow({required this.technologies});

  final List<String> technologies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.label(AppStrings.technologies),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: technologies
              .map((tech) => TechChip.primary(label: tech))
              .toList(),
        ),
      ],
    );
  }
}
