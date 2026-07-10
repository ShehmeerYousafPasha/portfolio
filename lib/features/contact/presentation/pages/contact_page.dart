import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/contact/contact_section.dart';

/// Contact page — deep-linked at /contact.
///
/// Reuses [ContactSection] from the home page with the same data layer.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ContactSection(),
      ],
    );
  }
}
