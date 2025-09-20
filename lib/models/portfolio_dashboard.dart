import 'profile.dart';
import 'skill.dart';
import 'project.dart';
import 'experience.dart';
import 'testimonial.dart';

class PortfolioDashboard {
  final Profile? profile;
  final List<Skill> featuredSkills;
  final List<Project> featuredProjects;
  final List<Experience> recentExperience;
  final List<Testimonial> featuredTestimonials;

  PortfolioDashboard({
    this.profile,
    required this.featuredSkills,
    required this.featuredProjects,
    required this.recentExperience,
    required this.featuredTestimonials,
  });

  factory PortfolioDashboard.fromJson(Map<String, dynamic> json) {
    return PortfolioDashboard(
      profile: json['profile'] != null
          ? Profile.fromJson(json['profile'])
          : null,
      featuredSkills: (json['featured_skills'] as List<dynamic>? ?? [])
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      featuredProjects: (json['featured_projects'] as List<dynamic>? ?? [])
          .map((project) => Project.fromJson(project))
          .toList(),
      recentExperience: (json['recent_experience'] as List<dynamic>? ?? [])
          .map((experience) => Experience.fromJson(experience))
          .toList(),
      featuredTestimonials:
          (json['featured_testimonials'] as List<dynamic>? ?? [])
              .map((testimonial) => Testimonial.fromJson(testimonial))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile?.toJson(),
      'featured_skills': featuredSkills.map((skill) => skill.toJson()).toList(),
      'featured_projects': featuredProjects
          .map((project) => project.toJson())
          .toList(),
      'recent_experience': recentExperience
          .map((experience) => experience.toJson())
          .toList(),
      'featured_testimonials': featuredTestimonials
          .map((testimonial) => testimonial.toJson())
          .toList(),
    };
  }

  /// Computed stats properties
  int get totalProjects => featuredProjects.length;
  int get totalSkills => featuredSkills.length;
  int get totalExperience => recentExperience.length;
  int get yearsExperience {
    if (recentExperience.isEmpty) return 0;
    // Calculate years from the earliest experience start date
    final earliestDate = recentExperience
        .map((exp) => exp.startDate)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    return DateTime.now().difference(earliestDate).inDays ~/ 365;
  }
}

class PortfolioStats {
  final int totalProjects;
  final int completedProjects;
  final int totalSkills;
  final int yearsExperience;
  final int certifications;
  final int testimonials;

  PortfolioStats({
    required this.totalProjects,
    required this.completedProjects,
    required this.totalSkills,
    required this.yearsExperience,
    required this.certifications,
    required this.testimonials,
  });

  factory PortfolioStats.fromJson(Map<String, dynamic> json) {
    return PortfolioStats(
      totalProjects: json['total_projects'] ?? 0,
      completedProjects: json['completed_projects'] ?? 0,
      totalSkills: json['total_skills'] ?? 0,
      yearsExperience: json['years_experience'] ?? 0,
      certifications: json['certifications'] ?? 0,
      testimonials: json['testimonials'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_projects': totalProjects,
      'completed_projects': completedProjects,
      'total_skills': totalSkills,
      'years_experience': yearsExperience,
      'certifications': certifications,
      'testimonials': testimonials,
    };
  }
}
