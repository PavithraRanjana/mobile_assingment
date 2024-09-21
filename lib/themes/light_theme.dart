// lib/themes/light_theme.dart

import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the color scheme.
  colorScheme: ColorScheme.light(
    primary: Colors.blueAccent, // Primary color
    secondary: Colors.orange, // Secondary color
    background: Colors.white, // Background color
    surface: Colors.white, // Surface color (e.g., Card background)
    onPrimary: Colors.white, // Text color on primary
    onSecondary: Colors.white, // Text color on secondary
    onBackground: Colors.black, // Text color on background
    onSurface: Colors.black, // Text color on surface
  ),

  // Scaffold background color
  scaffoldBackgroundColor: Colors.white,

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // AppBar background color
    elevation: 0, // No shadow
    iconTheme: IconThemeData(
      color: Colors.black, // AppBar icon color
    ),
    titleTextStyle: TextStyle(
      color: Colors.black, // AppBar title color
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black, // AppBar actions icon color
    ),
  ),

  // BottomNavigationBar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // BottomNavigationBar background
    selectedItemColor: Colors.blueAccent, // Selected item color
    unselectedItemColor: Colors.grey, // Unselected items color
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  // Card theme
  cardTheme: CardTheme(
    color: Colors.white, // Card background color
    elevation: 2, // Shadow elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
    ),
  ),

  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent, // Button background color (replaces 'primary')
      foregroundColor: Colors.white, // Button text color (replaces 'onPrimary')
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
  ),

  // InputDecoration theme for TextFields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[300], // Light grey fill color
    prefixIconColor: Colors.grey[600], // Grey color for prefix icons
    hintStyle: TextStyle(
      color: Colors.grey[600], // Grey hint text color
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), // Rounded corners
      borderSide: BorderSide(
        color: Colors.grey[300]!, // Light grey border color
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), // Rounded corners
      borderSide: BorderSide(
        color: Colors.grey[300]!, // Light grey border color
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), // Rounded corners
      borderSide: BorderSide(
        color: Colors.blueAccent, // Primary color border when focused
      ),
    ),
    // Optional: Adjust content padding for better alignment
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  ),

  // Text theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
  ),
);
