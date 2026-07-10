import 'models/skill_model.dart';

/// Skills for Shehmeer Yousaf, organized by category.
///
/// Categories and order match the PROJECT_CONTEXT specification.
/// When migrating to Supabase, replace with a repository fetch.
const List<SkillCategory> skillsData = [
  SkillCategory(
    name: 'Mobile Development',
    skills: [
      SkillModel(
        id: 'flutter',
        name: 'Flutter',
        category: 'Mobile Development',
        level: SkillLevel.advanced,
      ),
      SkillModel(
        id: 'dart',
        name: 'Dart',
        category: 'Mobile Development',
        level: SkillLevel.advanced,
      ),
    ],
  ),
  SkillCategory(
    name: 'Backend & APIs',
    skills: [
      SkillModel(
        id: 'rest-apis',
        name: 'REST APIs',
        category: 'Backend & APIs',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'json',
        name: 'JSON',
        category: 'Backend & APIs',
        level: SkillLevel.advanced,
      ),
    ],
  ),
  SkillCategory(
    name: 'Databases',
    skills: [
      SkillModel(
        id: 'postgresql',
        name: 'PostgreSQL',
        category: 'Databases',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'mysql',
        name: 'MySQL',
        category: 'Databases',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'supabase',
        name: 'Supabase',
        category: 'Databases',
        level: SkillLevel.intermediate,
      ),
    ],
  ),
  SkillCategory(
    name: 'Tools',
    skills: [
      SkillModel(
        id: 'git',
        name: 'Git',
        category: 'Tools',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'github',
        name: 'GitHub',
        category: 'Tools',
        level: SkillLevel.intermediate,
      ),
    ],
  ),
  SkillCategory(
    name: 'Web',
    skills: [
      SkillModel(
        id: 'html',
        name: 'HTML',
        category: 'Web',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'css',
        name: 'CSS',
        category: 'Web',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'javascript',
        name: 'JavaScript',
        category: 'Web',
        level: SkillLevel.intermediate,
      ),
    ],
  ),
  SkillCategory(
    name: 'Other',
    skills: [
      SkillModel(
        id: 'networking',
        name: 'Networking',
        category: 'Other',
        level: SkillLevel.intermediate,
      ),
      SkillModel(
        id: 'cybersecurity',
        name: 'Cybersecurity Fundamentals',
        category: 'Other',
        level: SkillLevel.beginner,
      ),
    ],
  ),
];
