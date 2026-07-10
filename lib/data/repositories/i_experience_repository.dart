import '../models/experience_model.dart';

/// Repository contract for work experience data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [ExperienceRepositoryImpl]
abstract class IExperienceRepository {
  /// Returns all experience entries in reverse chronological order.
  Future<List<ExperienceModel>> getAllExperience();

  /// Returns the currently active role, or null if not employed.
  /// Used by the Quick Snapshot and Experience sections.
  Future<ExperienceModel?> getCurrentExperience();
}
