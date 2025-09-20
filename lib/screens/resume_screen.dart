import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/app_constants.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement PDF download
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExperienceSection(context),
            const SizedBox(height: 32),
            _buildEducationSection(context),
            const SizedBox(height: 32),
            _buildSkillsSection(context),
            const SizedBox(height: 32),
            _buildAchievementsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional Experience',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ...AppConstants.experience.map(
            (exp) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildExperienceItem(
                context,
                exp['position'] as String,
                exp['company'] as String,
                exp['duration'] as String,
                List<String>.from(exp['responsibilities'] as List),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context,
    String position,
    String company,
    String duration,
    List<String> responsibilities,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        position,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        company,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    duration,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...responsibilities.map(
              (responsibility) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Education',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.education['degree']!,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppConstants.education['university']!,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          '${AppConstants.education['duration']!} | GPA: ${AppConstants.education['gpa']!}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Skills',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildSkillCategory(context, 'Programming Languages', [
            'PHP (5.5+ to 8.2+)',
            'Python (Django, Flask)',
            'JavaScript, HTML, CSS, jQuery',
            'Dart',
          ]),
          const SizedBox(height: 16),
          _buildSkillCategory(context, 'Frameworks & Platforms', [
            'Magento / E-commerce',
            'Flutter',
            'Django',
            'Flask',
          ]),
          const SizedBox(height: 16),
          _buildSkillCategory(context, 'Databases & Storage', [
            'MySQL',
            'MongoDB',
            'Redis',
            'Elasticsearch / Solr / OpenSearch',
          ]),
          const SizedBox(height: 16),
          _buildSkillCategory(context, 'Cloud & DevOps', [
            'AWS (CloudFront, S3, EC2)',
            'Azure',
            'Docker, Kubernetes',
            'Jenkins',
            'CI/CD, Observability',
          ]),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String category,
    List<String> skills,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        skill,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements & Certifications',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ...AppConstants.achievements.map(
            (achievement) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildAchievementItem(
                context,
                achievement['title'] as String,
                achievement['description'] as String,
                _getIconFromString(achievement['icon'] as String),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'emoji_events':
        return Icons.emoji_events;
      case 'verified':
        return Icons.verified;
      case 'code':
        return Icons.code;
      case 'star':
        return Icons.star;
      case 'workspace_premium':
        return Icons.workspace_premium;
      case 'psychology':
        return Icons.psychology;
      case 'speed':
        return Icons.speed;
      default:
        return Icons.star;
    }
  }
}
