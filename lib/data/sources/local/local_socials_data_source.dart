import '../../models/social_model.dart';
import '../i_socials_data_source.dart';
import '../../socials.dart';

/// Local implementation of [ISocialsDataSource].
///
/// Reads from the static [socialsData] list defined in
/// `lib/data/socials.dart`. Data is already sorted by [SocialModel.displayOrder].
class LocalSocialsDataSource implements ISocialsDataSource {
  const LocalSocialsDataSource();

  @override
  Future<List<SocialModel>> getAllSocials() =>
      Future.value(List.unmodifiable(socialsData));

  @override
  Future<List<SocialModel>> getPrimarySocials() => Future.value(
        List.unmodifiable(
          socialsData.where((s) => s.isPrimary).toList(),
        ),
      );
}
