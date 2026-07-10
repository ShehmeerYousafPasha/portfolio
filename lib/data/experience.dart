import 'models/experience_model.dart';

/// Professional work experience for Shehmeer Yousaf.
///
/// Order: Most recent first.
/// When migrating to Supabase, replace with a repository fetch.
final List<ExperienceModel> experienceData = [
  ExperienceModel(
    id: 'seasonedly',
    company: 'Seasonedly',
    role: 'App Developer',
    duration: 'June 2025 – Present',
    startDate: DateTime(2025, 6),
    isCurrent: true,
    description:
        'Contributing to production Flutter applications across transportation, '
        'logistics, and delivery platforms.',
    responsibilities: [
      'Flutter Development',
      'Feature Development',
      'UI Implementation',
      'API Integration',
      'Performance Optimization',
      'Bug Fixing',
      'Team Collaboration',
    ],
    technologies: ['Flutter', 'Dart', 'REST APIs', 'Git', 'GitHub'],
    location: 'Remote',
    projects: [
      const ExperienceProjectGroup(
        category: 'Transportation',
        apps: ['Eden Rider', 'Eden Driver', 'Eden Corporate'],
      ),
      const ExperienceProjectGroup(
        category: 'Logistics',
        apps: ['Return App', 'Return Driver'],
      ),
      const ExperienceProjectGroup(
        category: 'Delivery',
        apps: [
          'DeliGo',
          'DeliGo Vendor',
          'DeliGo Provider',
          'DeliGo Rider',
        ],
      ),
    ],
  ),
];
