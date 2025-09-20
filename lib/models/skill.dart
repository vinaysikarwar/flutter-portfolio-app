class Skill {
  final int id;
  final String name;
  final String category;
  final String proficiency;
  final int proficiencyPercentage;
  final String? icon;
  final bool isFeatured;
  final int order;
  final DateTime createdAt;

  Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.proficiency,
    required this.proficiencyPercentage,
    this.icon,
    required this.isFeatured,
    required this.order,
    required this.createdAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      proficiency: json['proficiency'],
      proficiencyPercentage: json['proficiency_percentage'],
      icon: json['icon'],
      isFeatured: json['is_featured'],
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'proficiency': proficiency,
      'proficiency_percentage': proficiencyPercentage,
      'icon': icon,
      'is_featured': isFeatured,
      'order': order,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Helper method to get category display name
  String get categoryDisplayName {
    switch (category) {
      case 'frontend':
        return 'Frontend';
      case 'backend':
        return 'Backend';
      case 'mobile':
        return 'Mobile';
      case 'database':
        return 'Database';
      case 'devops':
        return 'DevOps';
      case 'design':
        return 'Design';
      case 'other':
        return 'Other';
      default:
        return category;
    }
  }

  // Helper method to get proficiency display name
  String get proficiencyDisplayName {
    switch (proficiency) {
      case 'beginner':
        return 'Beginner';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      case 'expert':
        return 'Expert';
      default:
        return proficiency;
    }
  }
}
