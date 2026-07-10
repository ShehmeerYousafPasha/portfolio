import '../models/certificate_model.dart';

/// Repository contract for certification data.
///
/// The UI layer depends only on this interface — never on any
/// concrete data source or implementation class.
///
/// Implementations: [CertificatesRepositoryImpl]
abstract class ICertificatesRepository {
  /// Returns all certificates in display order.
  Future<List<CertificateModel>> getAllCertificates();
}
