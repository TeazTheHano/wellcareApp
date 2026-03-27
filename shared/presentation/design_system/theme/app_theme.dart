import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/border.dart';
import '../foundation/spacing.dart';

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

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,

      colorScheme: AppColorScheme.light,

      scaffoldBackgroundColor: AppColors.surface,

      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),

      // elevatedButtonTheme: AppButtonTheme.elevated,
      // inputDecorationTheme: AppInputTheme.input,

      // cardTheme: CardTheme(
      //   color: AppColors.surface,
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      // ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.opacityWhite5,

        contentPadding: const EdgeInsets.all(AppSpacing.xs) ,

        hintStyle: TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: AppBorder.borderRadiusSm,
          borderSide: AppBorder.borderXsDefault,
        ),
      ),

      dividerTheme: DividerThemeData(color: AppColors.neutral800, thickness: 1),

      iconTheme: IconThemeData(color: AppColors.textPrimary),
    );
  }
}
