class AppConstants {
  // Personal Information
  static const String name = 'Vinay Sikarwar';
  static const String title = 'Technical Architect';
  static const String email = 'svinay.1987@gmail.com';
  static const String phone = '+91 78358 10043';
  static const String location = 'Gurugram, India';

  // Bio
  static const String bio =
      'Technical Architect with 14.6 years of experience in web development and 5 years in architectural roles. '
      'Expertise in Magento, PHP, Python (Django, Flask), and cloud infrastructure (AWS, Azure). '
      'Proven skills in Microservices, EAV architecture, API development, high-traffic systems, and DevOps practices.';

  // Social Media Links
  static const String linkedinUrl = 'https://linkedin.com/in/vinaysikarwar';
  static const String githubUrl = 'https://github.com/vinaysikarwar';
  static const String twitterUrl = 'https://twitter.com/vinaysikarwar';
  static const String instagramUrl = 'https://instagram.com/vinaysikarwar';

  // Professional Titles for Animation
  static const List<String> animatedTitles = [
    'Technical Architect',
    'PHP Developer',
    'Python Developer',
    'Magento Expert',
    'Cloud Solutions Architect',
  ];

  // Skills
  static const List<Map<String, dynamic>> skills = [
    {'name': 'PHP', 'level': 95},
    {'name': 'Python', 'level': 90},
    {'name': 'Magento', 'level': 95},
    {'name': 'JavaScript', 'level': 85},
    {'name': 'AWS', 'level': 80},
    {'name': 'Docker', 'level': 85},
  ];

  // Experience
  static const List<Map<String, dynamic>> experience = [
    {
      'position': 'Technical Architect1',
      'company': 'Group Bayport',
      'duration': 'Dec 2022 – Present',
      'responsibilities': [
        'Architected scalable, fault-tolerant solutions',
        'Led cross-functional teams and technical mentorship',
        'Implemented observability and automated deployments',
        'Designed microservices architecture for high-traffic systems',
      ],
    },
    {
      'position': 'Magento Consultant',
      'company': 'AppInlet Inc.',
      'duration': 'June 2018 – Nov 2022',
      'responsibilities': [
        'Magento integrations and performance tuning',
        'API development for high-traffic e-commerce platforms',
        'Led development teams for complex e-commerce solutions',
        'Implemented caching strategies and search optimizations',
      ],
    },
    {
      'position': 'Senior Software Engineer',
      'company': 'OSSCube Ltd.',
      'duration': 'Feb 2014 – Apr 2016',
      'responsibilities': [
        'Built enterprise modules and search integrations',
        'Developed custom Magento extensions',
        'Optimized database queries and application performance',
        'Mentored junior developers',
      ],
    },
  ];

  // Education
  static const Map<String, String> education = {
    'degree': 'Bachelor of Technology',
    'university': 'University Name',
    'duration': '2006 - 2010',
    'gpa': '3.8/4.0',
  };

  // Projects
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Coversandall API Development',
      'description':
          'Custom API development with real-time reporting, SonarQube improvements, and scalable architecture for high-performance e-commerce platform.',
      'technologies': ['PHP', 'MySQL', 'Redis', 'Docker'],
      'duration': '2022 - Present',
      'category': 'API Development',
    },
    {
      'title': 'Bannerbuzz API Solutions',
      'description':
          'Designed secure and high-performance API solutions for custom printing and banner solutions platform.',
      'technologies': ['Python', 'Django', 'PostgreSQL', 'AWS'],
      'duration': '2022 - Present',
      'category': 'API Development',
    },
    {
      'title': 'Tru Diamonds E-commerce',
      'description':
          'Magento-based jewelry store with real-time inventory management and automated order processing.',
      'technologies': ['Magento', 'PHP', 'MySQL', 'Elasticsearch'],
      'duration': '2019 - 2020',
      'category': 'E-commerce',
    },
    {
      'title': 'Acer E-commerce Store',
      'description':
          'Enterprise e-commerce solution with ERP integration, attribute import scripts, and advanced caching strategies.',
      'technologies': ['Magento', 'PHP', 'Redis', 'Solr'],
      'duration': '2018 - 2022',
      'category': 'E-commerce',
    },
  ];

  // Achievements
  static const List<Map<String, dynamic>> achievements = [
    {
      'title': 'Magento Certified Developer',
      'description': 'Official Magento certification',
      'icon': 'verified',
    },
    {
      'title': 'AWS Solutions Architect',
      'description': 'In Progress - Cloud infrastructure expertise',
      'icon': 'cloud',
    },
    {
      'title': 'Open Source Contributor',
      'description': 'Contributor to Magento Open Source Community',
      'icon': 'code',
    },
  ];
}
