import '../../models/project_model.dart';
import '../i_projects_data_source.dart';
import '../../projects.dart';

/// Local implementation of [IProjectsDataSource].
///
/// Reads from the static [projectsData] list defined in
/// `lib/data/projects.dart`. All filtering is done in memory.
class LocalProjectsDataSource implements IProjectsDataSource {
  const LocalProjectsDataSource();

  @override
  Future<List<ProjectModel>> getAllProjects() =>
      Future.value(List.unmodifiable(projectsData));

  @override
  Future<ProjectModel?> getFeaturedProject() => Future.value(
        projectsData.where((p) => p.isFeatured).firstOrNull,
      );

  @override
  Future<List<ProjectModel>> getOtherProjects() => Future.value(
        List.unmodifiable(
          projectsData.where((p) => !p.isFeatured).toList(),
        ),
      );
}
