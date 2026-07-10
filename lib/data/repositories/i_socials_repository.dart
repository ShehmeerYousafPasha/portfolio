import '../models/social_model.dart';

/// Repository contract for social/contact link data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [SocialsRepositoryImpl]
abstract class ISocialsRepository {
  /// Returns all social links sorted by display order.
  Future<List<SocialModel>> getAllSocials();

  /// Returns only primary social links sorted by display order.
  /// Used in the footer and contact section for prominent CTAs.
  Future<List<SocialModel>> getPrimarySocials();
}
