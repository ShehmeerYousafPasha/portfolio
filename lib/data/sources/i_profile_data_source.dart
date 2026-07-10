import '../models/profile_model.dart';

/// Abstract contract for retrieving profile data.
///
/// Current implementation: [LocalProfileDataSource] (static Dart data).
/// Future implementation: SupabaseProfileDataSource — drop-in replacement,
/// no changes required in the repository or UI layers.
abstract class IProfileDataSource {
  /// Fetches the complete profile of the portfolio owner.
  Future<ProfileModel> getProfile();
}
