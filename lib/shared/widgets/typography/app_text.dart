import 'package:flutter/material.dart';

/// Semantic typography widget for the portfolio design system.
///
/// Each named constructor maps to a specific typographic role, reading
/// the correct style from the active [ThemeData.textTheme].
///
/// Usage:
/// ```dart
/// AppText.eyebrow('Featured Project')      // small, uppercase, primary color
/// AppText.h2('MechKonnect')                // section/card headline
/// AppText.body('Automobile platform…')     // standard body paragraph
/// AppText.muted('Flutter • Dart')          // secondary-colored metadata
/// ```
///
/// Every variant supports optional [color], [textAlign], [maxLines], [overflow].
/// Theme colours are used by default; pass [color] only when truly needed.
class AppText extends StatelessWidget {
  // Internal constructor — all named constructors delegate here.
  const AppText._(
    this.text, {
    super.key,
    required _TextVariant variant,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : _variant = variant;

  final String text;
  final _TextVariant _variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  // ---------------------------------------------------------------------------
  // Named constructors — semantic typography roles
  // ---------------------------------------------------------------------------

  /// Hero / display — the largest text in the layout.
  /// Used for the name in the Hero section.
  const AppText.hero(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.hero,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Section headline — large, bold. Used for main section titles on desktop.
  const AppText.h1(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.h1,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Sub-section headline — used for section titles on mobile or subsections.
  const AppText.h2(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.h2,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Card/feature headline — used for project and experience titles.
  const AppText.h3(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.h3,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Large title — for card titles, nav items.
  const AppText.titleLg(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.titleLg,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Medium title — for smaller card headers, list items.
  const AppText.titleMd(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.titleMd,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Standard body paragraph — main content text.
  const AppText.body(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.body,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
        );

  /// Small body — captions, supplementary text.
  const AppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.bodySmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Button / chip label — semibold, compact.
  const AppText.label(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.label,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Small label — overline, metadata, timestamps.
  const AppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.labelSmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );

  /// Eyebrow — uppercase, letter-spaced, primary colour.
  /// Used above section titles: "Featured Project", "Current Role".
  const AppText.eyebrow(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.eyebrow,
          color: color,
          textAlign: textAlign,
        );

  /// Muted — secondary-coloured body text.
  /// Used for descriptions, metadata, role descriptions.
  const AppText.muted(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
  }) : this._(
          text,
          key: key,
          variant: _TextVariant.muted,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
        );

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;
    final cs = theme.colorScheme;

    final TextStyle? baseStyle = switch (_variant) {
      _TextVariant.hero      => tt.displaySmall,
      _TextVariant.h1        => tt.headlineLarge,
      _TextVariant.h2        => tt.headlineMedium,
      _TextVariant.h3        => tt.headlineSmall,
      _TextVariant.titleLg   => tt.titleLarge,
      _TextVariant.titleMd   => tt.titleMedium,
      _TextVariant.body      => tt.bodyLarge,
      _TextVariant.bodySmall => tt.bodySmall,
      _TextVariant.label     => tt.labelLarge,
      _TextVariant.labelSmall => tt.labelSmall,
      _TextVariant.eyebrow   => tt.labelSmall?.copyWith(
          color: cs.primary,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      _TextVariant.muted     => tt.bodyMedium?.copyWith(
          color: cs.onSurfaceVariant,
        ),
    };

    final effectiveStyle = color != null
        ? baseStyle?.copyWith(color: color)
        : baseStyle;

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      softWrap: softWrap,
    );
  }
}

enum _TextVariant {
  hero,
  h1,
  h2,
  h3,
  titleLg,
  titleMd,
  body,
  bodySmall,
  label,
  labelSmall,
  eyebrow,
  muted,
}
