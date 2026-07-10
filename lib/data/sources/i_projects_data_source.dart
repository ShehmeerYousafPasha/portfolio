import '../models/project_model.dart';

/// Abstract contract for retrieving project data.
///
/// Current implementation: [LocalProjectsDataSource] (static Dart data).
/// Future implementation: SupabaseProjectsDataSource — drop-in replacement.
abstract class IProjectsDataSource {
  /// Returns all projects in display order.
  Future<List<ProjectModel>> getAllProjects();

  /// Returns the single featured project, or null if none is marked featured.
  Future<ProjectModel?> getFeaturedProject();

  /// Returns all non-featured projects.
  Future<List<ProjectModel>> getOtherProjects();
}
