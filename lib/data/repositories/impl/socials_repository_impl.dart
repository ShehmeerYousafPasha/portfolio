import '../../models/social_model.dart';
import '../../sources/i_socials_data_source.dart';
import '../i_socials_repository.dart';

/// Concrete implementation of [ISocialsRepository].
///
/// Delegates all operations to the injected [ISocialsDataSource].
class SocialsRepositoryImpl implements ISocialsRepository {
  const SocialsRepositoryImpl(this._dataSource);

  final ISocialsDataSource _dataSource;

  @override
  Future<List<SocialModel>> getAllSocials() => _dataSource.getAllSocials();

  @override
  Future<List<SocialModel>> getPrimarySocials() =>
      _dataSource.getPrimarySocials();
}
