import '../models/skill_model.dart';

/// Repository contract for skills data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [SkillsRepositoryImpl]
abstract class ISkillsRepository {
  /// Returns all skill categories, each containing their skills.
  /// Used by the Skills section for grouped display.
  Future<List<SkillCategory>> getAllSkillCategories();

  /// Returns a flat list of all skills across all categories.
  /// Useful when rendering ungrouped skill chips.
  Future<List<SkillModel>> getAllSkills();
}
