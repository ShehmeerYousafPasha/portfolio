/// Represents a single work experience entry.
class ExperienceModel {
  const ExperienceModel({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    required this.description,
    required this.responsibilities,
    required this.technologies,
    required this.projects,
    required this.location,
    this.companyUrl,
    this.companyLogoAsset,
  });

  final String id;
  final String company;
  final String role;

  /// Human-readable duration string, e.g. "June 2025 – Present"
  final String duration;

  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;
  final List<String> responsibilities;
  final List<String> technologies;

  /// Grouped project entries (e.g. Transportation → [Eden Rider, Eden Driver])
  final List<ExperienceProjectGroup> projects;

  final String location;
  final String? companyUrl;
  final String? companyLogoAsset;

  Map<String, dynamic> toJson() => {
        'id': id,
        'company': company,
        'role': role,
        'duration': duration,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'is_current': isCurrent,
        'description': description,
        'responsibilities': responsibilities,
        'technologies': technologies,
        'location': location,
        'company_url': companyUrl,
        'projects': projects.map((p) => p.toJson()).toList(),
      };
}

/// A category of apps within a single work experience.
///
/// Example: category = "Transportation", apps = ["Eden Rider", "Eden Driver"]
class ExperienceProjectGroup {
  const ExperienceProjectGroup({
    required this.category,
    required this.apps,
  });

  final String category;
  final List<String> apps;

  Map<String, dynamic> toJson() => {
        'category': category,
        'apps': apps,
      };

  factory ExperienceProjectGroup.fromJson(Map<String, dynamic> json) =>
      ExperienceProjectGroup(
        category: json['category'] as String,
        apps: List<String>.from(json['apps'] as List),
      );
}
