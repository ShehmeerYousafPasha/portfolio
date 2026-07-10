import 'models/social_model.dart';

/// Contact and social links for Shehmeer Yousaf.
///
/// Priority order matches PROJECT_CONTEXT specification:
/// 1. Contact Form (handled by ContactPage — not a URL)
/// 2. Email
/// 3. WhatsApp
/// 4. LinkedIn
/// 5. GitHub
///
/// Phone number is intentionally NOT stored here.
const List<SocialModel> socialsData = [
  SocialModel(
    id: 'email',
    platform: SocialPlatform.email,
    label: 'shehmeeryousaf.sy@gmail.com',
    url: 'mailto:shehmeeryousaf.sy@gmail.com',
    isPrimary: true,
    displayOrder: 1,
  ),
  SocialModel(
    id: 'whatsapp',
    platform: SocialPlatform.whatsapp,
    label: 'WhatsApp',
    url: 'https://wa.me/+923055243268',
    isPrimary: true,
    displayOrder: 2,
  ),
  SocialModel(
    id: 'linkedin',
    platform: SocialPlatform.linkedin,
    label: 'linkedin.com/in/shehmeeryousafpasha',
    url: 'https://www.linkedin.com/in/shehmeeryousafpasha/',
    isPrimary: true,
    displayOrder: 3,
  ),
  SocialModel(
    id: 'github',
    platform: SocialPlatform.github,
    label: 'github.com/ShehmeerYousafPasha',
    url: 'https://github.com/ShehmeerYousafPasha',
    isPrimary: true,
    displayOrder: 4,
  ),
];
