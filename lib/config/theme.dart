import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    primaryColor: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // Main body text
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14), // Secondary text
      headlineLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), // Headline
    ),
    colorScheme: const ColorScheme.light().copyWith(
      secondary: Colors.orange, 
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey, // Example of a change

    // Customizing text theme for the dark theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16), // Main body text
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14), // Secondary text
      headlineLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), // Headline
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.amber, 
    ),
  );
}
