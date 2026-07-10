import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/widgets/section/section_container.dart';
import '../../../../shared/widgets/section/section_header.dart';
import '../../../../shared/widgets/typography/app_text.dart';

/// A concise portfolio case study for the featured MechKonnect project.
class MechKonnectCaseStudySection extends StatelessWidget {
  const MechKonnectCaseStudySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      id: 'mechkonnect-case-study',
      isAlternate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: 'Case Study',
            title: 'MechKonnect — Auto Service Hub',
            subtitle:
                'A mobile platform that makes automotive services more accessible, transparent, and efficient.',
          ),
          SizedBox(height: AppSpacing.xxl),
          _CaseStudyGrid(),
          SizedBox(height: AppSpacing.lg),
          _CaseStudyCard(
            icon: Icons.auto_awesome_rounded,
            title: 'What’s next',
            body:
                'Future opportunities include push notifications, an admin dashboard, mechanic scheduling, in-app payments, a spare-parts marketplace, and smarter mechanic matching.',
          ),
        ],
      ),
    );
  }
}

/// Scrollable dialog used by the featured project's Case Study action.
class MechKonnectCaseStudyDialog extends StatelessWidget {
  const MechKonnectCaseStudyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.sizeOf(context);
    final isCompact = screenSize.width < 600;

    return Dialog(
      insetPadding: EdgeInsets.all(isCompact ? AppSpacing.md : AppSpacing.xxl),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 960,
          maxHeight: screenSize.height * 0.88,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isCompact ? AppSpacing.lg : AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: SectionHeader(
                      eyebrow: 'Case Study',
                      title: 'MechKonnect — Auto Service Hub',
                      subtitle:
                          'A mobile platform that makes automotive services more accessible, transparent, and efficient.',
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close case study',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              const _CaseStudyGrid(),
              const SizedBox(height: AppSpacing.lg),
              const _CaseStudyCard(
                icon: Icons.auto_awesome_rounded,
                title: 'What’s next',
                body:
                    'Future opportunities include push notifications, an admin dashboard, mechanic scheduling, in-app payments, a spare-parts marketplace, and smarter mechanic matching.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CaseStudyGrid extends StatelessWidget {
  const _CaseStudyGrid();

  @override
  Widget build(BuildContext context) {
    const cards = [
      _CaseStudyCard(
        icon: Icons.error_outline_rounded,
        title: 'The problem',
        body:
            'Vehicle owners often rely on referrals, calls, and workshop visits to find a mechanic. This fragmented process provides little visibility into availability, progress, or maintenance history.',
      ),
      _CaseStudyCard(
        icon: Icons.lightbulb_outline_rounded,
        title: 'The solution',
        body:
            'MechKonnect brings booking, communication, tracking, vehicle records, and maintenance reminders into one mobile experience for vehicle owners and mechanics.',
      ),
      _CaseStudyCard(
        icon: Icons.checklist_rounded,
        title: 'Key features',
        body:
            'Role-based onboarding, nearby mechanic discovery, service booking, live location updates, in-app chat, vehicle management, service history, and mileage-based reminders.',
      ),
      _CaseStudyCard(
        icon: Icons.code_rounded,
        title: 'Technology',
        body:
            'Flutter and Dart power a shared mobile codebase. Supabase provides authentication, PostgreSQL storage, realtime communication, and Row-Level Security. OpenStreetMap enables location tracking.',
      ),
      _CaseStudyCard(
        icon: Icons.groups_rounded,
        title: 'My contribution',
        body:
            'As part of the final-year project team, I helped design and develop the mobile experience, backend integration, role-based navigation, and core booking and vehicle-management flows.',
      ),
      _CaseStudyCard(
        icon: Icons.trending_up_rounded,
        title: 'Outcome',
        body:
            'The project delivered a scalable foundation for digital automotive services, replacing manual interactions with clearer booking workflows, live service visibility, and centralized vehicle-care records.',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 760 ? 2 : 1;
        final width = (constraints.maxWidth - AppSpacing.lg * (columns - 1)) /
            columns;

        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: cards
              .map((card) => SizedBox(width: width, child: card))
              .toList(),
        );
      },
    );
  }
}

class _CaseStudyCard extends StatelessWidget {
  const _CaseStudyCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: AppRadius.lgBorderRadius,
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: AppSpacing.md),
          AppText.h3(title),
          const SizedBox(height: AppSpacing.sm),
          AppText.body(body, color: colors.onSurfaceVariant),
        ],
      ),
    );
  }
}
