import 'package:flutter/material.dart';

import '../../foundation/colors.dart';
import '../../foundation/border.dart';
import '../../foundation/spacing.dart';

class AppInputTheme {
  static final light = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.opacityWhite5,

    contentPadding: const EdgeInsets.all(AppSpacing.xs),

    hintStyle: TextStyle(color: AppColors.textSecondary),

    border: OutlineInputBorder(
      borderRadius: AppBorder.borderRadiusSm,
      borderSide: AppBorder.borderXsDefault,
    ),
  );
}