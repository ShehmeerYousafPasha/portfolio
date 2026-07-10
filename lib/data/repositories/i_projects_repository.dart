import '../models/project_model.dart';

/// Repository contract for project data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [ProjectsRepositoryImpl]
abstract class IProjectsRepository {
  /// Returns all projects in display order.
  Future<List<ProjectModel>> getAllProjects();

  /// Returns the single featured project, or null if none is marked featured.
  /// Used by the Featured Project section.
  Future<ProjectModel?> getFeaturedProject();

  /// Returns all non-featured projects.
  /// Used by the Other Projects section.
  Future<List<ProjectModel>> getOtherProjects();
}
