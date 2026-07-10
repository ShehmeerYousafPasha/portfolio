import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../services/analytics_service.dart';
import '../../../../services/file_download_service.dart';
import '../../../../services/link_launcher.dart';
import '../../../../shared/layouts/page_layout.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/section/section_header.dart';
import '../../../../shared/widgets/typography/app_text.dart';

/// Resume page — opens or downloads the CV PDF.
///
/// Renders inside [ShellPage] — no own [Scaffold].
/// Tracks both "open in browser" and "download" events via [AnalyticsService].
class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;
    final isDesktop = deviceTypeOf(context).isDesktop;

    return PageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.huge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Curriculum Vitae',
              title: AppStrings.sectionResume,
              subtitle: AppStrings.resumeDescription,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // ── Resume card ────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                responsiveValue<double>(
                  context,
                  mobile: AppSpacing.lg,
                  desktop: AppSpacing.xxxl,
                ),
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceCard
                    : AppColors.lightSurfaceCard,
                borderRadius: AppRadius.lgBorderRadius,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.20),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withValues(alpha: isDark ? 0.06 : 0.05),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: isDesktop
                  ? _DesktopLayout(isDark: isDark, cs: cs)
                  : _MobileLayout(isDark: isDark, cs: cs),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Availability note
            Center(
              child: AppText.bodySmall(
                'Last updated — 2025. Available in PDF format.',
                color: cs.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop — icon left, content right
// ---------------------------------------------------------------------------

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.isDark, required this.cs});
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ResumeIcon(isDark: isDark),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(child: _ResumeContent(isDark: isDark, cs: cs)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile — stacked
// ---------------------------------------------------------------------------

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.isDark, required this.cs});
  final bool isDark;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _ResumeIcon(isDark: isDark),
            const SizedBox(width: AppSpacing.md),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleLg('Resume / CV'),
                  AppText.muted('Shehmeer Yousaf'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _ResumeContent(isDark: isDark, cs: cs),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// PDF document icon badge
// ---------------------------------------------------------------------------

class _ResumeIcon extends StatelessWidget {
  const _ResumeIcon({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.description_rounded,
        size: 36,
        color: AppColors.primary,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Resume content — title, highlights, CTA buttons
// ---------------------------------------------------------------------------

class _ResumeContent extends StatelessWidget {
  const _ResumeContent({required this.isDark, required this.cs});
  final bool isDark;
  final ColorScheme cs;

  static const _highlights = [
    (Icons.work_rounded, 'App Developer (Flutter) — Seasonedly'),
    (Icons.school_rounded, 'BS Information Technology — IIUI, CGPA 3.56'),
    (
      Icons.verified_rounded,
      'Scrum Fundamentals · IBM Front-End · IBM Cybersecurity'
    ),
    (
      Icons.smartphone_rounded,
      'Production apps: transportation, logistics, delivery'
    ),
    (Icons.public_rounded, 'Open to remote opportunities worldwide'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.h3('Resume / CV'),
        const SizedBox(height: AppSpacing.sm),
        const AppText.muted('Shehmeer Yousaf — App Developer (Flutter)'),

        const SizedBox(height: AppSpacing.xl),

        // Highlights
        ..._highlights.map(
          (h) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(h.$1, size: 16, color: AppColors.primary),
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
        ),

        const SizedBox(height: AppSpacing.xl),

        // CTA buttons
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: [
            Tooltip(
              message: 'Opens the resume PDF in a new browser tab',
              child: PrimaryButton(
                label: AppStrings.openInBrowser,
                icon: Icons.open_in_new_rounded,
                onPressed: () {
                  AnalyticsService.trackResumeView();
                  LinkLauncher.open(context, AppAssets.resumePdf);
                },
              ),
            ),
            Tooltip(
              message: 'Downloads the resume PDF to your device',
              child: SecondaryButton(
                label: AppStrings.downloadResume,
                icon: Icons.download_rounded,
                onPressed: () {
                  AnalyticsService.trackResumeDownload();
                  FileDownloadService.download(
                    urlOrPath: AppAssets.resumePdf,
                    fileName: AppAssets.resumePdfFileName,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
