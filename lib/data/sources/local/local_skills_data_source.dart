import '../../models/skill_model.dart';
import '../i_skills_data_source.dart';
import '../../skills.dart';

/// Local implementation of [ISkillsDataSource].
///
/// Reads from the static [skillsData] list defined in
/// `lib/data/skills.dart`. The flat skills list is derived by
/// expanding all categories — no duplication in the source data.
class LocalSkillsDataSource implements ISkillsDataSource {
  const LocalSkillsDataSource();

  @override
  Future<List<SkillCategory>> getAllSkillCategories() =>
      Future.value(List.unmodifiable(skillsData));

  @override
  Future<List<SkillModel>> getAllSkills() => Future.value(
        List.unmodifiable(
          skillsData.expand((category) => category.skills).toList(),
        ),
      );
}
