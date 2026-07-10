import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/profile.dart';
import '../../../data/socials.dart';
import '../../../data/models/social_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/link_launcher.dart';
import '../../layouts/page_layout.dart';
import '../../layouts/responsive_layout.dart';
import '../typography/app_text.dart';
import 'app_divider.dart';

/// Portfolio footer — rendered at the bottom of every page via [ShellPage].
///
/// Desktop layout (3 columns):
///   [Brand + tagline]   [Quick navigation]   [Connect / social links]
///
/// Mobile layout (stacked):
///   Brand → Nav links → Social → Copyright
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final footerBg = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF0F2F5);

    return ColoredBox(
      color: footerBg,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDivider(),
          PageLayout(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.xxxl,
              ),
              child: ResponsiveLayout(
                mobile: _MobileFooterLayout(),
                tablet: _MobileFooterLayout(),
                desktop: _DesktopFooterLayout(),
              ),
            ),
          ),
          AppDivider(),
          // Copyright bar
          _CopyrightBar(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop three-column layout
// ---------------------------------------------------------------------------

class _DesktopFooterLayout extends StatelessWidget {
  const _DesktopFooterLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Brand
        Expanded(flex: 3, child: _BrandColumn()),
        SizedBox(width: AppSpacing.xxl),
        // Column 2: Navigation
        Expanded(flex: 2, child: _NavigationColumn()),
        SizedBox(width: AppSpacing.xxl),
        // Column 3: Connect
        Expanded(flex: 2, child: _ConnectColumn()),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile stacked layout
// ---------------------------------------------------------------------------

class _MobileFooterLayout extends StatelessWidget {
  const _MobileFooterLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandColumn(),
        SizedBox(height: AppSpacing.xxl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _NavigationColumn()),
            SizedBox(width: AppSpacing.xl),
            Expanded(child: _ConnectColumn()),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Brand column
// ---------------------------------------------------------------------------

class _BrandColumn extends StatelessWidget {
  const _BrandColumn();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo mark + name
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.smBorderRadius,
              ),
              alignment: Alignment.center,
              child: Text(
                'SY',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(width: 10),
            AppText.titleLg(profileData.name),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        AppText.muted(profileData.title),

        const SizedBox(height: AppSpacing.sm),

        AppText.bodySmall(
          '${profileData.locationLine} · ${profileData.country}',
          color: cs.onSurfaceVariant.withValues(alpha: 0.6),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Availability tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: AppRadius.fullBorderRadius,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: AppText.labelSmall(
            profileData.availability,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Navigation column
// ---------------------------------------------------------------------------

class _NavigationColumn extends StatelessWidget {
  const _NavigationColumn();

  static const _links = [
    (AppStrings.navHome, AppRoutes.home),
    (AppStrings.navProjects, AppRoutes.projects),
    (AppStrings.navExperience, AppRoutes.experience),
    (AppStrings.navCertificates, AppRoutes.certificates),
    (AppStrings.navResume, AppRoutes.resume),
    (AppStrings.navContact, AppRoutes.contact),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelSmall(
          'NAVIGATION',
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: AppSpacing.md),
        ..._links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _FooterLink(label: link.$1, route: link.$2),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Connect / social column
// ---------------------------------------------------------------------------

class _ConnectColumn extends StatelessWidget {
  const _ConnectColumn();

  @override
  Widget build(BuildContext context) {
    final primarySocials = socialsData.where((s) => s.isPrimary).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelSmall(
          'CONNECT',
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: AppSpacing.md),
        ...primarySocials.map(
          (social) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _SocialFooterLink(social: social),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Footer nav link
// ---------------------------------------------------------------------------

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.route});
  final String label;
  final String route;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 120),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: _isHovered ? cs.primary : cs.onSurfaceVariant,
              ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Social footer link
// ---------------------------------------------------------------------------

class _SocialFooterLink extends StatefulWidget {
  const _SocialFooterLink({required this.social});
  final SocialModel social;

  @override
  State<_SocialFooterLink> createState() => _SocialFooterLinkState();
}

class _SocialFooterLinkState extends State<_SocialFooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final icon = _iconFor(widget.social.platform);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => LinkLauncher.open(context, widget.social.url),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              child: Icon(
                icon,
                size: 14,
                color: _isHovered ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 120),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: _isHovered ? cs.primary : cs.onSurfaceVariant,
                  ),
              child: Text(
                widget.social.platform.displayName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(SocialPlatform platform) => switch (platform) {
        SocialPlatform.github => Icons.code_rounded,
        SocialPlatform.linkedin => Icons.link_rounded,
        SocialPlatform.email => Icons.mail_outline_rounded,
        SocialPlatform.whatsapp => Icons.chat_bubble_outline_rounded,
        SocialPlatform.twitter => Icons.alternate_email_rounded,
        SocialPlatform.website => Icons.language_rounded,
      };
}

// ---------------------------------------------------------------------------
// Copyright bar
// ---------------------------------------------------------------------------

class _CopyrightBar extends StatelessWidget {
  const _CopyrightBar();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final year = DateTime.now().year;

    return PageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xs,
          children: [
            AppText.bodySmall(
              '© $year ${profileData.name}. All rights reserved.',
              color: cs.onSurfaceVariant.withValues(alpha: 0.55),
            ),
            AppText.bodySmall(
              'Built with Flutter',
              color: cs.onSurfaceVariant.withValues(alpha: 0.55),
            ),
          ],
        ),
      ),
    );
  }
}
