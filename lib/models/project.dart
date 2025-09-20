import 'skill.dart';

class Project {
  final int id;
  final String title;
  final String slug;
  final String shortDescription;
  final String longDescription;
  final String projectType;
  final String status;
  final String? liveUrl;
  final String? githubUrl;
  final String? demoUrl;
  final DateTime startDate;
  final DateTime? endDate;
  final String? client;
  final int teamSize;
  final String? featuredImage;
  final List<String> galleryImages;
  final bool isFeatured;
  final bool isPublished;
  final int order;
  final String? metaDescription;
  final List<Skill> skillsUsed;
  final int durationMonths;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.title,
    required this.slug,
    required this.shortDescription,
    required this.longDescription,
    required this.projectType,
    required this.status,
    this.liveUrl,
    this.githubUrl,
    this.demoUrl,
    required this.startDate,
    this.endDate,
    this.client,
    required this.teamSize,
    this.featuredImage,
    required this.galleryImages,
    required this.isFeatured,
    required this.isPublished,
    required this.order,
    this.metaDescription,
    required this.skillsUsed,
    required this.durationMonths,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      projectType: json['project_type'],
      status: json['status'],
      liveUrl: json['live_url'],
      githubUrl: json['github_url'],
      demoUrl: json['demo_url'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      client: json['client'],
      teamSize: json['team_size'],
      featuredImage: json['featured_image'],
      galleryImages: List<String>.from(json['gallery_images'] ?? []),
      isFeatured: json['is_featured'],
      isPublished: json['is_published'],
      order: json['order'],
      metaDescription: json['meta_description'],
      skillsUsed: (json['skills_used'] as List<dynamic>? ?? [])
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      durationMonths: json['duration_months'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'short_description': shortDescription,
      'long_description': longDescription,
      'project_type': projectType,
      'status': status,
      'live_url': liveUrl,
      'github_url': githubUrl,
      'demo_url': demoUrl,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate?.toIso8601String().split('T')[0],
      'client': client,
      'team_size': teamSize,
      'featured_image': featuredImage,
      'gallery_images': galleryImages,
      'is_featured': isFeatured,
      'is_published': isPublished,
      'order': order,
      'meta_description': metaDescription,
      'skills_used': skillsUsed.map((skill) => skill.toJson()).toList(),
      'duration_months': durationMonths,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  String get projectTypeDisplayName {
    switch (projectType) {
      case 'web':
        return 'Web Application';
      case 'mobile':
        return 'Mobile Application';
      case 'desktop':
        return 'Desktop Application';
      case 'api':
        return 'API/Backend';
      case 'library':
        return 'Library/Package';
      case 'other':
        return 'Other';
      default:
        return projectType;
    }
  }

  String get statusDisplayName {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In Progress';
      case 'on_hold':
        return 'On Hold';
      case 'planning':
        return 'Planning';
      default:
        return status;
    }
  }

  String get durationDisplay {
    if (durationMonths <= 0) return 'Less than a month';
    if (durationMonths == 1) return '1 month';
    if (durationMonths < 12) return '$durationMonths months';

    final years = durationMonths ~/ 12;
    final months = durationMonths % 12;

    if (months == 0) {
      return years == 1 ? '1 year' : '$years years';
    } else {
      return '$years year${years > 1 ? 's' : ''} $months month${months > 1 ? 's' : ''}';
    }
  }
}
