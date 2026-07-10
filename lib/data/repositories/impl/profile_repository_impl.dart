import '../../models/profile_model.dart';
import '../../sources/i_profile_data_source.dart';
import '../i_profile_repository.dart';

/// Concrete implementation of [IProfileRepository].
///
/// Delegates all operations to the injected [IProfileDataSource].
/// Swapping from local to Supabase only requires changing the data
/// source passed in — this class and all UI code remain untouched.
class ProfileRepositoryImpl implements IProfileRepository {
  const ProfileRepositoryImpl(this._dataSource);

  final IProfileDataSource _dataSource;

  @override
  Future<ProfileModel> getProfile() => _dataSource.getProfile();
}
