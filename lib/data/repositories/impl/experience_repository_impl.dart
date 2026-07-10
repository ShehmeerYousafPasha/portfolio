import '../../models/experience_model.dart';
import '../../sources/i_experience_data_source.dart';
import '../i_experience_repository.dart';

/// Concrete implementation of [IExperienceRepository].
///
/// Delegates all operations to the injected [IExperienceDataSource].
class ExperienceRepositoryImpl implements IExperienceRepository {
  const ExperienceRepositoryImpl(this._dataSource);

  final IExperienceDataSource _dataSource;

  @override
  Future<List<ExperienceModel>> getAllExperience() =>
      _dataSource.getAllExperience();

  @override
  Future<ExperienceModel?> getCurrentExperience() =>
      _dataSource.getCurrentExperience();
}
