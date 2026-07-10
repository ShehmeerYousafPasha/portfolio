import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../routes/app_routes.dart';

/// Data model for a single navigation destination.
///
/// Holds everything the nav bar and drawer need to render
/// and navigate to a route.
class NavDestination {
  const NavDestination({
    required this.label,
    required this.route,
    required this.icon,
    required this.activeIcon,
    this.showInDesktopNav = true,
  });

  final String label;
  final String route;
  final IconData icon;
  final IconData activeIcon;

  /// Some items (e.g. Home) may be hidden from the desktop top bar
  /// because the logo already acts as a home link.
  final bool showInDesktopNav;

  /// Returns true when [currentPath] matches this destination's route.
  bool isActive(String currentPath) {
    if (route == AppRoutes.home) return currentPath == route;
    return currentPath.startsWith(route);
  }

  // ---------------------------------------------------------------------------
  // Portfolio navigation destinations — order matches PROJECT_CONTEXT.md
  // ---------------------------------------------------------------------------
  static const List<NavDestination> all = [
    NavDestination(
      label: AppStrings.navHome,
      route: AppRoutes.home,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      showInDesktopNav: false, // Logo acts as home link on desktop
    ),
    NavDestination(
      label: AppStrings.navProjects,
      route: AppRoutes.projects,
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder_rounded,
    ),
    NavDestination(
      label: AppStrings.navExperience,
      route: AppRoutes.experience,
      icon: Icons.work_outline_rounded,
      activeIcon: Icons.work_rounded,
    ),
    NavDestination(
      label: AppStrings.navCertificates,
      route: AppRoutes.certificates,
      icon: Icons.verified_outlined,
      activeIcon: Icons.verified_rounded,
    ),
    NavDestination(
      label: AppStrings.navResume,
      route: AppRoutes.resume,
      icon: Icons.description_outlined,
      activeIcon: Icons.description_rounded,
    ),
    NavDestination(
      label: AppStrings.navContact,
      route: AppRoutes.contact,
      icon: Icons.mail_outline_rounded,
      activeIcon: Icons.mail_rounded,
    ),
  ];

  /// Desktop nav only shows destinations with [showInDesktopNav] = true.
  static List<NavDestination> get desktopItems =>
      all.where((d) => d.showInDesktopNav).toList();

  /// Drawer shows all destinations including Home.
  static List<NavDestination> get drawerItems => all;
}
