import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../data/profile.dart';
import '../../../../shared/widgets/badges/open_to_work_badge.dart';
import '../../../../shared/widgets/common/app_divider.dart';
import '../../../../shared/widgets/common/theme_toggle_button.dart';
import '../../../../shared/widgets/typography/app_text.dart';
import 'nav_destination.dart';

/// Slide-in navigation drawer for mobile and tablet breakpoints.
///
/// Structure (top → bottom):
/// 1. Header — name, title, Open To Work badge
/// 2. Navigation items — all destinations with icons
/// 3. Divider
/// 4. Theme toggle row
/// 5. Social quick-links (GitHub, LinkedIn, WhatsApp, Email)
/// 6. Version / build note
///
/// Tapping a nav item navigates and closes the drawer automatically.
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentPath = GoRouterState.of(context).uri.path;

    final drawerBg =
        isDark ? const Color(0xFF111111) : theme.colorScheme.surface;

    return Drawer(
      backgroundColor: drawerBg,
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: AppRadius.lgRadius,
          bottomRight: AppRadius.lgRadius,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            const _DrawerHeader(),

            const AppDivider(),

            // ── Navigation items ──────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                children: [
                  ...NavDestination.drawerItems.map(
                    (dest) => _DrawerNavItem(
                      destination: dest,
                      isActive: dest.isActive(currentPath),
                      onTap: () {
                        Navigator.of(context).pop(); // close drawer
                        context.go(dest.route);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const AppDivider(),

            // ── Footer ────────────────────────────────────────────────────
            const _DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Drawer header — profile identity
// ---------------------------------------------------------------------------

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "SY" initials badge
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  'SY',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close menu',
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Name
          AppText.titleLg(profileData.name),

          const SizedBox(height: 2),

          // Title
          AppText.muted(profileData.title),

          const SizedBox(height: AppSpacing.md),

          // Open to work badge
          if (profileData.isOpenToWork) const OpenToWorkBadge(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Individual drawer nav item
// ---------------------------------------------------------------------------

class _DrawerNavItem extends StatelessWidget {
  const _DrawerNavItem({
    required this.destination,
    required this.isActive,
    required this.onTap,
  });

  final NavDestination destination;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeBg = isDark
        ? AppColors.primary.withValues(alpha: 0.12)
        : AppColors.primary.withValues(alpha: 0.08);

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.smBorderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: cs.primary.withValues(alpha: 0.08),
          borderRadius: AppRadius.smBorderRadius,
          child: AnimatedContainer(
            duration: AppDurations.hoverTransition,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isActive ? activeBg : Colors.transparent,
              borderRadius: AppRadius.smBorderRadius,
              border: isActive
                  ? Border.all(
                      color: AppColors.primary.withValues(alpha: 0.20),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: [
                // Active indicator bar
                AnimatedContainer(
                  duration: AppDurations.hoverTransition,
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.transparent,
                    borderRadius: AppRadius.fullBorderRadius,
                  ),
                ),
                const SizedBox(width: 12),

                // Icon
                Icon(
                  isActive ? destination.activeIcon : destination.icon,
                  size: 20,
                  color: isActive ? cs.primary : cs.onSurfaceVariant,
                ),
                const SizedBox(width: 14),

                // Label
                Text(
                  destination.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isActive ? cs.primary : cs.onSurface,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Drawer footer — theme toggle + social links
// ---------------------------------------------------------------------------

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeLabel =
        isDark ? AppStrings.switchToLight : AppStrings.switchToDark;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme row — label reflects current state
          Row(
            children: [
              AppText.muted(themeLabel),
              const Spacer(),
              const ThemeToggleButton(),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Quick social links
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SocialIconButton(
                icon: Icons.code_rounded,
                tooltip: 'GitHub',
                url: profileData.githubUrl,
              ),
              const SizedBox(width: AppSpacing.sm),
              _SocialIconButton(
                icon: Icons.link_rounded,
                tooltip: 'LinkedIn',
                url: profileData.linkedinUrl,
              ),
              const SizedBox(width: AppSpacing.sm),
              _SocialIconButton(
                icon: Icons.chat_rounded,
                tooltip: 'WhatsApp',
                url: profileData.whatsappUrl,
              ),
              const SizedBox(width: AppSpacing.sm),
              _SocialIconButton(
                icon: Icons.mail_outline_rounded,
                tooltip: 'Email',
                url: 'mailto:${profileData.email}',
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Build note
          AppText.bodySmall(
            'Built with Flutter · ${profileData.name}',
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

// Compact icon-only social button for the drawer footer
class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.url,
  });

  final IconData icon;
  final String tooltip;
  final String url;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: AppRadius.smBorderRadius,
        onTap: () async {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          );
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: AppRadius.smBorderRadius,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: cs.onSurfaceVariant),
        ),
      ),
    );
  }
}
