class Profile {
  final int id;
  final String name;
  final String title;
  final String bio;
  final String location;
  final String email;
  final String? phone;
  final String? website;
  final String? linkedinUrl;
  final String? githubUrl;
  final String? twitterUrl;
  final String? profileImage;
  final String? resumeFile;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.location,
    required this.email,
    this.phone,
    this.website,
    this.linkedinUrl,
    this.githubUrl,
    this.twitterUrl,
    this.profileImage,
    this.resumeFile,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      bio: json['bio'],
      location: json['location'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      linkedinUrl: json['linkedin_url'],
      githubUrl: json['github_url'],
      twitterUrl: json['twitter_url'],
      profileImage: json['profile_image'],
      resumeFile: json['resume_file'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'bio': bio,
      'location': location,
      'email': email,
      'phone': phone,
      'website': website,
      'linkedin_url': linkedinUrl,
      'github_url': githubUrl,
      'twitter_url': twitterUrl,
      'profile_image': profileImage,
      'resume_file': resumeFile,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Helper methods
  String get firstName => name.split(' ').first;
  String get lastName =>
      name.split(' ').length > 1 ? name.split(' ').sublist(1).join(' ') : '';
  String get fullName => name;

  /// Mock animated titles - in a real app this could come from API
  List<String> get animatedTitles => [
    title,
    'Full Stack Developer',
    'Technical Lead',
    'Software Engineer',
    'Problem Solver',
  ];

  String? get resumeUrl => resumeFile;
}
