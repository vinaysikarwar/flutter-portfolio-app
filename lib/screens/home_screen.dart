import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../constants/app_constants.dart';
import '../theme/theme_controller.dart';
import '../widgets/profile_avatar.dart';

class HomeScreen extends StatelessWidget {
  final ThemeController? themeController;

  const HomeScreen({super.key, this.themeController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        actions: [
          if (themeController != null)
            IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeController!.toggleTheme();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveRowColumn(
          layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
              ? ResponsiveRowColumnType.ROW
              : ResponsiveRowColumnType.COLUMN,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _buildProfileSection(context),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _buildIntroSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: const ProfileAvatar(size: 200),
          ),
          const SizedBox(height: 24),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: Text(
              AppConstants.name,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            child: AnimatedTextKit(
              animatedTexts: AppConstants.animatedTitles
                  .map(
                    (title) => TypewriterAnimatedText(
                      title,
                      textStyle: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: Theme.of(context).primaryColor),
                      speed: const Duration(milliseconds: 100),
                    ),
                  )
                  .toList(),
              repeatForever: true,
              pause: const Duration(milliseconds: 1000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInRight(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 600),
            child: Text(
              'Hello! 👋',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const SizedBox(height: 16),
          FadeInRight(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 800),
            child: Text(
              AppConstants.bio,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 24),
          FadeInRight(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 1000),
            child: _buildSkillsSection(context),
          ),
          const SizedBox(height: 32),
          FadeInRight(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 1200),
            child: _buildQuickActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = AppConstants.skills
        .take(6)
        .map((skill) => {'icon': FontAwesomeIcons.code, 'name': skill['name']})
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Technologies',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    skill['icon'] as IconData,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    skill['name'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Navigate to contact
          },
          icon: const Icon(Icons.email),
          label: const Text('Contact Me'),
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Navigate to portfolio
          },
          icon: const Icon(Icons.work),
          label: const Text('View Portfolio'),
        ),
      ],
    );
  }
}
