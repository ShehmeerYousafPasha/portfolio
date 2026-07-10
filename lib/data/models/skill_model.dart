/// Represents a single skill.
class SkillModel {
  const SkillModel({
    required this.id,
    required this.name,
    required this.category,
    required this.level,
    this.iconAsset,
  });

  final String id;
  final String name;
  final String category;
  final SkillLevel level;

  /// Optional local asset path for a skill icon.
  final String? iconAsset;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'level': level.name,
        'icon_asset': iconAsset,
      };

  factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        level: SkillLevel.values.firstWhere((l) => l.name == json['level']),
        iconAsset: json['icon_asset'] as String?,
      );
}

/// Groups skills by category for display.
class SkillCategory {
  const SkillCategory({
    required this.name,
    required this.skills,
  });

  final String name;
  final List<SkillModel> skills;
}

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert;

  String get label => switch (this) {
        SkillLevel.beginner => 'Beginner',
        SkillLevel.intermediate => 'Intermediate',
        SkillLevel.advanced => 'Advanced',
        SkillLevel.expert => 'Expert',
      };
}
