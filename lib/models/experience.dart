import 'skill.dart';

class Experience {
  final int id;
  final String company;
  final String position;
  final String employmentType;
  final String? location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;
  final List<String> keyAchievements;
  final String? companyLogo;
  final String? companyWebsite;
  final List<Skill> skillsUsed;
  final int durationMonths;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.employmentType,
    this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    required this.description,
    required this.keyAchievements,
    this.companyLogo,
    this.companyWebsite,
    required this.skillsUsed,
    required this.durationMonths,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      company: json['company'],
      position: json['position'],
      employmentType: json['employment_type'],
      location: json['location'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      isCurrent: json['is_current'],
      description: json['description'],
      keyAchievements: List<String>.from(json['key_achievements'] ?? []),
      companyLogo: json['company_logo'],
      companyWebsite: json['company_website'],
      skillsUsed: (json['skills_used'] as List<dynamic>? ?? [])
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      durationMonths: json['duration_months'],
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'employment_type': employmentType,
      'location': location,
      'start_date': startDate.toIso8601String().split('T')[0],
      'end_date': endDate?.toIso8601String().split('T')[0],
      'is_current': isCurrent,
      'description': description,
      'key_achievements': keyAchievements,
      'company_logo': companyLogo,
      'company_website': companyWebsite,
      'skills_used': skillsUsed.map((skill) => skill.toJson()).toList(),
      'duration_months': durationMonths,
      'order': order,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Helper methods
  String get employmentTypeDisplayName {
    switch (employmentType) {
      case 'full_time':
        return 'Full Time';
      case 'part_time':
        return 'Part Time';
      case 'contract':
        return 'Contract';
      case 'freelance':
        return 'Freelance';
      case 'internship':
        return 'Internship';
      case 'volunteer':
        return 'Volunteer';
      default:
        return employmentType;
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

  String get dateRange {
    final start = '${_monthName(startDate.month)} ${startDate.year}';
    if (isCurrent) {
      return '$start - Present';
    }
    if (endDate != null) {
      final end = '${_monthName(endDate!.month)} ${endDate!.year}';
      return '$start - $end';
    }
    return start;
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }
}
