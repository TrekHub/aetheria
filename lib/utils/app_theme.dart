import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Modern Color Palette - Soft and Calming
  static const Color primaryBlue = Color(0xFF6B73FF);
  static const Color lightBlue = Color(0xFFE8EAFF);
  static const Color softBlue = Color(0xFFF5F6FF);
  static const Color accentPurple = Color(0xFF9C88FF);
  static const Color backgroundWhite = Color(0xFFFAFBFF);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1D29);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color dividerGray = Color(0xFFE5E7EB);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGradient = LinearGradient(
    colors: [softBlue, lightBlue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shadows
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: primaryBlue.withOpacity(0.08),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: textDark.withOpacity(0.04),
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: textDark.withOpacity(0.06),
          offset: const Offset(0, 4),
          blurRadius: 8,
          spreadRadius: -2,
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: textDark.withOpacity(0.1),
          offset: const Offset(0, 4),
          blurRadius: 16,
          spreadRadius: -4,
        ),
      ];

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXL = 24.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: accentPurple,
        surface: backgroundWhite,
        background: backgroundWhite,
        error: errorRed,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: cardWhite,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: textDark),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        shadowColor: textDark.withOpacity(0.1),
        scrolledUnderElevation: 1,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: BorderSide(color: dividerGray.withOpacity(0.3), width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
        shadowColor: textDark.withOpacity(0.05),
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textDark,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          color: textDark,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          color: textDark,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          color: textDark,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          color: textMedium,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: textLight,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          color: textDark,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          shadowColor: primaryBlue.withOpacity(0.3),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          padding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: BorderSide(color: primaryBlue.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightBlue.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        contentPadding: const EdgeInsets.all(spacingM),
        hintStyle: const TextStyle(color: textLight),
        labelStyle: const TextStyle(color: textMedium),
      ),

      // FloatingActionButton Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardWhite,
        selectedItemColor: primaryBlue,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: dividerGray,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textMedium,
        size: 24,
      ),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: primaryBlue,
        size: 24,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: backgroundWhite,
    );
  }

  // Custom Widgets Styles
  static BoxDecoration get glassMorphism => BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMedium),
        color: cardWhite.withOpacity(0.8),
        border: Border.all(color: dividerGray.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.05),
            offset: const Offset(0, 8),
            blurRadius: 32,
            spreadRadius: -4,
          ),
        ],
      );

  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(radiusMedium),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      );
}
