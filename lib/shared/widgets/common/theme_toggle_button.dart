import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/theme_notifier.dart';

/// Icon button that cycles through theme modes: system → light → dark → system.
///
/// Lives in the nav bar. Shows the icon corresponding to the *current* mode,
/// with a tooltip explaining what the next press will do.
///
/// ```dart
/// ThemeToggleButton()
/// ```
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    final (icon, tooltip) = switch (themeMode) {
      ThemeMode.system => (Icons.brightness_auto_rounded, AppStrings.switchToLight),
      ThemeMode.light  => (Icons.light_mode_rounded,      AppStrings.switchToDark),
      ThemeMode.dark   => (Icons.dark_mode_rounded,       AppStrings.switchToSystem),
    };

    void onTap() {
      final next = switch (themeMode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light  => ThemeMode.dark,
        ThemeMode.dark   => ThemeMode.system,
      };
      notifier.setTheme(next);
    }

    return Tooltip(
      message: tooltip,
      child: AnimatedSwitcher(
        duration: AppDurations.themeSwitch,
        transitionBuilder: (child, anim) => RotationTransition(
          turns: Tween<double>(begin: 0.75, end: 1.0).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: IconButton(
          key: ValueKey(themeMode),
          onPressed: onTap,
          icon: Icon(icon),
          iconSize: 20,
          tooltip: tooltip,
        ),
      ),
    );
  }
}
