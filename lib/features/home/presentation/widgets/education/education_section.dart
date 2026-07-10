import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/profile_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/common/app_divider.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';

/// Education section — Bachelor of Science in Information Technology
/// from International Islamic University Islamabad, CGPA 3.56.
///
/// Source data: [profileProvider] (degree, university, cgpa fields).
/// Rendered as a single prominent card — education is one credential
/// entry, not a list, so a card-grid approach would leave too much
/// whitespace. Instead a two-column stat row anchors the card.
///
/// Background: base (not alternate) — continues the alternating rhythm
/// after the alternate Other Projects section.
class EducationSection extends ConsumerWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return SectionContainer(
      id: 'education',
      child: AsyncValueWidget<ProfileModel>(
        value: profileAsync,
        data: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Academic Background',
              title: AppStrings.sectionEducation,
            ),
            const SizedBox(height: AppSpacing.xxl),
            _EducationCard(profile: profile),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main education card
// ---------------------------------------------------------------------------

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = deviceTypeOf(context).isDesktop;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceCard : AppColors.lightSurfaceCard,
        borderRadius: AppRadius.lgBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isDark ? 0.06 : 0.05),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: isDesktop
          ? _DesktopLayout(profile: profile)
          : _MobileLayout(profile: profile),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop — icon column left, details right
// ---------------------------------------------------------------------------

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxxl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _UniversityBadge(),
          const SizedBox(width: AppSpacing.xxl),
          Expanded(child: _EducationDetails(profile: profile)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile — stacked layout
// ---------------------------------------------------------------------------

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _UniversityBadge(),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleLg(profile.degree, maxLines: 2),
                    const SizedBox(height: 4),
                    AppText.muted(profile.university, maxLines: 2),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _StatsRow(profile: profile),
          const SizedBox(height: AppSpacing.xl),
          const _HighlightsList(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// University initial badge
// ---------------------------------------------------------------------------

class _UniversityBadge extends StatelessWidget {
  const _UniversityBadge();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'IIUI',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop details column — title, university, divider, stats, highlights
// ---------------------------------------------------------------------------

class _EducationDetails extends StatelessWidget {
  const _EducationDetails({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Degree + university
        AppText.h3(profile.degree),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const Icon(
              Icons.location_city_rounded,
              size: 15,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: AppText.body(
                profile.university,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),
        const AppDivider(),
        const SizedBox(height: AppSpacing.xl),

        // Stats row
        _StatsRow(profile: profile),

        const SizedBox(height: AppSpacing.xl),

        // Highlights
        const _HighlightsList(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Two-stat row — Degree type + CGPA
// ---------------------------------------------------------------------------

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _StatItem(
            label: AppStrings.degree,
            value: 'Bachelor\'s (BS)',
            icon: Icons.school_rounded,
          ),
        ),
        Container(
          width: 1,
          height: 48,
          color: Theme.of(context).colorScheme.outlineVariant,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        Expanded(
          child: _StatItem(
            label: AppStrings.cgpa,
            value: profile.cgpa.toStringAsFixed(2),
            icon: Icons.grade_rounded,
            valueColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: cs.onSurfaceVariant),
            const SizedBox(width: 6),
            AppText.labelSmall(
              label.toUpperCase(),
              color: cs.onSurfaceVariant,
            ),
          ],
        ),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: valueColor ?? cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Highlights list — key facts about the degree
// ---------------------------------------------------------------------------

class _HighlightsList extends StatelessWidget {
  const _HighlightsList();

  static const _highlights = [
    (Icons.laptop_mac_rounded,        'Information Technology — software, networking, and cybersecurity focus'),
    (Icons.calendar_today_rounded,    'Graduated from IIUI, Islamabad'),
    (Icons.emoji_events_rounded,      'CGPA 3.56 — consistent academic performance'),
    (Icons.developer_mode_rounded,    'Final year project: MechKonnect — Flutter + Supabase'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _highlights
          .map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      h.$1,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppText.body(
                      h.$2,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
