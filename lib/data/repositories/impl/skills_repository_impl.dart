import '../../models/skill_model.dart';
import '../../sources/i_skills_data_source.dart';
import '../i_skills_repository.dart';

/// Concrete implementation of [ISkillsRepository].
///
/// Delegates all operations to the injected [ISkillsDataSource].
class SkillsRepositoryImpl implements ISkillsRepository {
  const SkillsRepositoryImpl(this._dataSource);

  final ISkillsDataSource _dataSource;

  @override
  Future<List<SkillCategory>> getAllSkillCategories() =>
      _dataSource.getAllSkillCategories();

  @override
  Future<List<SkillModel>> getAllSkills() => _dataSource.getAllSkills();
}
