import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class ThemeUtils {
  ThemeUtils._();

  // static bool  get dark => (MediaQuery.of(navigatorKey.currentContext!).platformBrightness == Brightness.dark);

  static ThemeData get theme {
    return ThemeData(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      primarySwatch: AppColors.primerColor,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(color: AppColors.textColor),
        bodyMedium: GoogleFonts.inter(color: AppColors.textColor), //33
        bodySmall: GoogleFonts.inter(color: AppColors.textDisableColor),
        displayLarge: GoogleFonts.inter(color: AppColors.textColor),
        displayMedium: GoogleFonts.inter(color: AppColors.textColor),
        displaySmall: GoogleFonts.inter(color: AppColors.textColor),
        labelLarge: GoogleFonts.inter(color: AppColors.textColor),
        labelMedium: GoogleFonts.inter(color: AppColors.textColor),
        labelSmall: GoogleFonts.inter(color: AppColors.textDisableColor),
        headlineMedium: GoogleFonts.inter(color: AppColors.textColor),
        headlineLarge: GoogleFonts.inter(color: AppColors.textColor),
        headlineSmall: GoogleFonts.inter(color: AppColors.textColor),
        titleLarge: GoogleFonts.inter(color: AppColors.textColor),
        titleMedium: GoogleFonts.inter(color: AppColors.textColor),
        titleSmall: GoogleFonts.inter(color: AppColors.textColor),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()}),
    );
  }
}
