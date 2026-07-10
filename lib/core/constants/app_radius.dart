import 'package:flutter/material.dart';

/// Border radius tokens for the portfolio design system.
///
/// Uses a consistent scale from xs (pill chips) to full (pill shapes).
/// All widget-level radius values should come from here — never hardcoded.
abstract class AppRadius {
  AppRadius._();

  // ---------------------------------------------------------------------------
  // Scalar values
  // ---------------------------------------------------------------------------
  static const double xs = 4.0;    // Tags, inline badges
  static const double sm = 8.0;    // Buttons, inputs, small chips
  static const double md = 12.0;   // Cards, modals
  static const double lg = 16.0;   // Large cards, bottom sheets
  static const double xl = 24.0;   // Hero containers, feature cards
  static const double full = 999.0; // Pill shapes (badges, rounded buttons)

  // ---------------------------------------------------------------------------
  // BorderRadius shorthands — avoids verbose `BorderRadius.circular()` calls
  // ---------------------------------------------------------------------------
  static const BorderRadius xsBorderRadius =
      BorderRadius.all(Radius.circular(xs));

  static const BorderRadius smBorderRadius =
      BorderRadius.all(Radius.circular(sm));

  static const BorderRadius mdBorderRadius =
      BorderRadius.all(Radius.circular(md));

  static const BorderRadius lgBorderRadius =
      BorderRadius.all(Radius.circular(lg));

  static const BorderRadius xlBorderRadius =
      BorderRadius.all(Radius.circular(xl));

  static const BorderRadius fullBorderRadius =
      BorderRadius.all(Radius.circular(full));

  // ---------------------------------------------------------------------------
  // Radius shorthands (for ClipRRect, etc.)
  // ---------------------------------------------------------------------------
  static const Radius xsRadius = Radius.circular(xs);
  static const Radius smRadius = Radius.circular(sm);
  static const Radius mdRadius = Radius.circular(md);
  static const Radius lgRadius = Radius.circular(lg);
  static const Radius xlRadius = Radius.circular(xl);
  static const Radius fullRadius = Radius.circular(full);
}
