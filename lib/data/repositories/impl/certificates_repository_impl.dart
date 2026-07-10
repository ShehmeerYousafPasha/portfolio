import '../../models/certificate_model.dart';
import '../../sources/i_certificates_data_source.dart';
import '../i_certificates_repository.dart';

/// Concrete implementation of [ICertificatesRepository].
///
/// Delegates all operations to the injected [ICertificatesDataSource].
class CertificatesRepositoryImpl implements ICertificatesRepository {
  const CertificatesRepositoryImpl(this._dataSource);

  final ICertificatesDataSource _dataSource;

  @override
  Future<List<CertificateModel>> getAllCertificates() =>
      _dataSource.getAllCertificates();
}
