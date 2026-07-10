import '../models/profile_model.dart';

/// Repository contract for profile data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [ProfileRepositoryImpl]
abstract class IProfileRepository {
  /// Returns the complete profile of the portfolio owner.
  Future<ProfileModel> getProfile();
}
