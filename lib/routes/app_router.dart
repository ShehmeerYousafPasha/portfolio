import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import 'page_transitions.dart';
import '../features/shell/presentation/pages/shell_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/projects/presentation/pages/projects_page.dart';
import '../features/experience/presentation/pages/experience_page.dart';
import '../features/certificates/presentation/pages/certificates_page.dart';
import '../features/resume/presentation/pages/resume_page.dart';
import '../features/contact/presentation/pages/contact_page.dart';

// Web-only import — conditionally used inside redirect callback.
// The dart:js_interop / package:web import lives only in seo_service.dart,
// so this file stays platform-safe: we import the service with a conditional
// inline guard (kIsWeb) rather than a conditional import.
import '../services/seo_service.dart';
import '../services/analytics_service.dart';

/// Global GoRouter instance.
///
/// Every route change triggers [SeoService.updateForRoute] (web only),
/// which updates the document title, description, canonical URL, and
/// Open Graph / Twitter meta tags at runtime so JS-capable crawlers
/// (Googlebot) index per-route metadata rather than only the homepage copy.
///
/// Routing strategy:
/// - [ShellRoute] wraps every page with [ShellPage] (persistent nav + footer)
/// - [AppPageTransitions.buildPage] gives a consistent fade-slide transition
/// - Deep linking via path-based GoRouter routes supports web sharing
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: false,

  // ---------------------------------------------------------------------------
  // SEO — update document meta tags on every navigation (web only)
  // ---------------------------------------------------------------------------
  redirect: (context, state) {
    if (kIsWeb) {
      final path  = state.uri.path;
      // Update document meta tags for JS-capable crawlers
      SeoService.updateForRoute(path);
      // Track page view in GA4
      final title = _pageTitleFor(path);
      AnalyticsService.trackPageView(path: path, title: title);
    }
    return null; // never redirects; only side-effects
  },

  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellPage(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.projects,
          name: 'projects',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const ProjectsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.experience,
          name: 'experience',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const ExperiencePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.certificates,
          name: 'certificates',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const CertificatesPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.resume,
          name: 'resume',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const ResumePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.contact,
          name: 'contact',
          pageBuilder: (context, state) => AppPageTransitions.buildPage(
            key: state.pageKey,
            child: const ContactPage(),
          ),
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '404',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text('Page not found: ${state.uri}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);

// ---------------------------------------------------------------------------
// Page title lookup — mirrors SeoService._metaForRoute titles exactly
// ---------------------------------------------------------------------------

String _pageTitleFor(String path) => switch (path) {
      AppRoutes.home         => 'Shehmeer Yousaf — Flutter Developer',
      AppRoutes.projects     => 'Projects — Shehmeer Yousaf',
      AppRoutes.experience   => 'Experience — Shehmeer Yousaf',
      AppRoutes.certificates => 'Certifications — Shehmeer Yousaf',
      AppRoutes.resume       => 'Resume — Shehmeer Yousaf',
      AppRoutes.contact      => 'Contact — Shehmeer Yousaf',
      _                      => 'Shehmeer Yousaf',
    };
