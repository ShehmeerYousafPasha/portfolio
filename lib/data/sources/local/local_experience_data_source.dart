import '../../models/experience_model.dart';
import '../i_experience_data_source.dart';
import '../../experience.dart';

/// Local implementation of [IExperienceDataSource].
///
/// Reads from the static [experienceData] list defined in
/// `lib/data/experience.dart`. Data is already in reverse chronological order.
class LocalExperienceDataSource implements IExperienceDataSource {
  const LocalExperienceDataSource();

  @override
  Future<List<ExperienceModel>> getAllExperience() =>
      Future.value(List.unmodifiable(experienceData));

  @override
  Future<ExperienceModel?> getCurrentExperience() => Future.value(
        experienceData.where((e) => e.isCurrent).firstOrNull,
      );
}
