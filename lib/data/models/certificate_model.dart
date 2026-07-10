/// Represents a professional certification.
class CertificateModel {
  const CertificateModel({
    required this.id,
    required this.title,
    required this.issuer,
    this.issuedDate,
    this.credentialId,
    this.credentialUrl,
    this.imageAsset,
    this.skills = const [],
  });

  final String id;
  final String title;
  final String issuer;

  /// Human-readable issue date, e.g. "March 2024"
  final String? issuedDate;

  final String? credentialId;
  final String? credentialUrl;
  final String? imageAsset;
  final List<String> skills;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'issuer': issuer,
        'issued_date': issuedDate,
        'credential_id': credentialId,
        'credential_url': credentialUrl,
        'image_asset': imageAsset,
        'skills': skills,
      };

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      CertificateModel(
        id: json['id'] as String,
        title: json['title'] as String,
        issuer: json['issuer'] as String,
        issuedDate: json['issued_date'] as String?,
        credentialId: json['credential_id'] as String?,
        credentialUrl: json['credential_url'] as String?,
        imageAsset: json['image_asset'] as String?,
        skills: List<String>.from(json['skills'] as List? ?? []),
      );
}
