import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../shared/widgets/buttons/icon_text_button.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../../shared/widgets/buttons/secondary_button.dart';

/// The four Hero CTAs specified in PROJECT_CONTEXT.md, arranged in a
/// two-tier visual hierarchy:
///
/// Tier 1 (primary intent) — "Hire Me" (solid) + "View Projects" (outlined)
/// Tier 2 (supporting)     — "Resume" + "Contact Me" (compact icon links)
///
/// Both tiers use [Wrap] rather than a fixed [Row], so buttons reflow
/// onto a new line automatically on narrow screens — no overflow,
/// no manual breakpoint branching required.
///
/// [centered] controls whether the rows align left (desktop, beside
/// the photo) or center (mobile/tablet, stacked under the photo).
class HeroCtaButtons extends StatelessWidget {
  const HeroCtaButtons({super.key, required this.centered});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    final wrapAlignment =
        centered ? WrapAlignment.center : WrapAlignment.start;

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // ── Tier 1: Primary intent ───────────────────────────────────────
        Wrap(
          alignment: wrapAlignment,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: [
            PrimaryButton(
              label: AppStrings.hireMe,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.go(AppRoutes.contact),
            ),
            SecondaryButton(
              label: AppStrings.viewProjects,
              icon: Icons.folder_open_outlined,
              onPressed: () => context.go(AppRoutes.projects),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // ── Tier 2: Supporting actions ───────────────────────────────────
        Wrap(
          alignment: wrapAlignment,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            IconTextButton(
              label: AppStrings.heroResume,
              icon: Icons.description_outlined,
              onPressed: () => context.go(AppRoutes.resume),
            ),
            IconTextButton(
              label: AppStrings.contactMe,
              icon: Icons.mail_outline_rounded,
              onPressed: () => context.go(AppRoutes.contact),
            ),
          ],
        ),
      ],
    );
  }
}
