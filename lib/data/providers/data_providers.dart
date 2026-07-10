import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/certificate_model.dart';
import '../models/skill_model.dart';
import '../models/social_model.dart';

// Data Source Interfaces
import '../sources/i_profile_data_source.dart';
import '../sources/i_projects_data_source.dart';
import '../sources/i_experience_data_source.dart';
import '../sources/i_certificates_data_source.dart';
import '../sources/i_skills_data_source.dart';
import '../sources/i_socials_data_source.dart';

// Local Data Sources
import '../sources/local/local_profile_data_source.dart';
import '../sources/local/local_projects_data_source.dart';
import '../sources/local/local_experience_data_source.dart';
import '../sources/local/local_certificates_data_source.dart';
import '../sources/local/local_skills_data_source.dart';
import '../sources/local/local_socials_data_source.dart';

// Repository Interfaces
import '../repositories/i_profile_repository.dart';
import '../repositories/i_projects_repository.dart';
import '../repositories/i_experience_repository.dart';
import '../repositories/i_certificates_repository.dart';
import '../repositories/i_skills_repository.dart';
import '../repositories/i_socials_repository.dart';

// Repository Implementations
import '../repositories/impl/profile_repository_impl.dart';
import '../repositories/impl/projects_repository_impl.dart';
import '../repositories/impl/experience_repository_impl.dart';
import '../repositories/impl/certificates_repository_impl.dart';
import '../repositories/impl/skills_repository_impl.dart';
import '../repositories/impl/socials_repository_impl.dart';

// ============================================================
// DATA SOURCE PROVIDERS
// Swapping local → Supabase: change only this section.
// ============================================================

/// Provides the active profile data source.
final profileDataSourceProvider = Provider<IProfileDataSource>(
  (_) => const LocalProfileDataSource(),
);

/// Provides the active projects data source.
final projectsDataSourceProvider = Provider<IProjectsDataSource>(
  (_) => const LocalProjectsDataSource(),
);

/// Provides the active experience data source.
final experienceDataSourceProvider = Provider<IExperienceDataSource>(
  (_) => const LocalExperienceDataSource(),
);

/// Provides the active certificates data source.
final certificatesDataSourceProvider = Provider<ICertificatesDataSource>(
  (_) => const LocalCertificatesDataSource(),
);

/// Provides the active skills data source.
final skillsDataSourceProvider = Provider<ISkillsDataSource>(
  (_) => const LocalSkillsDataSource(),
);

/// Provides the active socials data source.
final socialsDataSourceProvider = Provider<ISocialsDataSource>(
  (_) => const LocalSocialsDataSource(),
);

// ============================================================
// REPOSITORY PROVIDERS
// Repositories receive their data source via Riverpod injection.
// ============================================================

/// Provides the profile repository.
final profileRepositoryProvider = Provider<IProfileRepository>(
  (ref) => ProfileRepositoryImpl(
    ref.watch(profileDataSourceProvider),
  ),
);

/// Provides the projects repository.
final projectsRepositoryProvider = Provider<IProjectsRepository>(
  (ref) => ProjectsRepositoryImpl(
    ref.watch(projectsDataSourceProvider),
  ),
);

/// Provides the experience repository.
final experienceRepositoryProvider = Provider<IExperienceRepository>(
  (ref) => ExperienceRepositoryImpl(
    ref.watch(experienceDataSourceProvider),
  ),
);

/// Provides the certificates repository.
final certificatesRepositoryProvider = Provider<ICertificatesRepository>(
  (ref) => CertificatesRepositoryImpl(
    ref.watch(certificatesDataSourceProvider),
  ),
);

/// Provides the skills repository.
final skillsRepositoryProvider = Provider<ISkillsRepository>(
  (ref) => SkillsRepositoryImpl(
    ref.watch(skillsDataSourceProvider),
  ),
);

/// Provides the socials repository.
final socialsRepositoryProvider = Provider<ISocialsRepository>(
  (ref) => SocialsRepositoryImpl(
    ref.watch(socialsDataSourceProvider),
  ),
);

// ============================================================
// DATA PROVIDERS — consumed directly by UI widgets.
//
// All return AsyncValue<T> via FutureProvider.
// UI usage:
//   final profile = ref.watch(profileProvider);
//   profile.when(data: ..., loading: ..., error: ...);
// ============================================================

/// Provides the full profile as [AsyncValue<ProfileModel>].
final profileProvider = FutureProvider<ProfileModel>(
  (ref) => ref.watch(profileRepositoryProvider).getProfile(),
);

/// Provides all projects as [AsyncValue<List<ProjectModel>>].
final allProjectsProvider = FutureProvider<List<ProjectModel>>(
  (ref) => ref.watch(projectsRepositoryProvider).getAllProjects(),
);

/// Provides the featured project as [AsyncValue<ProjectModel?>].
final featuredProjectProvider = FutureProvider<ProjectModel?>(
  (ref) => ref.watch(projectsRepositoryProvider).getFeaturedProject(),
);

/// Provides non-featured projects as [AsyncValue<List<ProjectModel>>].
final otherProjectsProvider = FutureProvider<List<ProjectModel>>(
  (ref) => ref.watch(projectsRepositoryProvider).getOtherProjects(),
);

/// Provides all experience entries as [AsyncValue<List<ExperienceModel>>].
final allExperienceProvider = FutureProvider<List<ExperienceModel>>(
  (ref) => ref.watch(experienceRepositoryProvider).getAllExperience(),
);

/// Provides the current role as [AsyncValue<ExperienceModel?>].
final currentExperienceProvider = FutureProvider<ExperienceModel?>(
  (ref) => ref.watch(experienceRepositoryProvider).getCurrentExperience(),
);

/// Provides all certificates as [AsyncValue<List<CertificateModel>>].
final allCertificatesProvider = FutureProvider<List<CertificateModel>>(
  (ref) => ref.watch(certificatesRepositoryProvider).getAllCertificates(),
);

/// Provides all skill categories as [AsyncValue<List<SkillCategory>>].
final skillCategoriesProvider = FutureProvider<List<SkillCategory>>(
  (ref) => ref.watch(skillsRepositoryProvider).getAllSkillCategories(),
);

/// Provides a flat list of all skills as [AsyncValue<List<SkillModel>>].
final allSkillsProvider = FutureProvider<List<SkillModel>>(
  (ref) => ref.watch(skillsRepositoryProvider).getAllSkills(),
);

/// Provides all social links as [AsyncValue<List<SocialModel>>].
final allSocialsProvider = FutureProvider<List<SocialModel>>(
  (ref) => ref.watch(socialsRepositoryProvider).getAllSocials(),
);

/// Provides primary social links as [AsyncValue<List<SocialModel>>].
/// Used in hero CTAs, footer, and contact section.
final primarySocialsProvider = FutureProvider<List<SocialModel>>(
  (ref) => ref.watch(socialsRepositoryProvider).getPrimarySocials(),
);
