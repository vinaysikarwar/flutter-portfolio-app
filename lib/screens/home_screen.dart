import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/theme_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/data_state_widgets.dart';
import '../widgets/expandable_text.dart';
import '../services/portfolio_data_provider.dart';
import '../models/profile.dart';
import '../models/skill.dart';
import '../models/portfolio_dashboard.dart';

class HomeScreen extends StatefulWidget {
  final ThemeController? themeController;

  const HomeScreen({super.key, this.themeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider = Provider.of<PortfolioDataProvider>(
        context,
        listen: false,
      );
      dataProvider.loadProfile();
      dataProvider.loadSkills();
      dataProvider.loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveBreakpoints.of(context).between(MOBILE, DESKTOP);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Text(
            'Portfolio',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        actions: [
          if (widget.themeController != null)
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    size: 20,
                  ),
                  onPressed: widget.themeController!.toggleTheme,
                ),
              ),
            ),
        ],
      ),
      body: Consumer<PortfolioDataProvider>(
        builder: (context, dataProvider, child) {
          // Debug prints to see what data we have
          print('🔍 Home Screen - Profile: ${dataProvider.profile?.name}');
          print('🔍 Home Screen - Skills: ${dataProvider.skills?.length}');
          print(
            '🔍 Home Screen - Loading: Profile=${dataProvider.isLoadingProfile}, Skills=${dataProvider.isLoadingSkills}',
          );
          print(
            '🔍 Home Screen - Errors: Profile=${dataProvider.profileError}, Skills=${dataProvider.skillsError}',
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(context, isMobile, isTablet, dataProvider),
                _buildAboutSection(context, isMobile, dataProvider),
                _buildSkillsSection(context, isMobile, dataProvider),
                _buildStatsSection(context, isMobile, dataProvider),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    PortfolioDataProvider dataProvider,
  ) {
    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 600 : 700),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  AppTheme.primaryDark.withOpacity(0.9),
                  AppTheme.primaryColor.withOpacity(0.7),
                  Theme.of(context).colorScheme.background,
                ]
              : [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.primaryLight.withOpacity(0.05),
                  Theme.of(context).colorScheme.background,
                ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 48,
            vertical: 40,
          ),
          child: ResponsiveRowColumn(
            layout: isMobile
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: isMobile ? 0 : 1,
                child: _buildHeroContent(
                  context,
                  isMobile,
                  isTablet,
                  dataProvider,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: isMobile ? 0 : 1,
                child: _buildHeroImage(context, isMobile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroContent(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    PortfolioDataProvider dataProvider,
  ) {
    return DataStateWidget<Profile>(
      isLoading: dataProvider.isLoadingProfile,
      error: dataProvider.profileError,
      data: dataProvider.profile,
      builder: (profile) => Container(
        padding: EdgeInsets.only(
          right: isMobile ? 0 : 40,
          top: isMobile ? 0 : 60,
        ),
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Welcome to my portfolio',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: RichText(
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                text: TextSpan(
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile
                        ? 32
                        : isTablet
                        ? 40
                        : 48,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                  children: [
                    const TextSpan(text: 'Hi, I\'m '),
                    TextSpan(
                      text: profile.firstName,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: isMobile
                            ? 34
                            : isTablet
                            ? 42
                            : 50,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: profile.lastName,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 400),
              child: SizedBox(
                height: isMobile ? 60 : 70,
                child: AnimatedTextKit(
                  animatedTexts: profile.animatedTitles
                      .map(
                        (title) => TypewriterAnimatedText(
                          title,
                          textStyle: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppTheme.secondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: isMobile ? 20 : 24,
                              ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      )
                      .toList(),
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 600),
              child: ExpandableText(
                profile.bio,
                maxLines: isMobile ? 5 : 6,
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  height: 1.6,
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 800),
              child: Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: profile.resumeUrl != null
                        ? () {
                            // TODO: Download CV functionality
                          }
                        : null,
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Download CV'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to contact page
                    },
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: const Text('Contact Me'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      loadingWidget: Container(
        padding: EdgeInsets.only(
          right: isMobile ? 0 : 40,
          top: isMobile ? 0 : 60,
        ),
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Skeleton loading widgets
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: isMobile ? 64 : 96,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: isMobile ? 60 : 70,
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, bool isMobile) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 40 : 60),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background gradient circle
            Container(
              width: isMobile ? 280 : 320,
              height: isMobile ? 280 : 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.3),
                    AppTheme.primaryColor.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Profile avatar with enhanced styling
            Container(
              width: isMobile ? 240 : 280,
              height: isMobile ? 240 : 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ProfileAvatar(size: isMobile ? 240 : 280),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(
    BuildContext context,
    bool isMobile,
    PortfolioDataProvider dataProvider,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(
    BuildContext context,
    bool isMobile,
    PortfolioDataProvider dataProvider,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Core Technologies',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          DataStateWidget<List<Skill>>(
            isLoading: dataProvider.isLoadingSkills,
            error: dataProvider.skillsError,
            data: dataProvider.skills,
            isEmpty: dataProvider.skills?.isEmpty ?? true,
            builder: (skills) => FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: skills.take(8).map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.code,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          skill.name,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            loadingWidget: FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(
                  6,
                  (index) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    bool isMobile,
    PortfolioDataProvider dataProvider,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Professional Impact',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 50),
          DataStateWidget<PortfolioDashboard>(
            isLoading: dataProvider.isLoadingDashboard,
            error: dataProvider.dashboardError,
            data: dataProvider.dashboard,
            builder: (dashboard) => FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: ResponsiveRowColumn(
                layout: isMobile
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  _buildStatItem(
                    context,
                    isMobile,
                    '${dashboard.yearsExperience}+',
                    'Years Experience',
                  ),
                  _buildStatItem(
                    context,
                    isMobile,
                    '${dashboard.totalProjects}+',
                    'Projects Completed',
                  ),
                  _buildStatItem(
                    context,
                    isMobile,
                    '${dashboard.totalSkills}+',
                    'Technologies',
                  ),
                  _buildStatItem(
                    context,
                    isMobile,
                    '${dashboard.totalExperience}+',
                    'Companies Worked',
                  ),
                ],
              ),
            ),
            loadingWidget: FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 200),
              child: ResponsiveRowColumn(
                layout: isMobile
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: List.generate(
                  4,
                  (index) => ResponsiveRowColumnItem(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: isMobile ? 12 : 0,
                        horizontal: isMobile ? 0 : 12,
                      ),
                      padding: const EdgeInsets.all(32),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ResponsiveRowColumnItem _buildStatItem(
    BuildContext context,
    bool isMobile,
    String number,
    String label,
  ) {
    return ResponsiveRowColumnItem(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: isMobile ? 12 : 0,
          horizontal: isMobile ? 0 : 12,
        ),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
