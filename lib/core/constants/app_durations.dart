import 'package:flutter/material.dart';

/// Animation duration tokens for the portfolio design system.
///
/// Philosophy:
/// - Micro-interactions (hovers, focus): fastest / fast
/// - State transitions (page entry, section reveal): normal
/// - Long reveals (skeleton → content): slow
/// - Avoid anything over 500ms — this is a professional portfolio, not a game.
abstract class AppDurations {
  AppDurations._();

  // ---------------------------------------------------------------------------
  // Duration constants
  // ---------------------------------------------------------------------------
  static const Duration instant  = Duration(milliseconds: 0);
  static const Duration fastest  = Duration(milliseconds: 80);
  static const Duration fast     = Duration(milliseconds: 150);
  static const Duration normal   = Duration(milliseconds: 250);
  static const Duration slow     = Duration(milliseconds: 350);
  static const Duration slower   = Duration(milliseconds: 500);

  // ---------------------------------------------------------------------------
  // Semantic aliases
  // ---------------------------------------------------------------------------

  /// Hover enter/exit transitions on cards and buttons.
  static const Duration hoverTransition = fast;

  /// Button press state change.
  static const Duration buttonPress = fastest;

  /// Section fade-in on scroll into view.
  static const Duration sectionReveal = normal;

  /// Nav bar background appearing on scroll.
  static const Duration navScroll = fast;

  /// Theme switch (light ↔ dark).
  static const Duration themeSwitch = normal;

  /// Skeleton / shimmer → content swap.
  static const Duration contentLoad = slow;

  // ---------------------------------------------------------------------------
  // Curves — paired with durations
  // ---------------------------------------------------------------------------

  /// Standard ease for most transitions.
  static const Curve standard = Curves.easeInOut;

  /// Snappy entry animation.
  static const Curve entry = Curves.easeOut;

  /// Subtle exit animation.
  static const Curve exit = Curves.easeIn;

  /// Hover scale effect — feels physical.
  static const Curve hover = Curves.easeOutCubic;
}
