import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/featured_project/featured_project_section.dart';
import '../../../home/presentation/widgets/other_projects/other_projects_section.dart';

/// Projects page — deep-linked at /projects.
///
/// Reuses the same [FeaturedProjectSection] and [OtherProjectsSection]
/// widgets from the home page. Data is served by the same Riverpod
/// providers so there is no duplication of network/compute work.
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FeaturedProjectSection(),
        OtherProjectsSection(),
      ],
    );
  }
}
