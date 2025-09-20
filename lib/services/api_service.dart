import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile.dart';
import '../models/skill.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/testimonial.dart';
import '../models/portfolio_dashboard.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // HTTP client with timeout
  static const Duration _timeout = Duration(seconds: 30);

  // Headers for API requests
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Generic GET request handler
  static Future<http.Response> _get(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(uri, headers: _headers).timeout(_timeout);
      return response;
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Generic POST request handler
  static Future<http.Response> _post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(data))
          .timeout(_timeout);
      return response;
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Response handler with error checking
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw ApiException(
        'API Error: ${response.statusCode} - ${response.reasonPhrase}',
        statusCode: response.statusCode,
      );
    }
  }

  // ====== PROFILE ENDPOINTS ======

  /// Get the main profile (should be only one)
  static Future<Profile> getProfile() async {
    final response = await _get('/profiles/');
    final data = _handleResponse(response);

    if (data['results'] != null && data['results'].isNotEmpty) {
      return Profile.fromJson(data['results'][0]);
    } else {
      throw ApiException('No profile found');
    }
  }

  // ====== SKILLS ENDPOINTS ======

  /// Get all skills, optionally filtered by category
  static Future<List<Skill>> getSkills({String? category}) async {
    String endpoint = '/skills/';
    if (category != null) {
      endpoint += '?category=$category';
    }

    final response = await _get(endpoint);
    final data = _handleResponse(response);

    return (data['results'] as List)
        .map((skill) => Skill.fromJson(skill))
        .toList();
  }

  /// Get skills grouped by category
  static Future<Map<String, List<Skill>>> getSkillsByCategory() async {
    final response = await _get('/skills/by_category/');
    final data = _handleResponse(response);

    Map<String, List<Skill>> skillsByCategory = {};
    data.forEach((category, skills) {
      skillsByCategory[category] = (skills as List)
          .map((skill) => Skill.fromJson(skill))
          .toList();
    });

    return skillsByCategory;
  }

  // ====== PROJECTS ENDPOINTS ======

  /// Get all projects, optionally filtered
  static Future<List<Project>> getProjects({
    String? category,
    bool? featured,
    String? status,
  }) async {
    String endpoint = '/projects/';
    List<String> params = [];

    if (category != null) params.add('category=$category');
    if (featured != null) params.add('featured=$featured');
    if (status != null) params.add('status=$status');

    if (params.isNotEmpty) {
      endpoint += '?${params.join('&')}';
    }

    final response = await _get(endpoint);
    final data = _handleResponse(response);

    return (data['results'] as List)
        .map((project) => Project.fromJson(project))
        .toList();
  }

  /// Get featured projects
  static Future<List<Project>> getFeaturedProjects() async {
    return getProjects(featured: true);
  }

  /// Get project by ID
  static Future<Project> getProject(int id) async {
    final response = await _get('/projects/$id/');
    final data = _handleResponse(response);
    return Project.fromJson(data);
  }

  // ====== EXPERIENCE ENDPOINTS ======

  /// Get all work experience
  static Future<List<Experience>> getExperience() async {
    final response = await _get('/experience/');
    final data = _handleResponse(response);

    return (data['results'] as List)
        .map((exp) => Experience.fromJson(exp))
        .toList();
  }

  // ====== TESTIMONIALS ENDPOINTS ======

  /// Get all testimonials, optionally featured only
  static Future<List<Testimonial>> getTestimonials({bool? featured}) async {
    String endpoint = '/testimonials/';
    if (featured != null) {
      endpoint += '?featured=$featured';
    }

    final response = await _get(endpoint);
    final data = _handleResponse(response);

    return (data['results'] as List)
        .map((testimonial) => Testimonial.fromJson(testimonial))
        .toList();
  }

  /// Get featured testimonials
  static Future<List<Testimonial>> getFeaturedTestimonials() async {
    return getTestimonials(featured: true);
  }

  // ====== DASHBOARD ENDPOINTS ======

  /// Get dashboard overview data
  static Future<PortfolioDashboard> getDashboard() async {
    final response = await _get('/dashboard/');
    final data = _handleResponse(response);
    return PortfolioDashboard.fromJson(data);
  }

  // ====== CONTACT ENDPOINTS ======

  /// Submit contact form
  static Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
    String? phone,
    String? company,
  }) async {
    final data = {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      if (phone != null) 'phone': phone,
      if (company != null) 'company': company,
    };

    final response = await _post('/contact/', data);
    _handleResponse(response); // Will throw if error
  }

  // ====== UTILITY METHODS ======

  /// Check if API is reachable
  static Future<bool> checkConnection() async {
    try {
      final response = await _get('/dashboard/');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Get full media URL
  static String getMediaUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return 'http://127.0.0.1:8000$path';
  }
}

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message';
}

/// API response wrapper for better error handling
class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const ApiResponse._({this.data, this.error, required this.isSuccess});

  factory ApiResponse.success(T data) {
    return ApiResponse._(data: data, isSuccess: true);
  }

  factory ApiResponse.error(String error) {
    return ApiResponse._(error: error, isSuccess: false);
  }
}

/// Safe API call wrapper that returns ApiResponse
class SafeApiService {
  /// Safely execute an API call and return wrapped response
  static Future<ApiResponse<T>> safeCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return ApiResponse.success(result);
    } on ApiException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error('Unknown error occurred: $e');
    }
  }

  /// Get profile with error handling
  static Future<ApiResponse<Profile>> getProfile() async {
    return safeCall(() => ApiService.getProfile());
  }

  /// Get skills with error handling
  static Future<ApiResponse<List<Skill>>> getSkills({String? category}) async {
    return safeCall(() => ApiService.getSkills(category: category));
  }

  /// Get projects with error handling
  static Future<ApiResponse<List<Project>>> getProjects({
    String? category,
    bool? featured,
    String? status,
  }) async {
    return safeCall(
      () => ApiService.getProjects(
        category: category,
        featured: featured,
        status: status,
      ),
    );
  }

  /// Get experience with error handling
  static Future<ApiResponse<List<Experience>>> getExperience() async {
    return safeCall(() => ApiService.getExperience());
  }

  /// Get testimonials with error handling
  static Future<ApiResponse<List<Testimonial>>> getTestimonials({
    bool? featured,
  }) async {
    return safeCall(() => ApiService.getTestimonials(featured: featured));
  }

  /// Get dashboard with error handling
  static Future<ApiResponse<PortfolioDashboard>> getDashboard() async {
    return safeCall(() => ApiService.getDashboard());
  }
}
