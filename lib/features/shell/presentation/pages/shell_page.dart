import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../shared/widgets/common/app_footer.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/mobile_drawer.dart';

/// Persistent application shell wrapping every route via [ShellRoute].
///
/// Provides:
/// - [AppNavBar] — fixed at top, becomes opaque on scroll
/// - [MobileDrawer] — slide-in nav for mobile/tablet (opened via [_scaffoldKey])
/// - [AppFooter] — rendered after page content
/// - Scroll position tracking — passed to [AppNavBar] for background transition
///
/// The [child] is the currently-routed page (Home, Projects, etc.),
/// rendered inside a scrollable column between the nav bar and footer.
///
/// ```dart
/// // In app_router.dart:
/// ShellRoute(
///   builder: (context, state, child) => ShellPage(child: child),
///   routes: [...],
/// )
/// ```
class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.child});

  final Widget child;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldBeScrolled = _scrollController.offset > 8;
    if (shouldBeScrolled != _isScrolled) {
      setState(() => _isScrolled = shouldBeScrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = deviceTypeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      // Drawer only needed on mobile/tablet — desktop nav has inline links.
      endDrawer: !deviceType.isDesktop ? const MobileDrawer() : null,
      body: Stack(
        children: [
          // ── Scrollable content: page body + footer ──────────────────────
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Top spacer so content starts below the fixed nav bar
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.navHeight),
              ),

              // Routed page content
              SliverToBoxAdapter(child: widget.child),

              // Footer
              const SliverToBoxAdapter(child: AppFooter()),
            ],
          ),

          // ── Fixed nav bar overlay ─────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(
              isScrolled: _isScrolled,
              onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
