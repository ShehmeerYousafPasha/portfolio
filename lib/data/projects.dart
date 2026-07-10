import 'models/project_model.dart';

/// All portfolio projects for Shehmeer Yousaf.
///
/// Order: Featured first, then others in reverse chronological order.
/// When migrating to Supabase, replace with a repository fetch.
const List<ProjectModel> projectsData = [
  // ---------------------------------------------------------------------------
  // Featured Project
  // ---------------------------------------------------------------------------
  ProjectModel(
    id: 'mechkonnect',
    title: 'MechKonnect',
    shortDescription:
        'Automobile service platform connecting users with mechanics.',
    longDescription:
        'MechKonnect is a final year project that serves as a comprehensive '
        'automobile service platform. It connects vehicle owners with nearby '
        'mechanics, enabling seamless service booking and management. '
        'Built with Flutter and powered by Supabase as the backend.',
    type: ProjectType.featured,
    status: ProjectStatus.completed,
    technologies: ['Flutter', 'Dart', 'Supabase', 'PostgreSQL'],
    isFeatured: true,
    // No project screenshot has been added yet; the UI renders its branded
    // fallback panel until one is available.
    // githubUrl: '', // Add when available
  ),

  // ---------------------------------------------------------------------------
  // Other Projects
  // ---------------------------------------------------------------------------
  ProjectModel(
    id: 'gpa-cgpa-calculator',
    title: 'GPA & CGPA Calculator',
    shortDescription:
        'Academic calculator for GPA and CGPA computation.',
    longDescription:
        'A Flutter utility app designed to help students calculate their '
        'semester GPA and cumulative CGPA with a clean, intuitive interface.',
    type: ProjectType.other,
    status: ProjectStatus.completed,
    technologies: ['Flutter', 'Dart'],
  ),
  ProjectModel(
    id: 'library-management-web',
    title: 'Library Management System (Web)',
    shortDescription: 'Web-based system for managing library operations.',
    longDescription:
        'A comprehensive web-based library management system for handling '
        'book catalogues, member registration, and borrowing workflows.',
    type: ProjectType.other,
    status: ProjectStatus.completed,
    technologies: ['HTML', 'CSS', 'JavaScript'],
  ),
  ProjectModel(
    id: 'library-management-desktop',
    title: 'Library Management System (Desktop)',
    shortDescription: 'Desktop application for library administration.',
    longDescription:
        'A desktop application version of the library management system '
        'with a focus on administrative operations and reporting.',
    type: ProjectType.other,
    status: ProjectStatus.completed,
    technologies: ['Desktop', 'Database'],
  ),
  ProjectModel(
    id: 'virtual-system-setup',
    title: 'Virtual System Setup',
    shortDescription:
        'Virtual environment configuration and networking setup.',
    longDescription:
        'A project covering the configuration of virtualized environments, '
        'including networking setup and system administration tasks.',
    type: ProjectType.other,
    status: ProjectStatus.completed,
    technologies: ['Networking', 'Virtualization'],
  ),
];
