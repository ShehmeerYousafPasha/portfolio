import '../models/experience_model.dart';

/// Abstract contract for retrieving work experience data.
///
/// Current implementation: [LocalExperienceDataSource] (static Dart data).
/// Future implementation: SupabaseExperienceDataSource — drop-in replacement.
abstract class IExperienceDataSource {
  /// Returns all experience entries in reverse chronological order (newest first).
  Future<List<ExperienceModel>> getAllExperience();

  /// Returns the current (active) role, or null if none is marked current.
  Future<ExperienceModel?> getCurrentExperience();
}
