import 'package:web/web.dart' as web;

abstract class PageRefreshService {
  PageRefreshService._();

  static void refresh() {
    web.window.location.reload();
  }
}
