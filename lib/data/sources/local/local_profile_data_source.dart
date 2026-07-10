import '../../models/profile_model.dart';
import '../i_profile_data_source.dart';
import '../../profile.dart';

/// Local implementation of [IProfileDataSource].
///
/// Reads directly from the static [profileData] constant defined in
/// `lib/data/profile.dart`. Returns data wrapped in a [Future] so the
/// interface is identical to a Supabase implementation.
///
/// No I/O occurs — [Future.value] resolves on the same microtask.
class LocalProfileDataSource implements IProfileDataSource {
  const LocalProfileDataSource();

  @override
  Future<ProfileModel> getProfile() => Future.value(profileData);
}
