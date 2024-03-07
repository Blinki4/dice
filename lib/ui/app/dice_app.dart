import 'package:dice/theme/app_themes.dart';
import 'package:dice/ui/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.mainTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
