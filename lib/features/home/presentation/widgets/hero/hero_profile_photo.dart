import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';

/// Hero profile photo with a soft brand-color glow backdrop.
///
/// Resilient by design: if [photoAsset] is null or fails to load,
/// falls back to an elegant initials avatar rather than crashing.
///
/// Accessibility:
/// - Photo container wrapped in [Semantics] with image label
/// - Decorative glow wrapped in [ExcludeSemantics]
class HeroProfilePhoto extends StatelessWidget {
  const HeroProfilePhoto({
    super.key,
    required this.photoAsset,
    required this.initials,
    required this.size,
  });

  final String? photoAsset;
  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glowOpacity = isDark ? 0.16 : 0.10;

    return SizedBox(
      width: size * 1.5,
      height: size * 1.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Decorative glow — excluded from accessibility tree ─────────
          ExcludeSemantics(
            child: RepaintBoundary(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: size * 1.05,
                  height: size * 1.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: glowOpacity),
                        AppColors.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Profile photo with semantic label ─────────────────────────
          Semantics(
            label: 'Profile photo of $initials',
            image: true,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: AppRadius.xlBorderRadius,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: AppRadius.xlBorderRadius,
                child: _PhotoOrFallback(
                  photoAsset: photoAsset,
                  initials: initials,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Photo with graceful initials fallback
// ---------------------------------------------------------------------------

class _PhotoOrFallback extends StatelessWidget {
  const _PhotoOrFallback({
    required this.photoAsset,
    required this.initials,
  });

  final String? photoAsset;
  final String initials;

  @override
  Widget build(BuildContext context) {
    if (photoAsset == null || photoAsset!.isEmpty) {
      return _InitialsAvatar(initials: initials);
    }

    return Image.asset(
      photoAsset!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          _InitialsAvatar(initials: initials),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryAccent, AppColors.primaryVariant],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
      ),
    );
  }
}
