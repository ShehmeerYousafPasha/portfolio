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
import '../../../../../shared/widgets/cards/hover_card.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';
import '../../../../../services/analytics_service.dart';
import '../../../../../services/analytics_events.dart';
import '../../../../../services/link_launcher.dart';

/// Other Projects section — the non-featured project grid.
///
/// Renders every [ProjectModel] where [ProjectModel.isFeatured] is false
/// (GPA & CGPA Calculator, Library Management System Web/Desktop,
/// Virtual System Setup) as equal-weight [HoverCard] tiles.
///
/// Layout: 1 column mobile · 2 columns tablet · 3 columns desktop.
/// New projects added to the data layer appear automatically — no UI
/// changes required.
///
/// Source data: [otherProjectsProvider].
/// Sits on an alternate background for visual rhythm after the base-
/// background Featured Project section.
class OtherProjectsSection extends ConsumerWidget {
  const OtherProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(otherProjectsProvider);

    return SectionContainer(
      id: 'other-projects',
      isAlternate: true,
      child: AsyncValueWidget<List<ProjectModel>>(
        value: projectsAsync,
        data: (projects) {
          if (projects.isEmpty) {
            return const _EmptyState();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'More Work',
                title: AppStrings.sectionOtherProjects,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _ProjectsGrid(projects: projects),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Responsive grid
// ---------------------------------------------------------------------------

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.projects});

  final List<ProjectModel> projects;

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
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects
              .map(
                (p) => SizedBox(
                  width: cardWidth,
                  child: _ProjectCard(project: p),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Individual project card
// ---------------------------------------------------------------------------

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final openUrl = project.githubUrl ?? project.liveUrl;

    return HoverCard(
      onTap: openUrl == null
          ? null
          : () {
              if (project.githubUrl != null) {
                AnalyticsService.trackProjectClick(
                  eventName: AnalyticsEvents.projectGithubClick,
                  projectId: project.id,
                  projectName: project.title,
                  url: project.githubUrl,
                );
              } else if (project.liveUrl != null) {
                AnalyticsService.trackProjectClick(
                  eventName: AnalyticsEvents.projectLiveClick,
                  projectId: project.id,
                  projectName: project.title,
                  url: project.liveUrl,
                );
              }
              LinkLauncher.open(context, openUrl);
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header row: icon + status ──────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProjectIcon(title: project.title),
              const Spacer(),
              _StatusIndicator(status: project.status),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Title ──────────────────────────────────────────────────────
          AppText.titleLg(project.title, maxLines: 2),

          const SizedBox(height: AppSpacing.sm),

          // ── Short description ──────────────────────────────────────────
          AppText.muted(
            project.shortDescription,
            maxLines: 3,
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Tech chips ─────────────────────────────────────────────────
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children:
                project.technologies.map((t) => TechChip(label: t)).toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Action links ───────────────────────────────────────────────
          _CardActions(project: project),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Project icon — first letter of title on a branded background
// ---------------------------------------------------------------------------

class _ProjectIcon extends StatelessWidget {
  const _ProjectIcon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: AppRadius.smBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        title.substring(0, 1).toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Compact status indicator (chip variant)
// ---------------------------------------------------------------------------

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      ProjectStatus.completed => const StatusBadge.completed(),
      ProjectStatus.inProgress => const StatusBadge.inProgress(),
      ProjectStatus.archived => StatusBadge(
          label: 'Archived',
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
    };
  }
}

// ---------------------------------------------------------------------------
// Card action links — GitHub · Live (shown only when URL exists)
// ---------------------------------------------------------------------------

class _CardActions extends StatelessWidget {
  const _CardActions({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hasGithub = project.githubUrl != null;
    final hasLive = project.liveUrl != null;

    // If no links at all, show a neutral "in portfolio" label
    if (!hasGithub && !hasLive) {
      return Row(
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 14,
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 6),
          AppText.bodySmall(
            AppStrings.portfolioProject,
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ],
      );
    }

    return Row(
      children: [
        if (hasGithub)
          _ActionLink(
            label: AppStrings.viewOnGitHub,
            icon: Icons.code_rounded,
            onTap: () {
              AnalyticsService.trackProjectClick(
                eventName: AnalyticsEvents.projectGithubClick,
                projectId: project.id,
                projectName: project.title,
                url: project.githubUrl,
              );
              LinkLauncher.open(context, project.githubUrl!);
            },
            isDark: isDark,
          ),
        if (hasGithub && hasLive) const SizedBox(width: AppSpacing.md),
        if (hasLive)
          _ActionLink(
            label: AppStrings.viewLive,
            icon: Icons.open_in_new_rounded,
            onTap: () {
              AnalyticsService.trackProjectClick(
                eventName: AnalyticsEvents.projectLiveClick,
                projectId: project.id,
                projectName: project.title,
                url: project.liveUrl,
              );
              LinkLauncher.open(context, project.liveUrl!);
            },
            isDark: isDark,
          ),
      ],
    );
  }
}

class _ActionLink extends StatefulWidget {
  const _ActionLink({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  State<_ActionLink> createState() => _ActionLinkState();
}

class _ActionLinkState extends State<_ActionLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _isHovered
        ? AppColors.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 120),
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: color,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                child: Icon(widget.icon, size: 14, color: color),
              ),
              const SizedBox(width: 5),
              Text(widget.label),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state — shown when no non-featured projects exist
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.huge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_outlined,
                size: 40, color: cs.onSurfaceVariant),
            const SizedBox(height: AppSpacing.md),
            const AppText.muted(AppStrings.emptyProjects),
          ],
        ),
      ),
    );
  }
}
