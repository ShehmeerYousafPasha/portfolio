import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_shadows.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/layouts/page_layout.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/common/theme_toggle_button.dart';
import '../../../../shared/widgets/typography/app_text.dart';
import 'nav_destination.dart';

/// The main navigation bar — persistent across all pages via [ShellPage].
///
/// Behaviour:
/// - Transparent when at scroll top → solid frosted surface when scrolled
/// - Desktop (≥1024): logo + inline links + theme toggle + "Hire Me" CTA
/// - Tablet (600–1024): logo + reduced links + theme toggle + "Hire Me"
/// - Mobile (<600): logo + theme toggle + hamburger → opens drawer
///
/// Active route is derived live from [GoRouterState] — no manual state needed.
class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.isScrolled,
    this.onMenuTap,
  });

  final bool isScrolled;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final currentPath = GoRouterState.of(context).uri.path;
    final deviceType = deviceTypeOf(context);

    // Scroll-aware background: transparent → semi-opaque surface
    final bgColor = isScrolled
        ? (isDark ? const Color(0xE8111111) : const Color(0xF2FFFFFF))
        : Colors.transparent;

    return AnimatedContainer(
      duration: AppDurations.navScroll,
      curve: AppDurations.standard,
      height: AppSpacing.navHeight,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? cs.outlineVariant : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: isScrolled ? AppShadows.nav(context) : const [],
      ),
      child: PageLayout(
        child: Row(
          children: [
            // ── Logo / Brand ──────────────────────────────────────────────
            const _NavLogo(),
            const Spacer(),

            // ── Desktop inline nav links ──────────────────────────────────
            if (deviceType.isDesktop) ...[
              _DesktopNavLinks(currentPath: currentPath),
              const SizedBox(width: AppSpacing.lg),
            ],

            // ── Theme toggle ──────────────────────────────────────────────
            const ThemeToggleButton(),

            // ── "Hire Me" CTA (desktop only) ──────────────────────────────
            if (deviceType.isDesktop) ...[
              const SizedBox(width: AppSpacing.sm),
              PrimaryButton(
                label: AppStrings.hireMe,
                size: ButtonSize.small,
                onPressed: () => context.go(AppRoutes.contact),
              ),
            ],

            // ── Mobile hamburger ──────────────────────────────────────────
            if (!deviceType.isDesktop)
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu_rounded),
                iconSize: 22,
                tooltip: 'Open menu',
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Logo / Brand mark
// ---------------------------------------------------------------------------

class _NavLogo extends StatefulWidget {
  const _NavLogo();

  @override
  State<_NavLogo> createState() => _NavLogoState();
}

class _NavLogoState extends State<_NavLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: AnimatedOpacity(
          opacity: _isHovered ? 0.65 : 1.0,
          duration: AppDurations.hoverTransition,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // "SY" initials badge
              Container(
                width: 32,
                height: 32,
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
                        letterSpacing: 0.5,
                      ),
                ),
              ),
              // Name text — hidden on very small screens to avoid overflow
              if (screenWidth >= 380) ...[
                const SizedBox(width: 10),
                const AppText.titleMd('Shehmeer Yousaf Pasha'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop horizontal nav links row
// ---------------------------------------------------------------------------

class _DesktopNavLinks extends StatelessWidget {
  const _DesktopNavLinks({required this.currentPath});
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: NavDestination.desktopItems
          .map(
            (dest) => _DesktopNavItem(
              destination: dest,
              isActive: dest.isActive(currentPath),
            ),
          )
          .toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Individual desktop nav item with hover + active indicator
// ---------------------------------------------------------------------------

class _DesktopNavItem extends StatefulWidget {
  const _DesktopNavItem({
    required this.destination,
    required this.isActive,
  });

  final NavDestination destination;
  final bool isActive;

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isHighlighted = widget.isActive || _isHovered;
    final textColor = isHighlighted ? cs.primary : cs.onSurfaceVariant;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.destination.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Label
              AnimatedDefaultTextStyle(
                duration: AppDurations.hoverTransition,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: widget.isActive
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
                child: Text(widget.destination.label),
              ),

              const SizedBox(height: 3),

              // Active / hover underline dot
              AnimatedContainer(
                duration: AppDurations.hoverTransition,
                curve: AppDurations.hover,
                width: widget.isActive ? 20 : (_isHovered ? 8 : 0),
                height: 2,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: AppRadius.fullBorderRadius,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
