import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Small helper for opening external links and asset-backed files.
abstract class LinkLauncher {
  LinkLauncher._();

  static Future<bool> open(
    BuildContext context,
    String urlOrPath, {
    LaunchMode mode = LaunchMode.externalApplication,
    String? failureMessage,
  }) async {
    final uri = Uri.parse(urlOrPath);
    final target = uri.hasScheme ? uri : Uri.base.resolveUri(uri);

    try {
      final launched = await launchUrl(target, mode: mode);
      if (!launched && context.mounted) {
        _showFailure(
          context,
          failureMessage ?? 'Unable to open the selected link.',
        );
      }
      return launched;
    } catch (_) {
      if (context.mounted) {
        _showFailure(
          context,
          failureMessage ?? 'Unable to open the selected link.',
        );
      }
      return false;
    }
  }

  static void _showFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}
