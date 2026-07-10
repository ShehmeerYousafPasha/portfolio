import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_strings.dart';

/// Availability badge displayed in the Hero section and nav bar.
///
/// Renders a pulsing green dot beside "Open To Work" text.
/// Pulse animation is subtle — one slow opacity cycle every 2.5 seconds.
/// Respects [AnimationController] disposal properly.
///
/// ```dart
/// OpenToWorkBadge()
///
/// // Compact variant for nav bar
/// OpenToWorkBadge(compact: true)
/// ```
class OpenToWorkBadge extends StatefulWidget {
  const OpenToWorkBadge({
    super.key,
    this.compact = false,
  });

  /// Compact mode hides the label — shows only the pulsing dot.
  /// Used in the nav bar where space is limited.
  final bool compact;

  @override
  State<OpenToWorkBadge> createState() => _OpenToWorkBadgeState();
}

class _OpenToWorkBadgeState extends State<OpenToWorkBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Animation start deferred to didChangeDependencies so MediaQuery is available.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations) {
      // Show dot at full opacity — no animation.
      _controller.value = 1.0;
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark
        ? AppColors.primary.withValues(alpha: 0.12)
        : AppColors.primary.withValues(alpha: 0.08);

    final dot = AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, _) => Opacity(
        opacity: _pulseAnim.value,
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );

    if (widget.compact) {
      // Compact: dot only, no container
      return dot;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.fullBorderRadius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          dot,
          const SizedBox(width: 6),
          Text(
            AppStrings.openToWork,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
