// main.dart

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Wizard',
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Light theme
      darkTheme: darkTheme, // Dark theme
      themeMode: ThemeMode.system, // Use system theme (can be ThemeMode.light or ThemeMode.dark)
      home: HomePage(),
    );
  }
}
