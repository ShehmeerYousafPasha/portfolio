import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_durations.dart';

/// Custom page transition builders for [GoRouter].
///
/// Design rule: subtle, professional — no dramatic slides or bounces.
/// All transitions use [AppDurations.sectionReveal] (250ms) with easeOut.
///
/// Usage inside GoRoute:
/// ```dart
/// GoRoute(
///   path: AppRoutes.projects,
///   pageBuilder: (context, state) => AppPageTransitions.buildPage(
///     key: state.pageKey,
///     child: const ProjectsPage(),
///   ),
/// )
/// ```
abstract class AppPageTransitions {
  AppPageTransitions._();

  /// Fade-only transition — used between all top-level portfolio routes.
  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: AppDurations.entry,
      ),
      child: child,
    );
  }

  /// Fade + 16px upward slide — for content that enters the viewport.
  /// Slightly more dynamic than pure fade; still professional.
  static Widget fadeSlideUp(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnim = CurvedAnimation(
      parent: animation,
      curve: AppDurations.entry,
    );

    return FadeTransition(
      opacity: curvedAnim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.025),
          end: Offset.zero,
        ).animate(curvedAnim),
        child: child,
      ),
    );
  }

  /// Wraps a child in a [CustomTransitionPage] with [fadeSlideUp].
  /// Convenience method so each GoRoute doesn't repeat transition boilerplate.
  static CustomTransitionPage<void> buildPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: AppDurations.sectionReveal,
      reverseTransitionDuration: AppDurations.fast,
      transitionsBuilder: fadeSlideUp,
    );
  }
}
