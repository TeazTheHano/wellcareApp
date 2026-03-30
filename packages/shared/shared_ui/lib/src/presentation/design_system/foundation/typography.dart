import 'package:flutter/material.dart';

class AppTypography {
  static const fontFamilyHeader = 'Playfair Display';
  static const fontFamilyBody = 'Inter';

  static TextStyle _baseStyle(
    double size,
    FontWeight weight,
    double height,
    String family,
  ) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      height: height,
      fontFamily: family,
      leadingDistribution:
          TextLeadingDistribution.even, // Giúp căn giữa text tốt hơn
    );
  }

  static final h1 = _baseStyle(80, FontWeight.w800, 1.1, fontFamilyHeader);
  static final h2 = _baseStyle(64, FontWeight.w700, 1.2, fontFamilyHeader);
  static final h3 = _baseStyle(56, FontWeight.w700, 1.2, fontFamilyHeader);
  static final h4 = _baseStyle(40, FontWeight.w600, 1.4, fontFamilyHeader);
  static final h5 = _baseStyle(24, FontWeight.w600, 1.5, fontFamilyHeader);
  static final h6 = _baseStyle(20, FontWeight.w500, 1.5, fontFamilyHeader);
  static final xLargeBody = _baseStyle(
    24,
    FontWeight.w400,
    1.5,
    fontFamilyBody,
  );
  static final largeBody = _baseStyle(20, FontWeight.w400, 1.5, fontFamilyBody);
  static final body = _baseStyle(16, FontWeight.w400, 1.5, fontFamilyBody);
  static final smallBody = _baseStyle(14, FontWeight.w400, 1.5, fontFamilyBody);
  static final caption = _baseStyle(13, FontWeight.w400, 1.5, fontFamilyBody);
  static final smallCaption = _baseStyle(
    12,
    FontWeight.w400,
    1.5,
    fontFamilyBody,
  );

  static final textTheme = TextTheme(
    displayLarge: h1,
    displayMedium: h2,
    displaySmall: h3,

    headlineLarge: h4,
    headlineMedium: h5,
    headlineSmall: h6,

    titleLarge: xLargeBody,
    titleMedium: largeBody,

    bodyMedium: body,
    bodySmall: smallBody,

    labelMedium: caption,
    labelSmall: smallCaption,
  );
}
