import 'package:flutter/foundation.dart';
import '../models/profile.dart';
import '../models/skill.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/testimonial.dart';
import '../models/portfolio_dashboard.dart';
import '../services/api_service.dart';

/// Data provider class that manages portfolio data with caching and state management
class PortfolioDataProvider extends ChangeNotifier {
  // Data cache
  Profile? _profile;
  List<Skill>? _skills;
  Map<String, List<Skill>>? _skillsByCategory;
  List<Project>? _projects;
  List<Project>? _featuredProjects;
  List<Experience>? _experience;
  List<Testimonial>? _testimonials;
  List<Testimonial>? _featuredTestimonials;
  PortfolioDashboard? _dashboard;

  // Loading states
  bool _isLoadingProfile = false;
  bool _isLoadingSkills = false;
  bool _isLoadingProjects = false;
  bool _isLoadingExperience = false;
  bool _isLoadingTestimonials = false;
  bool _isLoadingDashboard = false;

  // Error states
  String? _profileError;
  String? _skillsError;
  String? _projectsError;
  String? _experienceError;
  String? _testimonialsError;
  String? _dashboardError;

  // Cache duration (5 minutes)
  static const Duration _cacheDuration = Duration(minutes: 5);
  DateTime? _lastProfileFetch;
  DateTime? _lastSkillsFetch;
  DateTime? _lastProjectsFetch;
  DateTime? _lastExperienceFetch;
  DateTime? _lastTestimonialsFetch;
  DateTime? _lastDashboardFetch;

  // Getters for data
  Profile? get profile => _profile;
  List<Skill>? get skills => _skills;
  Map<String, List<Skill>>? get skillsByCategory => _skillsByCategory;
  List<Project>? get projects => _projects;
  List<Project>? get featuredProjects => _featuredProjects;
  List<Experience>? get experience => _experience;
  List<Testimonial>? get testimonials => _testimonials;
  List<Testimonial>? get featuredTestimonials => _featuredTestimonials;
  PortfolioDashboard? get dashboard => _dashboard;

  // Getters for loading states
  bool get isLoadingProfile => _isLoadingProfile;
  bool get isLoadingSkills => _isLoadingSkills;
  bool get isLoadingProjects => _isLoadingProjects;
  bool get isLoadingExperience => _isLoadingExperience;
  bool get isLoadingTestimonials => _isLoadingTestimonials;
  bool get isLoadingDashboard => _isLoadingDashboard;

  // Getters for error states
  String? get profileError => _profileError;
  String? get skillsError => _skillsError;
  String? get projectsError => _projectsError;
  String? get experienceError => _experienceError;
  String? get testimonialsError => _testimonialsError;
  String? get dashboardError => _dashboardError;

  // Check if data is fresh (within cache duration)
  bool _isCacheFresh(DateTime? lastFetch) {
    if (lastFetch == null) return false;
    return DateTime.now().difference(lastFetch) < _cacheDuration;
  }

  // ====== PROFILE METHODS ======

  /// Load profile data
  Future<void> loadProfile({bool forceRefresh = false}) async {
    // Temporarily disable caching for testing
    // if (!forceRefresh && _profile != null && _isCacheFresh(_lastProfileFetch)) {
    //   return; // Use cached data
    // }

    print('🔄 Loading profile from API...');
    _isLoadingProfile = true;
    _profileError = null;
    notifyListeners();

    try {
      final response = await SafeApiService.getProfile();
      if (response.isSuccess) {
        _profile = response.data;
        _lastProfileFetch = DateTime.now();
        _profileError = null;
        print('✅ Profile loaded successfully: ${_profile?.name}');
      } else {
        _profileError = response.error;
        print('❌ Profile load error: ${response.error}');
      }
    } catch (e) {
      _profileError = 'Failed to load profile: $e';
      print('❌ Profile load exception: $e');
    } finally {
      _isLoadingProfile = false;
      notifyListeners();
    }
  }

  // ====== SKILLS METHODS ======

  /// Load skills data
  Future<void> loadSkills({bool forceRefresh = false}) async {
    if (!forceRefresh && _skills != null && _isCacheFresh(_lastSkillsFetch)) {
      return; // Use cached data
    }

    print('🔄 Loading skills from API...');
    _isLoadingSkills = true;
    _skillsError = null;
    notifyListeners();

    try {
      // Load all skills
      final skillsResponse = await SafeApiService.getSkills();
      if (skillsResponse.isSuccess) {
        _skills = skillsResponse.data;
        _lastSkillsFetch = DateTime.now();
        _skillsError = null;
        print('✅ Skills loaded successfully: ${_skills?.length} skills');

        // Also load skills by category
        try {
          _skillsByCategory = await ApiService.getSkillsByCategory();
        } catch (e) {
          if (kDebugMode) {
            print('Failed to load skills by category: $e');
          }
        }
      } else {
        _skillsError = skillsResponse.error;
        print('❌ Skills load error: ${skillsResponse.error}');
      }
    } catch (e) {
      _skillsError = 'Failed to load skills: $e';
      print('❌ Skills load exception: $e');
    } finally {
      _isLoadingSkills = false;
      notifyListeners();
    }
  }

  /// Get skills by category
  List<Skill> getSkillsByCategory(String category) {
    if (_skillsByCategory != null) {
      return _skillsByCategory![category] ?? [];
    }
    return _skills?.where((skill) => skill.category == category).toList() ?? [];
  }

  // ====== PROJECTS METHODS ======

  /// Load projects data
  Future<void> loadProjects({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _projects != null &&
        _isCacheFresh(_lastProjectsFetch)) {
      return; // Use cached data
    }

    _isLoadingProjects = true;
    _projectsError = null;
    notifyListeners();

    try {
      // Load all projects
      final projectsResponse = await SafeApiService.getProjects();
      if (projectsResponse.isSuccess) {
        _projects = projectsResponse.data;
        _lastProjectsFetch = DateTime.now();
        _projectsError = null;

        // Also load featured projects
        try {
          _featuredProjects = await ApiService.getFeaturedProjects();
        } catch (e) {
          if (kDebugMode) {
            print('Failed to load featured projects: $e');
          }
        }
      } else {
        _projectsError = projectsResponse.error;
      }
    } catch (e) {
      _projectsError = 'Failed to load projects: $e';
    } finally {
      _isLoadingProjects = false;
      notifyListeners();
    }
  }

  /// Get projects by type
  List<Project> getProjectsByType(String projectType) {
    return _projects
            ?.where((project) => project.projectType == projectType)
            .toList() ??
        [];
  }

  /// Get projects by status
  List<Project> getProjectsByStatus(String status) {
    return _projects?.where((project) => project.status == status).toList() ??
        [];
  }

  // ====== EXPERIENCE METHODS ======

  /// Load experience data
  Future<void> loadExperience({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _experience != null &&
        _isCacheFresh(_lastExperienceFetch)) {
      return; // Use cached data
    }

    _isLoadingExperience = true;
    _experienceError = null;
    notifyListeners();

    try {
      final response = await SafeApiService.getExperience();
      if (response.isSuccess) {
        _experience = response.data;
        _lastExperienceFetch = DateTime.now();
        _experienceError = null;
      } else {
        _experienceError = response.error;
      }
    } catch (e) {
      _experienceError = 'Failed to load experience: $e';
    } finally {
      _isLoadingExperience = false;
      notifyListeners();
    }
  }

  // ====== TESTIMONIALS METHODS ======

  /// Load testimonials data
  Future<void> loadTestimonials({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _testimonials != null &&
        _isCacheFresh(_lastTestimonialsFetch)) {
      return; // Use cached data
    }

    _isLoadingTestimonials = true;
    _testimonialsError = null;
    notifyListeners();

    try {
      // Load all testimonials
      final testimonialsResponse = await SafeApiService.getTestimonials();
      if (testimonialsResponse.isSuccess) {
        _testimonials = testimonialsResponse.data;
        _lastTestimonialsFetch = DateTime.now();
        _testimonialsError = null;

        // Also load featured testimonials
        try {
          _featuredTestimonials = await ApiService.getFeaturedTestimonials();
        } catch (e) {
          if (kDebugMode) {
            print('Failed to load featured testimonials: $e');
          }
        }
      } else {
        _testimonialsError = testimonialsResponse.error;
      }
    } catch (e) {
      _testimonialsError = 'Failed to load testimonials: $e';
    } finally {
      _isLoadingTestimonials = false;
      notifyListeners();
    }
  }

  // ====== DASHBOARD METHODS ======

  /// Load dashboard data
  Future<void> loadDashboard({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _dashboard != null &&
        _isCacheFresh(_lastDashboardFetch)) {
      return; // Use cached data
    }

    _isLoadingDashboard = true;
    _dashboardError = null;
    notifyListeners();

    try {
      final response = await SafeApiService.getDashboard();
      if (response.isSuccess) {
        _dashboard = response.data;
        _lastDashboardFetch = DateTime.now();
        _dashboardError = null;
      } else {
        _dashboardError = response.error;
      }
    } catch (e) {
      _dashboardError = 'Failed to load dashboard: $e';
    } finally {
      _isLoadingDashboard = false;
      notifyListeners();
    }
  }

  // ====== UTILITY METHODS ======

  /// Load all essential data
  Future<void> loadAllData({bool forceRefresh = false}) async {
    await Future.wait([
      loadProfile(forceRefresh: forceRefresh),
      loadSkills(forceRefresh: forceRefresh),
      loadProjects(forceRefresh: forceRefresh),
      loadExperience(forceRefresh: forceRefresh),
      loadTestimonials(forceRefresh: forceRefresh),
      loadDashboard(forceRefresh: forceRefresh),
    ]);
  }

  /// Refresh all data
  Future<void> refreshAllData() async {
    await loadAllData(forceRefresh: true);
  }

  /// Check if any data is loading
  bool get isLoadingAny =>
      _isLoadingProfile ||
      _isLoadingSkills ||
      _isLoadingProjects ||
      _isLoadingExperience ||
      _isLoadingTestimonials ||
      _isLoadingDashboard;

  /// Check if there are any errors
  bool get hasAnyError =>
      _profileError != null ||
      _skillsError != null ||
      _projectsError != null ||
      _experienceError != null ||
      _testimonialsError != null ||
      _dashboardError != null;

  /// Get all errors as a list
  List<String> get allErrors {
    List<String> errors = [];
    if (_profileError != null) errors.add('Profile: $_profileError');
    if (_skillsError != null) errors.add('Skills: $_skillsError');
    if (_projectsError != null) errors.add('Projects: $_projectsError');
    if (_experienceError != null) errors.add('Experience: $_experienceError');
    if (_testimonialsError != null)
      errors.add('Testimonials: $_testimonialsError');
    if (_dashboardError != null) errors.add('Dashboard: $_dashboardError');
    return errors;
  }

  /// Clear all cached data
  void clearCache() {
    _profile = null;
    _skills = null;
    _skillsByCategory = null;
    _projects = null;
    _featuredProjects = null;
    _experience = null;
    _testimonials = null;
    _featuredTestimonials = null;
    _dashboard = null;

    _lastProfileFetch = null;
    _lastSkillsFetch = null;
    _lastProjectsFetch = null;
    _lastExperienceFetch = null;
    _lastTestimonialsFetch = null;
    _lastDashboardFetch = null;

    notifyListeners();
  }

  /// Clear all errors
  void clearErrors() {
    _profileError = null;
    _skillsError = null;
    _projectsError = null;
    _experienceError = null;
    _testimonialsError = null;
    _dashboardError = null;
    notifyListeners();
  }
}
