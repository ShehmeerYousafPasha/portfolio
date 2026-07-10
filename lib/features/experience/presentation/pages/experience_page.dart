import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/experience/experience_section.dart';

/// Experience page — deep-linked at /experience.
///
/// Reuses [ExperienceSection] from the home page with the same data layer.
class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ExperienceSection(),
      ],
    );
  }
}
