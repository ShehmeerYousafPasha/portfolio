import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Defines the complete theme configuration for the portfolio.
///
/// Both [lightTheme] and [darkTheme] share the same structural shape,
/// differing only in color values. Typography uses Inter from Google Fonts.
///
/// Design philosophy:
/// - Professional, clean, premium
/// - Influenced by Apple product sites and modern SaaS
/// - No flashy gradients or excessive color
class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Dark Theme
  // ---------------------------------------------------------------------------
  static ThemeData get darkTheme {
    const cs = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: Color(0xFF103D35),
      onPrimaryContainer: Color(0xFFBDE6DB),
      secondary: Color(0xFF47A58F),
      onSecondary: Color(0xFF00251F),
      secondaryContainer: Color(0xFF004C40),
      onSecondaryContainer: Color(0xFF92F3DB),
      tertiary: Color(0xFF3B82F6),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF1A3A72),
      onTertiaryContainer: Color(0xFFD4E4FF),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFECACA),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorderSubtle,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: AppColors.lightSurface,
      onInverseSurface: AppColors.lightTextPrimary,
      inversePrimary: AppColors.primaryVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(
        primary: AppColors.darkTextPrimary,
        secondary: AppColors.darkTextSecondary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkTextSecondary,
        size: 20,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
        space: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkTextPrimary,
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          ),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColors.darkTextSecondary,
          fontSize: 14,
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColors.darkTextTertiary,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceElevated,
        side: const BorderSide(color: AppColors.darkBorder),
        labelStyle: GoogleFonts.inter(
          color: AppColors.darkTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.chipHorizontal,
          vertical: AppSpacing.chipVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceCard,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.darkBorder),
        ),
        textStyle: GoogleFonts.inter(
          color: AppColors.darkTextPrimary,
          fontSize: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceCard,
        contentTextStyle: GoogleFonts.inter(
          color: AppColors.darkTextPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    const cs = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: Color(0xFF00211C),
      secondary: Color(0xFF08735E),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFBDEADD),
      onSecondaryContainer: Color(0xFF00211C),
      tertiary: Color(0xFF2563EB),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFDCEBFF),
      onTertiaryContainer: Color(0xFF001A42),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF7F1D1D),
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      onSurfaceVariant: AppColors.lightTextSecondary,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorderSubtle,
      shadow: Color(0x1A000000),
      scrim: Colors.black54,
      inverseSurface: AppColors.darkSurface,
      onInverseSurface: AppColors.darkTextPrimary,
      inversePrimary: Color(0xFF47A58F),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _buildTextTheme(
        primary: AppColors.lightTextPrimary,
        secondary: AppColors.lightTextSecondary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.lightTextSecondary,
        size: 20,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
        space: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          ),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColors.lightTextSecondary,
          fontSize: 14,
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColors.lightTextTertiary,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.lightTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceElevated,
        side: const BorderSide(color: AppColors.lightBorder),
        labelStyle: GoogleFonts.inter(
          color: AppColors.lightTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.chipHorizontal,
          vertical: AppSpacing.chipVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.lightSurfaceCard,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.lightBorder),
        ),
        textStyle: GoogleFonts.inter(
          color: AppColors.lightTextPrimary,
          fontSize: 12,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightSurfaceCard,
        contentTextStyle: GoogleFonts.inter(
          color: AppColors.lightTextPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
          side: const BorderSide(color: AppColors.lightBorder),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Text Theme Builder
  // ---------------------------------------------------------------------------
  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
  }) {
    return TextTheme(
      // Display — Hero headlines, large section titles
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w300,
        color: primary,
        letterSpacing: -0.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w300,
        color: primary,
        letterSpacing: -0.25,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 38,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.15,
      ),
      // Headline — Section titles
      headlineLarge: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: -0.25,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.25,
      ),
      // Title — Card titles, nav items
      titleLarge: GoogleFonts.inter(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 0.1,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 0.1,
        height: 1.4,
      ),
      // Body — Content paragraphs
      bodyLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.65,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5,
      ),
      // Label — Buttons, chips, tags
      labelLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
        letterSpacing: 0.5,
      ),
    );
  }
}
