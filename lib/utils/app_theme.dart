import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.blue,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.blue,
          secondary: AppColors.teal,
          surface: AppColors.canvas,
          onSurface: AppColors.ink,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.canvas,
      // Every surface in the design is hand-drawn glass, so the Material
      // defaults for splash and dividers would fight it.
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dividerTheme: DividerThemeData(
        color: AppColors.slateA(.055),
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        headlineLarge: AppText.hero,
        headlineMedium: AppText.title,
        titleMedium: AppText.section,
        bodyMedium: AppText.body,
        labelMedium: AppText.caption,
      ),
    );
  }
}
