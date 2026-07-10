import '../models/skill_model.dart';

/// Abstract contract for retrieving skills data.
///
/// Current implementation: [LocalSkillsDataSource] (static Dart data).
/// Future implementation: SupabaseSkillsDataSource — drop-in replacement.
abstract class ISkillsDataSource {
  /// Returns all skill categories, each containing their skills.
  Future<List<SkillCategory>> getAllSkillCategories();

  /// Returns a flat list of all individual skills across all categories.
  Future<List<SkillModel>> getAllSkills();
}
