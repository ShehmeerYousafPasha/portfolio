/// Represents a portfolio project entry.
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.type,
    required this.status,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.imageAsset,
    this.isFeatured = false,
    this.completedAt,
  });

  final String id;
  final String title;

  /// One-line summary shown in cards.
  final String shortDescription;

  /// Full description shown in detail / featured view.
  final String longDescription;

  final ProjectType type;
  final ProjectStatus status;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageAsset;
  final bool isFeatured;
  final DateTime? completedAt;

  // ---------------------------------------------------------------------------
  // Serialization — ready for Supabase migration
  // ---------------------------------------------------------------------------
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'short_description': shortDescription,
        'long_description': longDescription,
        'type': type.name,
        'status': status.name,
        'technologies': technologies,
        'github_url': githubUrl,
        'live_url': liveUrl,
        'image_asset': imageAsset,
        'is_featured': isFeatured,
        'completed_at': completedAt?.toIso8601String(),
      };

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'] as String,
        title: json['title'] as String,
        shortDescription: json['short_description'] as String,
        longDescription: json['long_description'] as String,
        type: ProjectType.values.firstWhere((t) => t.name == json['type']),
        status:
            ProjectStatus.values.firstWhere((s) => s.name == json['status']),
        technologies: List<String>.from(json['technologies'] as List),
        githubUrl: json['github_url'] as String?,
        liveUrl: json['live_url'] as String?,
        imageAsset: json['image_asset'] as String?,
        isFeatured: json['is_featured'] as bool? ?? false,
        completedAt: json['completed_at'] != null
            ? DateTime.parse(json['completed_at'] as String)
            : null,
      );
}

enum ProjectType {
  featured,
  other;
}

enum ProjectStatus {
  completed,
  inProgress,
  archived;

  String get label => switch (this) {
        ProjectStatus.completed => 'Completed',
        ProjectStatus.inProgress => 'In Progress',
        ProjectStatus.archived => 'Archived',
      };
}
