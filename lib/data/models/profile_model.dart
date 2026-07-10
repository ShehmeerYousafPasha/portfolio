/// Single source of truth for Shehmeer Yousaf's personal information.
///
/// All sections that need personal data should read from [profileData]
/// in `lib/data/profile.dart` — never hard-code values in widgets.
class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.title,
    required this.headline,
    required this.locationLine,
    required this.country,
    required this.availability,
    required this.email,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.whatsappUrl,
    this.profilePhotoAsset,
    required this.degree,
    required this.university,
    required this.cgpa,
    required this.currentCompany,
    required this.isOpenToWork,
    this.currentFocusAreas = const [],
    this.quickSnapshotItems = const [],
  });

  // ---------------------------------------------------------------------------
  // Identity
  // ---------------------------------------------------------------------------
  final String name;
  final String title;
  final String headline;

  /// E.g. "Rawalpindi • Islamabad"
  final String locationLine;

  final String country;

  /// E.g. "Open To Remote Opportunities"
  final String availability;

  // ---------------------------------------------------------------------------
  // Contact
  // ---------------------------------------------------------------------------
  final String email;
  final String githubUrl;
  final String linkedinUrl;

  /// WhatsApp CTA URL — phone number is not exposed publicly.
  final String whatsappUrl;

  // ---------------------------------------------------------------------------
  // Assets
  // ---------------------------------------------------------------------------
  final String? profilePhotoAsset;

  // ---------------------------------------------------------------------------
  // Education
  // ---------------------------------------------------------------------------
  final String degree;
  final String university;
  final double cgpa;

  // ---------------------------------------------------------------------------
  // Current Status
  // ---------------------------------------------------------------------------
  final String currentCompany;
  final bool isOpenToWork;

  /// Used in the Current Focus section.
  final List<String> currentFocusAreas;

  /// Used in the Quick Snapshot section.
  final List<SnapshotItem> quickSnapshotItems;
}

/// A single item in the Quick Snapshot section.
class SnapshotItem {
  const SnapshotItem({
    required this.label,
    required this.value,
    this.iconLabel,
  });

  final String label;
  final String value;

  /// Optional emoji or short icon label.
  final String? iconLabel;
}
