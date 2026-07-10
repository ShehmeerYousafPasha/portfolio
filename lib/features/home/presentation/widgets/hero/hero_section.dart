import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_durations.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/models/profile_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/layouts/page_layout.dart';
import '../../../../../shared/widgets/badges/open_to_work_badge.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/typography/app_text.dart';
import 'hero_cta_buttons.dart';
import 'hero_profile_photo.dart';

/// The portfolio's Hero section — the first thing every visitor sees.
///
/// Displays (per PROJECT_CONTEXT.md):
/// - Professional profile photo (with graceful initials fallback)
/// - Name, title, and headline
/// - Open To Work badge
/// - Four CTAs: View Projects, Resume, Contact Me, Hire Me
///
/// Layout:
/// - Desktop (≥1024px): text on the left, photo on the right
/// - Mobile / Tablet (<1024px): photo centered above, text centered below
///
/// Data flows through Riverpod's [profileProvider] — this widget never
/// imports the raw `profile.dart` data file directly, keeping the UI
/// decoupled from the data source (per the clean architecture from Prompt 2).
class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return AsyncValueWidget<ProfileModel>(
      value: profileAsync,
      data: (profile) => _HeroContent(profile: profile),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero content — background glow + responsive layout switch
// ---------------------------------------------------------------------------

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isDesktop = deviceTypeOf(context).isDesktop;

    return Stack(
      children: [
        // Decorative ambient glow — excluded from accessibility tree.
        const Positioned.fill(
          child: ExcludeSemantics(child: _HeroBackgroundGlow()),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight - AppSpacing.navHeight,
          ),
          child: Center(
            child: PageLayout(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xxl,
                ),
                child: _FadeInOnLoad(
                  child: isDesktop
                      ? _DesktopHeroLayout(profile: profile)
                      : _StackedHeroLayout(profile: profile),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop — text left, photo right
// ---------------------------------------------------------------------------

class _DesktopHeroLayout extends StatelessWidget {
  const _DesktopHeroLayout({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final photoSize = responsiveValue<double>(
      context,
      mobile: 200,
      desktop: 320,
      largeDesktop: 360,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _HeroTextColumn(profile: profile, centered: false),
        ),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(
          flex: 4,
          child: Center(
            child: HeroProfilePhoto(
              photoAsset: profile.profilePhotoAsset,
              initials: _initialsOf(profile.name),
              size: photoSize,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile / Tablet — photo above, text centered below
// ---------------------------------------------------------------------------

class _StackedHeroLayout extends StatelessWidget {
  const _StackedHeroLayout({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final photoSize = responsiveValue<double>(
      context,
      mobile: 180,
      tablet: 240,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeroProfilePhoto(
          photoAsset: profile.profilePhotoAsset,
          initials: _initialsOf(profile.name),
          size: photoSize,
        ),
        const SizedBox(height: AppSpacing.xl),
        _HeroTextColumn(profile: profile, centered: true),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared text column — name, title, headline, badge, CTAs
// ---------------------------------------------------------------------------

class _HeroTextColumn extends StatelessWidget {
  const _HeroTextColumn({required this.profile, required this.centered});

  final ProfileModel profile;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    final crossAxis =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    final nameSize = responsiveValue<double>(
      context,
      mobile: 38,
      tablet: 46,
      desktop: 60,
      largeDesktop: 68,
    );

    final titleSize = responsiveValue<double>(
      context,
      mobile: 20,
      tablet: 22,
      desktop: 24,
    );

    return Column(
      crossAxisAlignment: crossAxis,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Eyebrow: location ─────────────────────────────────────────────
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 14,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            AppText.eyebrow(
              '${profile.locationLine} • ${profile.country}'.toUpperCase(),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // ── Open To Work badge ──────────────────────────────────────────
        if (profile.isOpenToWork) const OpenToWorkBadge(),

        if (profile.isOpenToWork) const SizedBox(height: AppSpacing.md),

        // ── Name ──────────────────────────────────────────────────────────
        Text(
          profile.name,
          textAlign: textAlign,
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: nameSize,
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
            height: 1.05,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        // ── Title (brand color) ──────────────────────────────────────────
        Text(
          profile.title,
          textAlign: textAlign,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: titleSize,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // ── Headline / tagline ──────────────────────────────────────────
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: centered
                ? responsiveValue<double>(context, mobile: 360, tablet: 480)
                : 460,
          ),
          child: AppText.body(
            profile.headline,
            textAlign: textAlign,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        // ── CTAs ──────────────────────────────────────────────────────────
        HeroCtaButtons(centered: centered),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Decorative ambient background glow — static, theme-aware, subtle
// ---------------------------------------------------------------------------

class _HeroBackgroundGlow extends StatelessWidget {
  const _HeroBackgroundGlow();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final opacity = isDark ? 0.07 : 0.05;

    return RepaintBoundary(
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -100,
              child: _glowCircle(size: 480, opacity: opacity),
            ),
            Positioned(
              bottom: -160,
              left: -140,
              child: _glowCircle(size: 420, opacity: opacity * 0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glowCircle({required double size, required double opacity}) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: opacity),
              AppColors.primary.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// One-time fade + rise entrance — not a looping animation
// ---------------------------------------------------------------------------

class _FadeInOnLoad extends StatelessWidget {
  const _FadeInOnLoad({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Skip animation entirely when OS reduce-motion preference is set.
    if (MediaQuery.disableAnimationsOf(context)) return child;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppDurations.slower,
      curve: AppDurations.entry,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 14),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Helper — derive initials from full name for the photo fallback
// ---------------------------------------------------------------------------

String _initialsOf(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
  return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
      .toUpperCase();
}
