import 'package:flutter/material.dart';

/// Centralized color definitions for Shehmeer Yousaf's portfolio.
///
/// All colors follow a systematic naming convention:
/// - `dark*` / `light*` prefix for theme-specific colors
/// - No prefix for semantic or brand colors
///
/// Brand primary: #075448 — deep viridian inspired by the portfolio palette.
abstract class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF075448);
  static const Color primaryVariant = Color(0xFF043D34);
  static const Color primaryAccent = Color(0xFF0A6B59);
  static const Color primaryContainer = Color(0xFFC9E5DD);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Dark Theme — Surfaces
  // ---------------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF090909);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkSurfaceElevated = Color(0xFF181818);
  static const Color darkSurfaceCard = Color(0xFF1C1C1C);
  static const Color darkBorder = Color(0xFF242424);
  static const Color darkBorderSubtle = Color(0xFF1A1A1A);
  static const Color darkDivider = Color(0xFF1E1E1E);

  // ---------------------------------------------------------------------------
  // Light Theme — Surfaces
  // ---------------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFF6F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF0F2F5);
  static const Color lightSurfaceCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE1E4E8);
  static const Color lightBorderSubtle = Color(0xFFEEF1F5);
  static const Color lightDivider = Color(0xFFE8ECF0);

  // ---------------------------------------------------------------------------
  // Dark Theme — Text
  // ---------------------------------------------------------------------------
  static const Color darkTextPrimary = Color(0xFFEDEDED);
  static const Color darkTextSecondary = Color(0xFF858585);
  static const Color darkTextTertiary = Color(0xFF4A4A4A);
  static const Color darkTextDisabled = Color(0xFF333333);

  // ---------------------------------------------------------------------------
  // Light Theme — Text
  // ---------------------------------------------------------------------------
  static const Color lightTextPrimary = Color(0xFF0F1117);
  static const Color lightTextSecondary = Color(0xFF4A5568);
  static const Color lightTextTertiary = Color(0xFF718096);
  static const Color lightTextDisabled = Color(0xFFB0BBC8);

  // ---------------------------------------------------------------------------
  // Semantic / Status
  // ---------------------------------------------------------------------------
  static const Color success = primary;
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ---------------------------------------------------------------------------
  // Special
  // ---------------------------------------------------------------------------
  static const Color openToWork = primary;
  static const Color transparent = Colors.transparent;
}
