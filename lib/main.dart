// lib/main.dart

import 'package:flutter/material.dart';
import 'package:mobile_assingment/providers/brand_provider.dart';
import 'package:mobile_assingment/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'providers/auth_provider.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'sign_in_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => BrandProvider()),
        // Add other providers here as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Wizard',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          // If authenticated, show HomePage, otherwise show SignInScreen
          return auth.isAuthenticated ? HomePage() : SignInScreen();
        },
      ),
    );
  }
}