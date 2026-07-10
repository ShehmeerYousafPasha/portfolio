import 'models/profile_model.dart';
import '../core/constants/app_assets.dart';

/// Single source of truth for Shehmeer Yousaf's personal information.
///
/// When migrating to Supabase CMS, replace this constant with
/// a repository that fetches from the database.
const profileData = ProfileModel(
  // Identity
  name: 'Shehmeer Yousaf',
  title: 'App Developer (Flutter)',
  headline: 'Building Mobile & Web Experiences',
  locationLine: 'Rawalpindi • Islamabad',
  country: 'Pakistan',
  availability: 'Open To Remote Opportunities',

  // Contact — phone number is NOT stored here by design.
  // WhatsApp CTA is handled via the URL below.
  email: 'shehmeeryousaf.sy@gmail.com',
  githubUrl: 'https://github.com/ShehmeerYousafPasha',
  linkedinUrl: 'https://www.linkedin.com/in/shehmeeryousafpasha/',
  whatsappUrl: 'https://wa.me/+923055243268',

  // Assets
  profilePhotoAsset: AppAssets.profilePhoto,

  // Education
  degree: 'Bachelor of Science in Information Technology',
  university: 'International Islamic University Islamabad',
  cgpa: 3.56,

  // Status
  currentCompany: 'Seasonedly',
  isOpenToWork: true,

  // Current Focus Section
  currentFocusAreas: [
    'Flutter Development',
    'Mobile Applications',
    'Performance Optimization',
    'Production App Development',
    'Clean Architecture',
    'API Integration',
  ],

  // Quick Snapshot Section
  quickSnapshotItems: [
    SnapshotItem(label: 'Role', value: 'App Developer'),
    SnapshotItem(label: 'Specialization', value: 'Flutter Developer'),
    SnapshotItem(label: 'Education', value: 'IT Graduate'),
    SnapshotItem(label: 'CGPA', value: '3.56'),
    SnapshotItem(label: 'Currently At', value: 'Seasonedly'),
    SnapshotItem(label: 'Status', value: 'Open To Remote Opportunities'),
  ],
);
