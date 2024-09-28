import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Customizing text theme for the light theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // Main body text
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14), // Secondary text
      headlineLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), // Headline
    ),
    // Setting the accent color for UI elements
    colorScheme: const ColorScheme.light().copyWith(
      secondary: Colors.orange, // Use this for accent elements like buttons, etc.
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    // Customizing text theme for the dark theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16), // Main body text
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14), // Secondary text
      headlineLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Headline
    ),
    // Setting the accent color for UI elements
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.amber, // Use this for accent elements in dark mode
    ),
  );
}
