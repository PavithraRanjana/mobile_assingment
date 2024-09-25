import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the color scheme.
  colorScheme: ColorScheme.dark(
    primary: Colors.blueAccent, // Primary color
    secondary: Colors.deepOrange, // Secondary color
    tertiary: Colors.green, // Tertiary color for price text
    background: Colors.grey[900]!, // Background color
    surface: Colors.grey[700]!, // Surface color (used for Card background)
    onPrimary: Colors.black, // Text color on primary
    onSecondary: Colors.black, // Text color on secondary
    onBackground: Colors.white, // Text color on background
    onSurface: Colors.white, // Text color on surface
  ),

  // Scaffold background color
  scaffoldBackgroundColor: Colors.grey[900],

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850], // AppBar background color
    elevation: 0, // No shadow
    iconTheme: IconThemeData(
      color: Colors.white, // AppBar icon color
    ),
    titleTextStyle: TextStyle(
      color: Colors.white, // AppBar title color
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white, // AppBar actions icon color
    ),
  ),

  // BottomNavigationBar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[900], // BottomNavigationBar background
    selectedItemColor: Colors.blueAccent, // Selected item color
    unselectedItemColor: Colors.grey, // Unselected items color
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  // Card theme
  cardTheme: CardTheme(
    color:  Colors.grey[700], // Card background color
    elevation: 2, // Shadow elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Rounded corners
    ),
  ),

  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent, // Button background color (replaces 'primary')
      foregroundColor: Colors.black, // Button text color (replaces 'onPrimary')
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
  ),

  // Text theme
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);
