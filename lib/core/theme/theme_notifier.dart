import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeModeKey = 'portfolio_theme_mode';

/// Manages theme state (light / dark / system) with local persistence.
///
/// - Default: [ThemeMode.system] (respects device setting)
/// - Persisted via [SharedPreferences]
/// - Exposed via [themeProvider]
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    // Load persisted preference asynchronously after initial build.
    _restoreTheme();
    return ThemeMode.system;
  }

  Future<void> _restoreTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_kThemeModeKey);
      if (saved != null) {
        state = ThemeMode.values.firstWhere(
          (mode) => mode.name == saved,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (_) {
      // Storage unavailable — silently fall back to system theme.
    }
  }

  /// Set a specific theme mode and persist the selection.
  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kThemeModeKey, mode.name);
    } catch (_) {
      // Persistence failure is non-critical.
    }
  }

  /// Toggle between light and dark explicitly (no system option in toggle).
  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(next);
  }

  /// Convenience: true when the resolved theme is dark.
  bool isDark(BuildContext context) {
    if (state == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }
}

/// Global theme provider — consume with [ref.watch(themeProvider)].
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
