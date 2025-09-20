import 'project.dart';

class Testimonial {
  final int id;
  final String name;
  final String position;
  final String company;
  final String content;
  final String? email;
  final String? linkedinUrl;
  final String? avatar;
  final bool isFeatured;
  final bool isPublished;
  final Project? relatedProject;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  Testimonial({
    required this.id,
    required this.name,
    required this.position,
    required this.company,
    required this.content,
    this.email,
    this.linkedinUrl,
    this.avatar,
    required this.isFeatured,
    required this.isPublished,
    this.relatedProject,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      company: json['company'],
      content: json['content'],
      email: json['email'],
      linkedinUrl: json['linkedin_url'],
      avatar: json['avatar'],
      isFeatured: json['is_featured'],
      isPublished: json['is_published'],
      relatedProject: json['related_project'] != null
          ? Project.fromJson(json['related_project'])
          : null,
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'company': company,
      'content': content,
      'email': email,
      'linkedin_url': linkedinUrl,
      'avatar': avatar,
      'is_featured': isFeatured,
      'is_published': isPublished,
      'related_project': relatedProject?.toJson(),
      'order': order,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper method to get person's full title
  String get fullTitle => '$position at $company';
}
