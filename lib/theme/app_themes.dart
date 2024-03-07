import 'package:dice/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static final mainTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(
        color: AppColors.grey,
      ));
}
