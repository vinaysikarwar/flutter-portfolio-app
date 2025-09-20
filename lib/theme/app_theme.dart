import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Mobile/Tablet color palette (Original)
  static const Color primaryColor = Color(0xFF1A237E); // Deep Indigo
  static const Color primaryLight = Color(0xFF3F51B5); // Indigo
  static const Color primaryDark = Color(0xFF0D1B69); // Darker Indigo
  static const Color secondaryColor = Color(0xFF00BCD4); // Cyan
  static const Color accentColor = Color(0xFFFF6B35); // Professional Orange
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);

  // Desktop Web color palette (Different theme)
  static const Color desktopPrimaryColor = Color(0xFF0F172A); // Slate 900
  static const Color desktopPrimaryLight = Color(0xFF1E293B); // Slate 800
  static const Color desktopPrimaryDark = Color(0xFF020617); // Slate 950
  static const Color desktopSecondaryColor = Color(0xFF3B82F6); // Blue 500
  static const Color desktopAccentColor = Color(0xFF10B981); // Emerald 500
  static const Color desktopSuccessColor = Color(0xFF059669); // Emerald 600
  static const Color desktopWarningColor = Color(0xFFF59E0B); // Amber 500
  static const Color desktopErrorColor = Color(0xFFEF4444); // Red 500

  // Platform detection
  static bool get isDesktopWeb =>
      kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  // Dynamic color getters based on platform
  static Color get activePrimaryColor =>
      isDesktopWeb ? desktopPrimaryColor : primaryColor;
  static Color get activePrimaryLight =>
      isDesktopWeb ? desktopPrimaryLight : primaryLight;
  static Color get activePrimaryDark =>
      isDesktopWeb ? desktopPrimaryDark : primaryDark;
  static Color get activeSecondaryColor =>
      isDesktopWeb ? desktopSecondaryColor : secondaryColor;
  static Color get activeAccentColor =>
      isDesktopWeb ? desktopAccentColor : accentColor;
  static Color get activeSuccessColor =>
      isDesktopWeb ? desktopSuccessColor : successColor;
  static Color get activeWarningColor =>
      isDesktopWeb ? desktopWarningColor : warningColor;
  static Color get activeErrorColor =>
      isDesktopWeb ? desktopErrorColor : errorColor;

  // Light theme colors - Mobile/Tablet
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Light theme colors - Desktop Web
  static const Color desktopLightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color desktopLightSurface = Color(0xFFFFFFFF);
  static const Color desktopLightCardBackground = Color(
    0xFFF1F5F9,
  ); // Slate 100
  static const Color desktopLightBorder = Color(0xFFCBD5E1); // Slate 300

  // Dynamic background colors
  static Color get activeLightBackground =>
      isDesktopWeb ? desktopLightBackground : lightBackground;
  static Color get activeLightSurface =>
      isDesktopWeb ? desktopLightSurface : lightSurface;
  static Color get activeLightCardBackground =>
      isDesktopWeb ? desktopLightCardBackground : lightCardBackground;
  static Color get activeLightBorder =>
      isDesktopWeb ? desktopLightBorder : lightBorder;

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkCardBackground = Color(0xFF2C2C2E);
  static const Color darkBorder = Color(0xFF3C3C3E);

  // Gradient colors - Dynamic based on platform
  static LinearGradient get primaryGradient => LinearGradient(
    colors: [activePrimaryColor, activePrimaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get heroGradient => isDesktopWeb
      ? const LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
          ], // Slate gradient for desktop
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : const LinearGradient(
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ], // Original gradient for mobile/tablet
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: activePrimaryColor,
    scaffoldBackgroundColor: activeLightBackground,
    colorScheme: ColorScheme.light(
      primary: activePrimaryColor,
      secondary: activeSecondaryColor,
      tertiary: activeAccentColor,
      surface: activeLightSurface,
      background: activeLightBackground,
      error: activeErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFF1A1A1A),
      onBackground: const Color(0xFF1A1A1A),
      onError: Colors.white,
      outline: activeLightBorder,
    ),
    textTheme: _getTextTheme(),
    appBarTheme: _getAppBarTheme(true),
    cardTheme: _getCardTheme(true),
    elevatedButtonTheme: _getElevatedButtonTheme(),
    outlinedButtonTheme: _getOutlinedButtonTheme(),
    inputDecorationTheme: _getInputDecorationTheme(true),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: activePrimaryColor,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: activePrimaryColor,
      secondary: activeSecondaryColor,
      tertiary: activeAccentColor,
      surface: darkSurface,
      background: darkBackground,
      error: activeErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFFE4E4E7),
      onBackground: const Color(0xFFE4E4E7),
      onError: Colors.white,
      outline: darkBorder,
    ),
    textTheme: _getDarkTextTheme(),
    appBarTheme: _getAppBarTheme(false),
    cardTheme: _getCardTheme(false),
    elevatedButtonTheme: _getElevatedButtonTheme(),
    outlinedButtonTheme: _getOutlinedButtonTheme(),
    inputDecorationTheme: _getInputDecorationTheme(false),
  );

  // Platform-specific text theme
  static TextTheme _getTextTheme() {
    final baseFont = isDesktopWeb
        ? GoogleFonts.poppinsTextTheme() // Different font for desktop
        : GoogleFonts.interTextTheme(); // Keep Inter for mobile/tablet

    return baseFont.copyWith(
      displayLarge: TextStyle(
        fontSize: isDesktopWeb ? 64 : 57, // Larger for desktop
        fontWeight: FontWeight.w800,
        letterSpacing: -0.25,
        color: const Color(0xFF1A1A1A),
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: isDesktopWeb ? 50 : 45,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: isDesktopWeb ? 40 : 36,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontSize: isDesktopWeb ? 36 : 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: isDesktopWeb ? 32 : 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: isDesktopWeb ? 28 : 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontSize: isDesktopWeb ? 24 : 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: const Color(0xFF1A1A1A),
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: isDesktopWeb ? 18 : 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: const Color(0xFF1A1A1A),
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: const Color(0xFF1A1A1A),
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontSize: isDesktopWeb ? 18 : 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: const Color(0xFF424242),
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: const Color(0xFF616161),
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: isDesktopWeb ? 14 : 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: const Color(0xFF757575),
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: activePrimaryColor,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: isDesktopWeb ? 14 : 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: activePrimaryColor,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: isDesktopWeb ? 12 : 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: activePrimaryColor,
        height: 1.45,
      ),
    );
  }

  // Platform-specific dark text theme
  static TextTheme _getDarkTextTheme() {
    final baseFont = isDesktopWeb
        ? GoogleFonts.poppinsTextTheme() // Different font for desktop
        : GoogleFonts.interTextTheme(); // Keep Inter for mobile/tablet

    return baseFont.copyWith(
      displayLarge: TextStyle(
        fontSize: isDesktopWeb ? 64 : 57,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.25,
        color: const Color(0xFFE4E4E7),
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: isDesktopWeb ? 50 : 45,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: isDesktopWeb ? 40 : 36,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontSize: isDesktopWeb ? 36 : 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: isDesktopWeb ? 32 : 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: isDesktopWeb ? 28 : 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontSize: isDesktopWeb ? 24 : 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: const Color(0xFFE4E4E7),
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: isDesktopWeb ? 18 : 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: const Color(0xFFE4E4E7),
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: const Color(0xFFE4E4E7),
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontSize: isDesktopWeb ? 18 : 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: const Color(0xFFA1A1AA),
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: const Color(0xFF71717A),
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: isDesktopWeb ? 14 : 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: const Color(0xFF52525B),
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontSize: isDesktopWeb ? 16 : 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: activePrimaryLight,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: isDesktopWeb ? 14 : 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: activePrimaryLight,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: isDesktopWeb ? 12 : 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: activePrimaryLight,
        height: 1.45,
      ),
    );
  }

  // Platform-specific AppBar theme
  static AppBarTheme _getAppBarTheme(bool isLight) {
    return AppBarTheme(
      backgroundColor: isLight ? activeLightSurface : darkSurface,
      elevation: 0,
      scrolledUnderElevation: 4,
      shadowColor: isLight ? activeLightBorder : darkBorder,
      titleTextStyle:
          (isDesktopWeb ? GoogleFonts.poppins() : GoogleFonts.inter()).copyWith(
            fontSize: isDesktopWeb ? 22 : 20,
            fontWeight: FontWeight.w600,
            color: isLight ? const Color(0xFF1A1A1A) : const Color(0xFFE4E4E7),
          ),
      iconTheme: IconThemeData(
        color: isLight ? const Color(0xFF1A1A1A) : const Color(0xFFE4E4E7),
        size: isDesktopWeb ? 26 : 24,
      ),
    );
  }

  // Platform-specific Card theme
  static CardThemeData _getCardTheme(bool isLight) {
    return CardThemeData(
      color: isLight ? activeLightCardBackground : darkCardBackground,
      elevation: 0,
      shadowColor: (isLight ? activeLightBorder : darkBorder).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktopWeb ? 20 : 16),
        side: BorderSide(
          color: (isLight ? activeLightBorder : darkBorder).withOpacity(0.2),
          width: 1,
        ),
      ),
      margin: EdgeInsets.all(isDesktopWeb ? 12 : 8),
    );
  }

  // Platform-specific ElevatedButton theme
  static ElevatedButtonThemeData _getElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: activePrimaryColor,
        foregroundColor: Colors.white,
        elevation: isDesktopWeb ? 4 : 2,
        shadowColor: activePrimaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktopWeb ? 16 : 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktopWeb ? 40 : 32,
          vertical: isDesktopWeb ? 20 : 16,
        ),
        textStyle: (isDesktopWeb ? GoogleFonts.poppins() : GoogleFonts.inter())
            .copyWith(
              fontSize: isDesktopWeb ? 16 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
      ),
    );
  }

  // Platform-specific OutlinedButton theme
  static OutlinedButtonThemeData _getOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: activePrimaryColor,
        side: BorderSide(
          color: activePrimaryColor,
          width: isDesktopWeb ? 2 : 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktopWeb ? 16 : 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktopWeb ? 40 : 32,
          vertical: isDesktopWeb ? 20 : 16,
        ),
        textStyle: (isDesktopWeb ? GoogleFonts.poppins() : GoogleFonts.inter())
            .copyWith(
              fontSize: isDesktopWeb ? 16 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
      ),
    );
  }

  // Platform-specific InputDecoration theme
  static InputDecorationTheme _getInputDecorationTheme(bool isLight) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isLight ? activeLightSurface : darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isDesktopWeb ? 16 : 12),
        borderSide: BorderSide(color: isLight ? activeLightBorder : darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isDesktopWeb ? 16 : 12),
        borderSide: BorderSide(color: isLight ? activeLightBorder : darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isDesktopWeb ? 16 : 12),
        borderSide: BorderSide(color: activePrimaryColor, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: isDesktopWeb ? 20 : 16,
        vertical: isDesktopWeb ? 20 : 16,
      ),
    );
  }
}
