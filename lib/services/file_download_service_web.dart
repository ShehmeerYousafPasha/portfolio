import 'package:web/web.dart' as web;

abstract class FileDownloadService {
  FileDownloadService._();

  static void download({
    required String urlOrPath,
    required String fileName,
  }) {
    final uri = Uri.base.resolve(urlOrPath);
    final anchor = web.HTMLAnchorElement()
      ..href = uri.toString()
      ..download = fileName
      ..target = '_blank';

    web.document.body?.appendChild(anchor);
    anchor.click();
    anchor.remove();
  }
}
