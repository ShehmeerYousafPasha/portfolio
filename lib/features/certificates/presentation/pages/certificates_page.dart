import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/certificates/certificates_section.dart';

/// Certificates page — deep-linked at /certificates.
///
/// Reuses [CertificatesSection] from the home page with the same data layer.
class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CertificatesSection(),
      ],
    );
  }
}
