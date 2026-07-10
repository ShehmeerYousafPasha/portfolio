import '../../models/certificate_model.dart';
import '../i_certificates_data_source.dart';
import '../../certificates.dart';

/// Local implementation of [ICertificatesDataSource].
///
/// Reads from the static [certificatesData] list defined in
/// `lib/data/certificates.dart`.
class LocalCertificatesDataSource implements ICertificatesDataSource {
  const LocalCertificatesDataSource();

  @override
  Future<List<CertificateModel>> getAllCertificates() =>
      Future.value(List.unmodifiable(certificatesData));
}
