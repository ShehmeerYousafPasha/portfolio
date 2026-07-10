import '../models/certificate_model.dart';

/// Abstract contract for retrieving certification data.
///
/// Current implementation: [LocalCertificatesDataSource] (static Dart data).
/// Future implementation: SupabaseCertificatesDataSource — drop-in replacement.
abstract class ICertificatesDataSource {
  /// Returns all certificates in display order.
  Future<List<CertificateModel>> getAllCertificates();
}
