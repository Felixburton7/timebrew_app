// lib/presentation/pages/settings_page.dart

import 'package:final_timebrew_app/core/app_theme.dart';
import 'package:final_timebrew_app/presentation/blocs/bloc/theme_bloc.dart';
import 'package:final_timebrew_app/presentation/pages/audio_page.dart';
import 'package:final_timebrew_app/presentation/pages/theme_page.dart';
import 'package:final_timebrew_app/presentation/pages/about_page.dart'; // Import AboutPage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  // Define the theme names and corresponding AppTheme enums
  final Map<AppTheme, String> themeNames = {
    AppTheme.Basic: 'Basic Theme',
    AppTheme.Spotify: 'Spotify Theme',
    AppTheme.Facebook: 'Facebook Theme',
    AppTheme.Coffee: 'Coffee Theme',
    AppTheme.Space: 'Space Theme',
    AppTheme.RedWhite: 'Red White Theme',
    AppTheme.HotPinkBlue: 'Hot Pink Blue Theme',
    AppTheme.SoftPurplePink: 'Soft Purple Pink Theme',
    AppTheme.OrangeBlackBrown: 'Orange Black Brown Theme',
    AppTheme.SoftGreen: 'Soft Green Theme',
    AppTheme.BlackRed: 'Black Red Theme', // Ensure all themes are included
    AppTheme.Sunset: 'Sunset Theme',
    AppTheme.Ocean: 'Ocean Theme',
  };

  // Contact Developer email
  final String developerEmail = 'felixburton2002@gmail.com';

  // App share link
  final String appShareLink =
      'https://github.com/yourusername/final_timebrew_app';

  SettingsPage({super.key}); // Update with your actual repo link

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final themeBloc = BlocProvider.of<ThemeBloc>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0, // Remove shadow for a flat look
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // Change Theme ListTile
                    ListTile(
                      leading: const Icon(Icons.color_lens),
                      title: const Text('Change Theme'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ThemePage()),
                        );
                      },
                    ),

                    ListTile(
                        leading: const Icon(Icons.music_note),
                        title: const Text('Audio Themes'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AudioPage()));
                        }),
                    // Contact Developer ListTile
                    ListTile(
                      leading: const Icon(Icons.contact_mail),
                      title: const Text('Contact Developer'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: developerEmail,
                          queryParameters: {
                            'subject': 'App Feedback',
                          },
                        );

                        if (await canLaunchUrl(emailUri)) {
                          await launchUrl(emailUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Could not launch email client')),
                          );
                        }
                      },
                    ),

                    // Share This App ListTile
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text('Share This App'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Share.share(
                          'Check out this awesome Time App!\n$appShareLink',
                          subject: 'TimeBrew',
                        );
                      },
                    ),

                    // Version Information ListTile

                    // About Page ListTile
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Version 1.0.0'),
                      // No trailing icon as it's static information
                      onTap: () {
                        // Optionally, you can add functionality here if needed
                      },
                    ),
                  ],
                ),
              ),

              // Optional: If you want to keep a footer outside the ListView
              // You can remove or comment out the following Padding widget
              /*
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '👋 Hi, I\'m Felix!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'I\'m a student and developed this app as all alternatives had ads. This is an open-source project. If you want to add anything, just send a pull request! Also, feel free to reach out with any feedback or suggestions.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              */
            ],
          ),
        );
      },
    );
  }
}
