import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/typography.dart';

import '../components/input/input_theme.dart';
import '../components/app_theme_ext.dart';

class AppColorScheme {
  static final light =
      ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.primary,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: Colors.white,

        secondary: AppColors.secondary,
        onSecondary: Colors.white,

        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,

        surfaceContainer: AppColors.surfaceTeriary,

        error: AppColors.error,
        onError: AppColors.errorWeak,
      );
}

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,

    colorScheme: AppColorScheme.light,

    scaffoldBackgroundColor: AppColors.surface,

    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),

    appBarTheme: const AppBarTheme(elevation: 0),

    inputDecorationTheme: AppInputTheme.light,

    // dividerTheme: AppDividerTheme.light,

    // iconTheme: AppIconTheme.light,
  );
}
