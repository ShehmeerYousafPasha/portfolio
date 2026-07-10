import '../../models/project_model.dart';
import '../../sources/i_projects_data_source.dart';
import '../i_projects_repository.dart';

/// Concrete implementation of [IProjectsRepository].
///
/// Delegates all operations to the injected [IProjectsDataSource].
class ProjectsRepositoryImpl implements IProjectsRepository {
  const ProjectsRepositoryImpl(this._dataSource);

  final IProjectsDataSource _dataSource;

  @override
  Future<List<ProjectModel>> getAllProjects() => _dataSource.getAllProjects();

  @override
  Future<ProjectModel?> getFeaturedProject() => _dataSource.getFeaturedProject();

  @override
  Future<List<ProjectModel>> getOtherProjects() => _dataSource.getOtherProjects();
}
