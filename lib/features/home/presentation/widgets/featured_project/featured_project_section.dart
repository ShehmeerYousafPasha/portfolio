import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/project_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/badges/status_badge.dart';
import '../../../../../shared/widgets/badges/tech_chip.dart';
import '../../../../../shared/widgets/buttons/ghost_button.dart';
import '../../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';
import '../../../../../services/analytics_service.dart';
import '../../../../../services/analytics_events.dart';
import '../../../../../services/link_launcher.dart';
import '../../../../projects/presentation/widgets/mechkonnect_case_study_section.dart';

/// Featured Project section — the flagship personal project showcase.
///
/// Displays a single full-width premium card for MechKonnect (or
/// whichever project is marked [ProjectModel.isFeatured] in the data
/// layer). Renders nothing (empty [SizedBox]) if no project is
/// featured — safe to leave empty without layout breakage.
///
/// Desktop layout: image panel on the left, text + CTAs on the right.
/// Mobile layout: optional image header, then stacked text content.
///
/// Source data: [featuredProjectProvider].
/// Background: base (not alternate) — visual contrast after the
/// alternate Experience section.
class FeaturedProjectSection extends ConsumerWidget {
  const FeaturedProjectSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(featuredProjectProvider);

    return AsyncValueWidget<ProjectModel?>(
      value: projectAsync,
      data: (project) {
        if (project == null) return const SizedBox.shrink();
        return SectionContainer(
          id: 'featured-project',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SectionHeader(
                eyebrow: 'Flagship Project',
                title: AppStrings.sectionFeaturedProject,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _FeaturedCard(project: project),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Main featured card — switches layout at tablet breakpoint
// ---------------------------------------------------------------------------

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.lgBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.22),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.darkSurfaceCard,
                  AppColors.primary.withValues(alpha: 0.06),
                ]
              : [
                  Colors.white,
                  AppColors.primary.withValues(alpha: 0.04),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isDark ? 0.10 : 0.07),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.lgBorderRadius,
        child: _MobileLayout(project: project),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile — image header, then stacked content below
// ---------------------------------------------------------------------------

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final imageHeight = responsiveValue<double>(
      context,
      mobile: 180,
      tablet: 240,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image header
        SizedBox(
          height: imageHeight,
          child: _ProjectImagePanel(imageAsset: project.imageAsset),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _ProjectContent(project: project),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Image panel — asset or elegant branded fallback
// ---------------------------------------------------------------------------

class _ProjectImagePanel extends StatelessWidget {
  const _ProjectImagePanel({required this.imageAsset});

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (imageAsset != null && imageAsset!.isNotEmpty) {
      return Image.asset(
        imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _FallbackPanel(isDark: isDark),
      );
    }

    return _FallbackPanel(isDark: isDark);
  }
}

class _FallbackPanel extends StatelessWidget {
  const _FallbackPanel({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.primary.withValues(alpha: 0.18),
                  AppColors.primaryVariant.withValues(alpha: 0.08),
                ]
              : [
                  AppColors.primary.withValues(alpha: 0.10),
                  AppColors.primaryContainer,
                ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_iphone_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const AppText.labelSmall(
              'MechKonnect',
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Project content — badges, title, description, tech, CTAs
// ---------------------------------------------------------------------------

class _ProjectContent extends StatelessWidget {
  const _ProjectContent({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge row
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            const StatusBadge.featured(),
            if (project.status == ProjectStatus.completed)
              const StatusBadge.completed(),
            // "Final Year Project" label from data context
            const _ProjectTypeBadge(label: AppStrings.finalYearProject),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        // Title
        AppText.h2(project.title),

        const SizedBox(height: AppSpacing.md),

        // Short description
        AppText.body(
          project.longDescription,
          color: cs.onSurfaceVariant,
        ),

        const SizedBox(height: AppSpacing.xl),

        // Technology stack
        _TechStack(technologies: project.technologies),

        const SizedBox(height: AppSpacing.xl),

        // CTAs
        _ProjectCtas(project: project),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Small type badge (e.g. "Final Year Project")
// ---------------------------------------------------------------------------

class _ProjectTypeBadge extends StatelessWidget {
  const _ProjectTypeBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cs.onSurfaceVariant.withValues(alpha: isDark ? 0.10 : 0.07),
        borderRadius: AppRadius.fullBorderRadius,
        border: Border.all(
          color: cs.outlineVariant,
          width: 1,
        ),
      ),
      child: AppText.labelSmall(label, color: cs.onSurfaceVariant),
    );
  }
}

// ---------------------------------------------------------------------------
// Technology stack row
// ---------------------------------------------------------------------------

class _TechStack extends StatelessWidget {
  const _TechStack({required this.technologies});

  final List<String> technologies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.label(AppStrings.techStack),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children:
              technologies.map((t) => TechChip.primary(label: t)).toList(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// CTA buttons — GitHub link (if available) + secondary action
// ---------------------------------------------------------------------------

class _ProjectCtas extends StatefulWidget {
  const _ProjectCtas({required this.project});

  final ProjectModel project;

  @override
  State<_ProjectCtas> createState() => _ProjectCtasState();
}

class _ProjectCtasState extends State<_ProjectCtas> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        if (widget.project.githubUrl != null)
          SecondaryButton(
            label: AppStrings.viewOnGitHub,
            icon: Icons.code_rounded,
            onPressed: () {
              AnalyticsService.trackProjectClick(
                eventName: AnalyticsEvents.projectGithubClick,
                projectId: widget.project.id,
                projectName: widget.project.title,
                url: widget.project.githubUrl,
              );
              LinkLauncher.open(context, widget.project.githubUrl!);
            },
          ),
        if (widget.project.liveUrl != null)
          SecondaryButton(
            label: AppStrings.viewLive,
            icon: Icons.open_in_new_rounded,
            onPressed: () {
              AnalyticsService.trackProjectClick(
                eventName: AnalyticsEvents.projectLiveClick,
                projectId: widget.project.id,
                projectName: widget.project.title,
                url: widget.project.liveUrl,
              );
              LinkLauncher.open(context, widget.project.liveUrl!);
            },
          ),
        GhostButton(
          label: AppStrings.caseStudy,
          trailingIcon: Icons.arrow_forward_rounded,
          usePrimaryColor: true,
          onPressed: () {
            AnalyticsService.trackProjectClick(
              eventName: AnalyticsEvents.projectCaseStudyClick,
              projectId: widget.project.id,
              projectName: widget.project.title,
            );
            showDialog<void>(
              context: context,
              builder: (_) => const MechKonnectCaseStudyDialog(),
            );
          },
        ),
      ],
    );
  }
}
