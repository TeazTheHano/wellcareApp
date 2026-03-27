import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

/// Radius scale (Design Token)
///
/// EN:
/// Defines the border radius system for the entire application.
/// This is a foundational token and should NOT contain UI logic.
///
/// VI:
/// Định nghĩa hệ thống bo góc cho toàn bộ ứng dụng.
/// Đây là design token, KHÔNG chứa logic UI.
class AppBorder {
  const AppBorder._();

  // 🔹 Base scale (theo design system)

  /// No radius (sharp corners)
  static const radiusNone = Radius.circular(0);

  /// Extra small radius (e.g. subtle UI elements)
  static const radiusXs = Radius.circular(AppTokens.unit);

  /// Small radius (inputs, small buttons)
  static const radiusSm = Radius.circular(AppTokens.unit * 2);

  /// Medium radius (default for most components)
  static const radiusMd = Radius.circular(AppTokens.unit * 3);

  /// Large radius (cards, containers)
  static const radiusLg = Radius.circular(AppTokens.unit * 4);

  /// Extra large radius (modals, sheets)
  static const radiusXl = Radius.circular(AppTokens.unit * 6);

  /// Fully rounded (circle / pill)
  static const radiusFull = Radius.circular(9999);

  // 🔹 BorderRadius shortcuts for all corner

  static final borderRadiusNone = BorderRadius.all(radiusNone);
  static final borderRadiusXs = BorderRadius.all(radiusXs);
  static final borderRadiusSm = BorderRadius.all(radiusSm);
  static final borderRadiusMd = BorderRadius.all(radiusMd);
  static final borderRadiusLg = BorderRadius.all(radiusLg);
  static final borderRadiusXl = BorderRadius.all(radiusXl);
  static final borderRadiusFull = BorderRadius.all(radiusFull);

  // 🔹 Border
  static final borderNone = BorderSide(color: AppColors.primary, width: 0);
  
  static final borderXsDefault = BorderSide(color: AppColors.opacityWhite10, width: 1);
  static final borderSmDefault = BorderSide(color: AppColors.opacityWhite10, width: 2);
  static final borderMdDefault = BorderSide(color: AppColors.opacityWhite10, width: 3);
  static final borderLgDefault = BorderSide(color: AppColors.opacityWhite10, width: 4);
  static final borderXlDefault = BorderSide(color: AppColors.opacityWhite10, width: 5);

  static final borderXsTextPrimary = BorderSide(color: AppColors.textPrimary, width: 1);
  static final borderSmTextPrimary = BorderSide(color: AppColors.textPrimary, width: 2);
  static final borderMdTextPrimary = BorderSide(color: AppColors.textPrimary, width: 3);
  static final borderLgTextPrimary = BorderSide(color: AppColors.textPrimary, width: 4);
  static final borderXlTextPrimary = BorderSide(color: AppColors.textPrimary, width: 5);

  static final borderXsTextSecondary = BorderSide(color: AppColors.textSecondary, width: 1);
  static final borderSmTextSecondary = BorderSide(color: AppColors.textSecondary, width: 2);
  static final borderMdTextSecondary = BorderSide(color: AppColors.textSecondary, width: 3);
  static final borderLgTextSecondary = BorderSide(color: AppColors.textSecondary, width: 4);
  static final borderXlTextSecondary = BorderSide(color: AppColors.textSecondary, width: 5);
}
