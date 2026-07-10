// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as web;
import '../routes/app_routes.dart';

/// Per-route SEO metadata injected at runtime via the Web DOM API.
///
/// ## Why this is needed
/// Flutter Web renders everything inside a canvas element — static HTML
/// contains only homepage meta tags. Googlebot runs JavaScript and will
/// see whatever the DOM contains after rendering. This service updates
/// title, description, canonical, and OG/Twitter tags on every route
/// change, so each deep-linked page has correct, crawlable metadata.
///
/// ## Usage — wired in app_router.dart redirect callback:
/// ```dart
/// redirect: (context, state) {
///   SeoService.updateForRoute(state.uri.path);
///   return null;
/// },
/// ```
///
/// ## Platform safety
/// The import is web-only. The router wraps the call in a kIsWeb guard
/// so this is never called on Android / iOS / desktop.
abstract class SeoService {
  SeoService._();

  static const String _baseUrl =
      'https://shehmeeryousafpasha.github.io/portfolio';
  static const String _ogImage = '$_baseUrl/assets/images/profile.jpeg';

  static void updateForRoute(String routePath) {
    final meta = _metaForRoute(routePath);
    _setTitle(meta.title);
    _setMeta(name: 'description', content: meta.description);
    _setCanonical('$_baseUrl${routePath == '/' ? '' : routePath}');
    _setOgProperty('og:title', meta.title);
    _setOgProperty('og:description', meta.description);
    _setOgProperty('og:url', '$_baseUrl$routePath');
    _setOgProperty('og:image', _ogImage);
    _setMeta(name: 'twitter:title', content: meta.title);
    _setMeta(name: 'twitter:description', content: meta.description);
  }

  static _RouteMeta _metaForRoute(String path) => switch (path) {
        AppRoutes.home => const _RouteMeta(
            title:
                'Shehmeer Yousaf — Flutter Developer | App Developer Pakistan',
            description:
                'Shehmeer Yousaf is an App Developer (Flutter) based in '
                'Rawalpindi & Islamabad, Pakistan. Building production-grade '
                'mobile and web experiences. Open to remote opportunities.',
          ),
        AppRoutes.projects => const _RouteMeta(
            title: 'Projects — Shehmeer Yousaf | Flutter Developer',
            description:
                'Explore Flutter projects by Shehmeer Yousaf — MechKonnect, '
                'GPA Calculator, Library Management Systems. App Developer '
                'based in Pakistan.',
          ),
        AppRoutes.experience => const _RouteMeta(
            title: 'Experience — Shehmeer Yousaf | App Developer',
            description:
                'Professional experience of Shehmeer Yousaf — App Developer at '
                'Seasonedly, building production Flutter apps across transportation,'
                ' logistics, and delivery platforms in Pakistan.',
          ),
        AppRoutes.certificates => const _RouteMeta(
            title: 'Certifications — Shehmeer Yousaf | Flutter Developer',
            description:
                'Professional certifications earned by Shehmeer Yousaf: '
                'Scrum Fundamentals, IBM Front-End Development, '
                'IBM Cybersecurity.',
          ),
        AppRoutes.resume => const _RouteMeta(
            title: 'Resume — Shehmeer Yousaf | Flutter Developer',
            description:
                'Download or view the resume of Shehmeer Yousaf, App Developer '
                '(Flutter) with CGPA 3.56 from IIUI Islamabad. '
                'Open to remote opportunities.',
          ),
        AppRoutes.contact => const _RouteMeta(
            title: 'Contact — Shehmeer Yousaf | Hire a Flutter Developer',
            description:
                'Get in touch with Shehmeer Yousaf — App Developer (Flutter) '
                'open to remote opportunities. Available via email, WhatsApp, '
                'LinkedIn, and GitHub.',
          ),
        _ => const _RouteMeta(
            title: 'Shehmeer Yousaf — Flutter Developer',
            description: 'App Developer (Flutter) based in Pakistan. '
                'Building mobile and web experiences.',
          ),
      };

  static void _setTitle(String title) {
    web.document.title = title;
  }

  static void _setMeta({required String name, required String content}) {
    var el = web.document.querySelector('meta[name="$name"]')
        as web.HTMLMetaElement?;
    if (el != null) {
      el.content = content;
    } else {
      final newEl = web.HTMLMetaElement();
      newEl.name = name;
      newEl.content = content;
      web.document.head?.appendChild(newEl);
    }
  }

  static void _setOgProperty(String property, String content) {
    var el = web.document.querySelector('meta[property="$property"]')
        as web.HTMLMetaElement?;
    if (el != null) {
      el.setAttribute('content', content);
    } else {
      final newEl = web.HTMLMetaElement();
      newEl.setAttribute('property', property);
      newEl.setAttribute('content', content);
      web.document.head?.appendChild(newEl);
    }
  }

  static void _setCanonical(String url) {
    var el = web.document.querySelector('link[rel="canonical"]')
        as web.HTMLLinkElement?;
    if (el != null) {
      el.href = url;
    } else {
      final newEl = web.HTMLLinkElement();
      newEl.rel = 'canonical';
      newEl.href = url;
      web.document.head?.appendChild(newEl);
    }
  }
}

class _RouteMeta {
  const _RouteMeta({required this.title, required this.description});
  final String title;
  final String description;
}
