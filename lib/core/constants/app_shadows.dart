import 'package:flutter/material.dart';

/// Shadow tokens for the portfolio design system.
///
/// Dark theme: ultra-subtle — dark surfaces make elevation invisible
/// without strong shadows, so borders carry the weight instead.
///
/// Light theme: soft, layered — multiple low-opacity shadows for depth.
///
/// Usage:
/// ```dart
/// BoxDecoration(
///   boxShadow: isDark ? AppShadows.cardDark : AppShadows.cardLight,
/// )
/// ```
abstract class AppShadows {
  AppShadows._();

  // ---------------------------------------------------------------------------
  // Card — default card elevation
  // ---------------------------------------------------------------------------

  /// Subtle shadow for cards on light backgrounds.
  static const List<BoxShadow> cardLight = [
    BoxShadow(
      color: Color(0x08000000), // 3% opacity
      blurRadius: 1,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0F000000), // 6% opacity
      blurRadius: 8,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0A000000), // 4% opacity
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
  ];

  /// Minimal shadow for cards on dark backgrounds.
  static const List<BoxShadow> cardDark = [
    BoxShadow(
      color: Color(0x40000000), // 25% opacity
      blurRadius: 1,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Elevated — hovered cards, dropdowns, tooltips
  // ---------------------------------------------------------------------------

  static const List<BoxShadow> elevatedLight = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity
      blurRadius: 16,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 32,
      spreadRadius: 0,
      offset: Offset(0, 16),
    ),
  ];

  static const List<BoxShadow> elevatedDark = [
    BoxShadow(
      color: Color(0x60000000), // 38% opacity
      blurRadius: 16,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Focus glow — primary brand color glow for focus rings
  // ---------------------------------------------------------------------------

  /// Primary brand color glow for focused/hovered interactive elements.
  static const List<BoxShadow> focusGlow = [
    BoxShadow(
      color: Color(0x330C7029), // primary at 20% opacity
      blurRadius: 0,
      spreadRadius: 3,
      offset: Offset(0, 0),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Nav bar — sticky nav shadow on scroll
  // ---------------------------------------------------------------------------

  static const List<BoxShadow> navLight = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> navDark = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Context helper — picks correct shadow tier by brightness
  // ---------------------------------------------------------------------------

  /// Returns [cardLight] or [cardDark] based on current theme brightness.
  static List<BoxShadow> card(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark
        : cardLight;
  }

  /// Returns [elevatedLight] or [elevatedDark] based on current theme brightness.
  static List<BoxShadow> elevated(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? elevatedDark
        : elevatedLight;
  }

  /// Returns [navLight] or [navDark] based on current theme brightness.
  static List<BoxShadow> nav(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? navDark : navLight;
  }
}
