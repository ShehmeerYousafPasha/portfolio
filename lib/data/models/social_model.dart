/// Represents a social or contact link.
class SocialModel {
  const SocialModel({
    required this.id,
    required this.platform,
    required this.label,
    required this.url,
    this.iconAsset,
    this.isPrimary = false,
    required this.displayOrder,
  });

  final String id;
  final SocialPlatform platform;

  /// Display label shown in UI, e.g. "shehmeeryousaf.sy@gmail.com"
  final String label;

  /// Full URL including scheme, e.g. "mailto:...", "https://..."
  final String url;

  final String? iconAsset;
  final bool isPrimary;

  /// Lower number = shown first
  final int displayOrder;

  Map<String, dynamic> toJson() => {
        'id': id,
        'platform': platform.name,
        'label': label,
        'url': url,
        'icon_asset': iconAsset,
        'is_primary': isPrimary,
        'display_order': displayOrder,
      };
}

enum SocialPlatform {
  email,
  github,
  linkedin,
  whatsapp,
  twitter,
  website;

  String get displayName => switch (this) {
        SocialPlatform.email => 'Email',
        SocialPlatform.github => 'GitHub',
        SocialPlatform.linkedin => 'LinkedIn',
        SocialPlatform.whatsapp => 'WhatsApp',
        SocialPlatform.twitter => 'Twitter',
        SocialPlatform.website => 'Website',
      };
}
