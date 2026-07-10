import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../layouts/page_layout.dart';

/// Full-width section wrapper used by every portfolio section.
///
/// Responsibilities:
/// - Applies consistent vertical section padding (responsive)
/// - Constrains content to [maxWidth] via [PageLayout]
/// - Optionally renders an alternate background for visual rhythm
///
/// Alternate sections (e.g. Skills, Certifications) use a slightly
/// elevated surface to break the layout into readable bands.
///
/// ```dart
/// // Standard section
/// SectionContainer(
///   id: 'experience',
///   child: ExperienceSection(),
/// )
///
/// // Alternate background band
/// SectionContainer(
///   id: 'skills',
///   isAlternate: true,
///   child: SkillsSection(),
/// )
/// ```
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.id,
    this.isAlternate = false,
    this.backgroundColor,
    this.maxWidth = AppSpacing.maxContentWidth,
    this.disableHorizontalPadding = false,
  });

  final Widget child;

  /// HTML anchor id — used for in-page scroll navigation (web).
  final String? id;

  /// When true, renders the section on an elevated background surface
  /// to create visual separation from adjacent sections.
  final bool isAlternate;

  /// Explicit background override — takes precedence over [isAlternate].
  final Color? backgroundColor;

  final double maxWidth;

  /// Set true if the child manages its own horizontal layout (e.g. full-bleed images).
  final bool disableHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color? effectiveBg = backgroundColor;
    if (effectiveBg == null && isAlternate) {
      effectiveBg = isDark
          ? AppColors.darkSurface          // one step lighter than darkBackground
          : AppColors.lightSurfaceElevated; // subtle off-white for light theme
    }

    final vPadding = responsiveValue<double>(
      context,
      mobile: AppSpacing.sectionVerticalMobile,
      tablet: AppSpacing.sectionVerticalMobile + 16, // 80px on tablet
      desktop: AppSpacing.sectionVertical,
    );

    Widget content = Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding),
      child: disableHorizontalPadding
          ? child
          : PageLayout(maxWidth: maxWidth, child: child),
    );

    if (effectiveBg != null) {
      content = ColoredBox(color: effectiveBg, child: content);
    }

    // Wrap with a SizedBox with key for scroll-to-section on web
    if (id != null) {
      return SizedBox(key: ValueKey(id), width: double.infinity, child: content);
    }

    return SizedBox(width: double.infinity, child: content);
  }
}
