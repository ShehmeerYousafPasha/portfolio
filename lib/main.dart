import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_assets.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'routes/app_router.dart';
import 'services/web_loader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

/// Root application widget.
///
/// The Web loader is dismissed only after Flutter has rendered and the first
/// visible portfolio image is ready to display.
class PortfolioApp extends ConsumerStatefulWidget {
  const PortfolioApp({super.key});

  @override
  ConsumerState<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends ConsumerState<PortfolioApp> {
  bool _hasStartedPreparing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStartedPreparing) return;
    _hasStartedPreparing = true;
    _finishLoadingWhenReady();
  }

  Future<void> _finishLoadingWhenReady() async {
    try {
      await precacheImage(const AssetImage(AppAssets.profilePhoto), context);
    } catch (_) {
      // The portfolio has its own image fallback, so a missing image should
      // never leave visitors stuck on the startup loader.
    }

    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => hideWebLoader());
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Shehmeer Yousaf — Flutter Developer',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
