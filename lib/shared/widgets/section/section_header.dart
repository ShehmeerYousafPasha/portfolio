import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../typography/app_text.dart';

/// Standard section header used at the top of every portfolio section.
///
/// Structure (top-to-bottom):
/// 1. [eyebrow] — small uppercase label in the primary color (optional)
/// 2. [title]   — the section headline (required)
/// 3. [subtitle] — a supporting sentence (optional)
///
/// ```dart
/// SectionHeader(
///   eyebrow: 'My Work',
///   title: 'Featured Project',
///   subtitle: 'A real-world production application.',
/// )
///
/// SectionHeader(
///   title: 'Skills',
///   alignment: CrossAxisAlignment.center,
/// )
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    this.titleStyle,
  });

  final String title;

  /// Small uppercase label above the title — e.g. "Final Year Project".
  final String? eyebrow;

  /// Optional paragraph below the title.
  final String? subtitle;

  /// Controls left-align vs centre-align of all text.
  final CrossAxisAlignment alignment;

  /// Override the title text style — defaults to [AppText.h2].
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final textAlign = alignment == CrossAxisAlignment.center
        ? TextAlign.center
        : TextAlign.start;

    final isCentered = alignment == CrossAxisAlignment.center;

    return Align(
      alignment: isCentered ? Alignment.center : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: Column(
          crossAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Eyebrow
            if (eyebrow != null) ...[
              AppText.eyebrow(eyebrow!, textAlign: textAlign),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Title
            titleStyle != null
                ? Text(title, style: titleStyle, textAlign: textAlign)
                : AppText.h2(title, textAlign: textAlign),

            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.md),
              AppText.muted(
                subtitle!,
                textAlign: textAlign,
                maxLines: 3,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
