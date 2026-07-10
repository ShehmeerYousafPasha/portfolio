import '../models/social_model.dart';

/// Abstract contract for retrieving social/contact link data.
///
/// Current implementation: [LocalSocialsDataSource] (static Dart data).
/// Future implementation: SupabaseSocialsDataSource — drop-in replacement.
abstract class ISocialsDataSource {
  /// Returns all social links sorted by [SocialModel.displayOrder].
  Future<List<SocialModel>> getAllSocials();

  /// Returns only primary social links sorted by [SocialModel.displayOrder].
  Future<List<SocialModel>> getPrimarySocials();
}
