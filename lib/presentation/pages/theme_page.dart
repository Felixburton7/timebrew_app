// lib/presentation/pages/theme_page.dart

import 'package:final_timebrew_app/core/app_theme.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemePage extends StatelessWidget {
  // Define the theme colors associated with each AppTheme
  final Map<AppTheme, List<Color>> themeColors = {
    AppTheme.Basic: [
      const Color(0xFF1DB954), // Spotify Green
      const Color(0xFF66E38D), // Lighter green
      Colors.black,
      Colors.white,
      Colors.grey.shade900, // Dark grey for a neutral contrast
    ],
    AppTheme.Spotify: [
      const Color(0xFF6F4E37), // Coffee Brown
      Colors.brown.shade50,
      const Color(0xFFA1887F), // Lighter brown
      Colors.brown.shade700,
      Colors.brown.shade300,
    ],
    AppTheme.Facebook: [
      const Color(0xFF1877F2), // Facebook Blue
      const Color(0xFF42A5F5), // Lighter blue
      Colors.blueAccent,
      Colors.white,
      Colors.grey.shade200, // Light grey
    ],
    AppTheme.Space: [
      Colors.purple,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.black,
      Colors.deepPurple,
    ],
    AppTheme.RedWhite: [
      Colors.red,
      Colors.yellow,
      Colors.pinkAccent,
      Colors.white,
      Colors.grey.shade300, // Light grey for balance
    ],
    AppTheme.HotPinkBlue: [
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.black,
      Colors.white,
      Colors.deepPurple,
    ],
    AppTheme.SoftPurplePink: [
      Colors.purple.shade200,
      Colors.purple.shade100,
      Colors.pink.shade200,
      Colors.white70,
      Colors.brown.shade400,
    ],
    AppTheme.Coffee: [
      const Color(0xFF6F4E37), // Coffee Brown
      const Color(0xFFA1887F), // Lighter brown
      Colors.brown.shade50,
      Colors.brown.shade700,
      Colors.brown.shade300,
    ],
    AppTheme.OrangeBlackBrown: [
      // Existing New Theme Colors
      Colors.black,
      const Color(0xFFCC8400), // Darker Orange Secondary
      Colors.black,
      Colors.brown.shade700,
      Colors.brown.shade300,
    ],
    AppTheme.SoftGreen: [
      // Existing New Theme Colors
      const Color(0xFFA8E6CF), // Soft Green Primary
      const Color(0xFFB2DFDB), // Complementary Soft Green
      const Color(0xFFDcedC1), // Lighter Soft Green Secondary
      Colors.white,
      Colors.green.shade100,
    ],
    AppTheme.BlackRed: [
      // Black and Red Theme Colors
      Colors.black,
      Colors.red,
      Colors.redAccent,
      Colors.black,
      Colors.white,
    ],
    AppTheme.Sunset: [
      // Sunset Theme Colors
      Colors.deepOrange,
      Colors.orangeAccent,
      Colors.deepOrangeAccent,
      Colors.orange.shade100,
      Colors.yellow.shade100,
    ],
    AppTheme.Ocean: [
      // Ocean Theme Colors
      Colors.blue.shade800,
      Colors.cyan,
      Colors.blueAccent,
      Colors.lightBlue.shade100,
      Colors.teal.shade100,
    ],
    // New Themes
    AppTheme.Monochrome: [
      Colors.black,
      Colors.grey.shade800,
      Colors.grey.shade600,
      Colors.grey.shade400,
      Colors.white,
    ],
    AppTheme.Pastel: [
      Colors.pink.shade200,
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.yellow.shade200,
      Colors.purple.shade200,
    ],
    AppTheme.Neon: [
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.pinkAccent,
      Colors.yellowAccent,
      Colors.cyanAccent,
    ],
  };

  ThemePage({super.key});

  // Optional: Helper method for display names
  String getThemeDisplayName(AppTheme theme) {
    switch (theme) {
      case AppTheme.Basic:
        return 'Basic';
      case AppTheme.Spotify:
        return 'Spotify';
      case AppTheme.Facebook:
        return 'Facebook';
      case AppTheme.Space:
        return 'Space';
      case AppTheme.RedWhite:
        return 'Red White';
      case AppTheme.HotPinkBlue:
        return 'Hot Pink Blue';
      case AppTheme.SoftPurplePink:
        return 'Soft Purple Pink';
      case AppTheme.OrangeBlackBrown:
        return 'Orange Black Brown';
      case AppTheme.SoftGreen:
        return 'Soft Green';
      case AppTheme.BlackRed:
        return 'Black Red';
      case AppTheme.Coffee:
        return 'Coffee';
      case AppTheme.Sunset:
        return 'Sunset';
      case AppTheme.Ocean:
        return 'Ocean';
      case AppTheme.Monochrome:
        return 'Monochrome';
      case AppTheme.Pastel:
        return 'Pastel';
      case AppTheme.Neon:
        return 'Neon';
      default:
        return theme.toString().split('.').last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final themeBloc = BlocProvider.of<ThemeBloc>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Select Theme'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Determine crossAxisCount based on screen width for responsiveness
                int crossAxisCount;
                double screenWidth = constraints.maxWidth;

                if (screenWidth >= 1200) {
                  crossAxisCount = 4;
                } else if (screenWidth >= 800) {
                  crossAxisCount = 3;
                } else {
                  crossAxisCount = 2;
                }

                // Define box size based on available width
                double totalSpacing =
                    (crossAxisCount - 1) * 16; // 16 is grid spacing
                double boxWidth =
                    (constraints.maxWidth - totalSpacing) / crossAxisCount;
                double boxHeight = boxWidth *
                    0.5; // Make boxes slightly rectangular for better fit

                return GridView.builder(
                  itemCount: AppTheme.values.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        boxWidth / boxHeight, // Adjusted aspect ratio
                  ),
                  itemBuilder: (context, index) {
                    AppTheme theme = AppTheme.values[index];
                    bool isSelected = theme == themeState.appTheme;

                    // Retrieve the list of colors for the current theme
                    List<Color> colors = themeColors[theme] ?? [Colors.grey];

                    // Ensure exactly five colors for each theme
                    if (colors.length > 5) {
                      colors = colors.sublist(0, 5);
                    } else if (colors.length < 5) {
                      // If fewer than five, repeat the last color
                      while (colors.length < 5) {
                        colors.add(colors.last);
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        themeBloc.add(ThemeChangedEvent(theme: theme));
                        // Removed Navigator.pop(context) to stay on the page
                        // Show a snackbar to confirm theme change
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${getThemeDisplayName(theme)} Theme Selected'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          // ClipRRect ensures that child widgets adhere to the border radius
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  themeBloc
                                      .add(ThemeChangedEvent(theme: theme));
                                  // Removed Navigator.pop(context) to stay on the page
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //         '${getThemeDisplayName(theme)} Theme Selected'),
                                  //     duration: Duration(seconds: 2),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey,
                                      width: isSelected ? 3 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: colors.map((color) {
                                      return Expanded(
                                        child: Container(
                                          color: color,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Selection Indicator (Checkmark)
                          if (isSelected)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24, // Adjust size as needed
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
