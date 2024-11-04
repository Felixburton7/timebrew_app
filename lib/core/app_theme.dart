// lib/core/app_theme.dart
import 'package:flutter/material.dart';

// Define an enum for the themes
enum AppTheme {
  Basic,
  Spotify,
  Facebook,
  Space,
  HotPinkBlue,
  SoftPurplePink,
  Coffee,
  OrangeBlackBrown, // Existing New Theme
  SoftGreen, // Existing New Theme
  BlackRed, // New Theme
  Sunset, // New Theme
  Ocean, // New Theme
  Monochrome, // New Theme
  Pastel, // New Theme
  Neon, // New Theme
  RedWhite,
}

// Map each theme to its ThemeData
final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.Basic: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1DB954), // Spotify Green
      secondary: Color(0xFF1DB954),
      onSecondary: Color(0xFF66E38D), // Lighter green for the 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1DB954),
        foregroundColor: Colors.white,
      ),
    ),
  ),

  AppTheme.Spotify: ThemeData(
    scaffoldBackgroundColor: const Color(0xFFD7CCC8),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6F4E37),
      secondary: Color(0xFF6F4E37),
      onSecondary: Color(0xFFA1887F), // Lighter brown for the 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF3E2723)),
      bodyMedium: TextStyle(color: Color(0xFF3E2723)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF3E2723)),
  ),
  AppTheme.Facebook: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1877F2), // Facebook Blue
      secondary: Color(0xFF1877F2),
      onSecondary: Color(0xFF42A5F5), // Lighter blue for the 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1877F2)),
      bodyMedium: TextStyle(color: Color(0xFF1877F2)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1877F2)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1877F2),
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Space: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.purple,
      secondary: Colors.pinkAccent,
      onSecondary: Colors.pink, // Lighter pink for the 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.pinkAccent),
      bodyMedium: TextStyle(color: Colors.purpleAccent),
    ),
    iconTheme: const IconThemeData(color: Colors.purpleAccent),
  ),
  AppTheme.RedWhite: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.red,
      secondary: Colors.yellow,
      onSecondary: Colors.yellowAccent, // Complementary color for 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.red),
      bodyMedium: TextStyle(color: Colors.red),
    ),
    iconTheme: const IconThemeData(color: Colors.red),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Coffee: ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 121, 106, 72),
      secondary: Color.fromARGB(255, 94, 50, 34),
      onSecondary: Color(0xFFBCAAA4), // Lighter brown for the 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  AppTheme.HotPinkBlue: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.pinkAccent,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white, // Complementary color for 'head'
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.pinkAccent),
      bodyMedium: TextStyle(color: Colors.blueAccent),
    ),
    iconTheme: const IconThemeData(color: Colors.blueAccent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.SoftPurplePink: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.purple.shade200,
      secondary: Colors.pink.shade200,
      onSecondary: Colors.pink.shade400, // Complementary color for 'head'
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.purple.shade200),
      bodyMedium: TextStyle(color: Colors.pink.shade200),
    ),
    iconTheme: IconThemeData(color: Colors.pink.shade200),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade200,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  // Existing New Themes
  AppTheme.OrangeBlackBrown: ThemeData(
    scaffoldBackgroundColor: Colors.brown.shade50,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Color(0xFFCC8400), // Darker Orange Secondary
      onSecondary: Colors.white, // Black for contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFA500),
        foregroundColor: Colors.black,
      ),
    ),
  ),
  AppTheme.SoftGreen: ThemeData(
    scaffoldBackgroundColor: Colors.green.shade50,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFA8E6CF), // Soft Green Primary
      secondary: Color(0xFFB2DFDB), // Complementary Soft Green
      onSecondary: Colors.white, // White for better contrast
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.green.shade800),
      bodyMedium: TextStyle(color: Colors.green.shade800),
    ),
    iconTheme: IconThemeData(color: Colors.green.shade800),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA8E6CF),
        foregroundColor: Colors.white,
      ),
    ),
  ),
  // New Themes
  AppTheme.BlackRed: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.red,
      secondary: Colors.black,
      onSecondary: Colors.redAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.red),
      bodyMedium: TextStyle(color: Colors.redAccent),
    ),
    iconTheme: const IconThemeData(color: Colors.redAccent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Sunset: ThemeData(
    scaffoldBackgroundColor: Colors.orange.shade50,
    colorScheme: const ColorScheme.light(
      primary: Colors.deepOrange,
      secondary: Colors.orangeAccent,
      onSecondary: Colors.deepOrangeAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.deepOrange),
      bodyMedium: TextStyle(color: Colors.orangeAccent),
    ),
    iconTheme: const IconThemeData(color: Colors.deepOrange),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Ocean: ThemeData(
    scaffoldBackgroundColor: Colors.blue.shade50,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      secondary: Colors.cyan,
      onSecondary: Colors.blueAccent,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.blue.shade800),
      bodyMedium: const TextStyle(color: Colors.cyan),
    ),
    iconTheme: IconThemeData(color: Colors.blue.shade800),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  // Newly Added Themes
  AppTheme.Monochrome: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.grey,
      onSecondary: Colors.white, // For contrast
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.grey),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Pastel: ThemeData(
    scaffoldBackgroundColor: Colors.pink.shade50,
    colorScheme: ColorScheme.light(
      primary: Colors.pink.shade200,
      secondary: Colors.blue.shade200,
      onSecondary: Colors.green.shade200,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.pink.shade200),
      bodyMedium: TextStyle(color: Colors.blue.shade200),
    ),
    iconTheme: IconThemeData(color: Colors.green.shade200),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink.shade200,
        foregroundColor: Colors.white,
      ),
    ),
  ),
  AppTheme.Neon: ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.greenAccent,
      secondary: Colors.blueAccent,
      onSecondary: Colors.pinkAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.greenAccent),
      bodyMedium: TextStyle(color: Colors.blueAccent),
    ),
    iconTheme: const IconThemeData(color: Colors.pinkAccent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
      ),
    ),
  ),
};
