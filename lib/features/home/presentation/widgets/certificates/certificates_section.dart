import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/certificate_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/badges/tech_chip.dart';
import '../../../../../shared/widgets/cards/hover_card.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';
import '../../../../../services/link_launcher.dart';

/// Certifications section — Scrum Fundamentals, IBM Front-End
/// Development, IBM Cybersecurity.
///
/// Source data: [allCertificatesProvider].
/// Renders each [CertificateModel] as a [HoverCard] tile containing
/// an issuer badge, title, optional date, skill chips, and a
/// "View Credential" link (shown only when [credentialUrl] is set).
///
/// Layout: 1 column mobile · 2 columns tablet · 3 columns desktop.
/// New certificates added to the data layer appear automatically.
///
/// Sits on an alternate background — continues the alternating rhythm
/// after the base-background Education section.
class CertificatesSection extends ConsumerWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certsAsync = ref.watch(allCertificatesProvider);

    return SectionContainer(
      id: 'certifications',
      isAlternate: true,
      child: AsyncValueWidget<List<CertificateModel>>(
        value: certsAsync,
        data: (certs) {
          if (certs.isEmpty) return const _EmptyState();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'Professional Development',
                title: AppStrings.sectionCertifications,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _CertificatesGrid(certificates: certs),
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

class _CertificatesGrid extends StatelessWidget {
  const _CertificatesGrid({required this.certificates});

  final List<CertificateModel> certificates;

  @override
  Widget build(BuildContext context) {
    final columns = responsiveValue<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    const spacing = AppSpacing.md;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: certificates
              .map(
                (cert) => SizedBox(
                  width: cardWidth,
                  child: _CertificateCard(certificate: cert),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Individual certificate card
// ---------------------------------------------------------------------------

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.certificate});

  final CertificateModel certificate;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      onTap: certificate.credentialUrl == null
          ? null
          : () => LinkLauncher.open(context, certificate.credentialUrl!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header: issuer badge + verified icon ──────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IssuerBadge(issuer: certificate.issuer),
              const Spacer(),
              const _VerifiedBadge(),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Title ──────────────────────────────────────────────────────
          AppText.titleLg(certificate.title, maxLines: 2),

          const SizedBox(height: 4),

          // ── Issuer name ────────────────────────────────────────────────
          AppText.muted(certificate.issuer),

          // ── Issued date ────────────────────────────────────────────────
          if (certificate.issuedDate != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                AppText.bodySmall(certificate.issuedDate!),
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          // ── Skill chips ────────────────────────────────────────────────
          if (certificate.skills.isNotEmpty) ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children:
                  certificate.skills.map((s) => TechChip(label: s)).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── Credential link ────────────────────────────────────────────
          _CredentialLink(
            credentialId: certificate.credentialId,
            credentialUrl: certificate.credentialUrl,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Issuer badge — coloured initial based on issuer name
// ---------------------------------------------------------------------------

class _IssuerBadge extends StatelessWidget {
  const _IssuerBadge({required this.issuer});

  final String issuer;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _colorForIssuer(issuer);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.18 : 0.12),
        borderRadius: AppRadius.smBorderRadius,
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        issuer.substring(0, 1).toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  /// Gives each issuer a consistent accent colour so the grid is
  /// visually varied without being random or noisy.
  Color _colorForIssuer(String issuer) => switch (issuer) {
        'IBM' => const Color(0xFF0530AD), // IBM blue
        'SCRUMstudy' => const Color(0xFFE85D04), // warm orange
        'Coursera' => const Color(0xFF0056D3),
        'Google' => const Color(0xFF34A853),
        'Meta' => const Color(0xFF1877F2),
        _ => AppColors.primary,
      };
}

// ---------------------------------------------------------------------------
// Small "Verified" checkmark badge
// ---------------------------------------------------------------------------

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.14 : 0.09),
        borderRadius: AppRadius.fullBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 12, color: AppColors.primary),
          SizedBox(width: 4),
          AppText.labelSmall(AppStrings.verified, color: AppColors.primary),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Credential ID + view link (shown only when URL is set)
// ---------------------------------------------------------------------------

class _CredentialLink extends StatefulWidget {
  const _CredentialLink({
    required this.credentialId,
    required this.credentialUrl,
  });

  final String? credentialId;
  final String? credentialUrl;

  @override
  State<_CredentialLink> createState() => _CredentialLinkState();
}

class _CredentialLinkState extends State<_CredentialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // No credential info at all — show a neutral placeholder
    if (widget.credentialId == null && widget.credentialUrl == null) {
      return Row(
        children: [
          Icon(
            Icons.badge_outlined,
            size: 14,
            color: cs.onSurfaceVariant.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 6),
          AppText.bodySmall(
            AppStrings.credentialOnFile,
            color: cs.onSurfaceVariant.withValues(alpha: 0.45),
          ),
        ],
      );
    }

    final color = _isHovered ? AppColors.primary : cs.onSurfaceVariant;

    return MouseRegion(
      cursor: widget.credentialUrl != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.credentialUrl != null
            ? () => LinkLauncher.open(context, widget.credentialUrl!)
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              child: Icon(
                Icons.open_in_new_rounded,
                size: 14,
                color: color,
              ),
            ),
            const SizedBox(width: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 120),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: color,
                  ),
              child: Text(
                widget.credentialId != null
                    ? 'ID: ${widget.credentialId}'
                    : 'View Credential',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state
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
            Icon(
              Icons.workspace_premium_outlined,
              size: 40,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppText.muted(AppStrings.emptyCertificates),
          ],
        ),
      ),
    );
  }
}
