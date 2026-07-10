import 'package:flutter/material.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_radius.dart';

/// Animated placeholder block shown while content loads.
///
/// Uses a simple opacity pulse — no external shimmer package needed.
/// Keeps the dependency tree clean while still communicating loading state.
///
/// ```dart
/// // Single line placeholder
/// SkeletonLoader(width: 200, height: 16)
///
/// // Full card skeleton
/// Column(children: [
///   SkeletonLoader(width: double.infinity, height: 20),
///   SizedBox(height: 8),
///   SkeletonLoader(width: 160, height: 14),
///   SizedBox(height: 16),
///   SkeletonLoader(width: double.infinity, height: 80),
/// ])
/// ```
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
  });

  /// Circle avatar skeleton — [height] is used as the diameter.
  const SkeletonLoader.circle({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = null,
        isCircle = true;

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.slower,
    );
    _anim = Tween<double>(begin: 0.4, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Animation start deferred to didChangeDependencies so MediaQuery is available.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations) {
      _controller.value = 0.85;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE2E8F0);

    final effectiveRadius = widget.isCircle
        ? AppRadius.fullBorderRadius
        : (widget.borderRadius ?? AppRadius.xsBorderRadius);

    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Opacity(
        opacity: _anim.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: effectiveRadius,
          ),
        ),
      ),
    );
  }
}
