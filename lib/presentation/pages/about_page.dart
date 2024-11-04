// lib/presentation/pages/about_page.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  // GitHub repository link
  final String githubRepoLink =
      'https://github.com/felixburton7/timebrew_app'; // Replace with your actual GitHub repo link

  // LinkedIn profile link
  final String linkedInLink =
      'https://www.linkedin.com/in/felix-burton-353a7016b/'; // Replace with your actual LinkedIn profile link

  // Twitter profile link
  final String twitterLink = 'https://twitter.com/yourprofile';

  const AboutPage({super.key}); // Replace with your actual Twitter profile link

  // Function to launch URLs
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define text styles
    final TextStyle headerStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    final TextStyle subHeaderStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    final TextStyle bodyStyle = const TextStyle(
      fontSize: 16,
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0, // Remove shadow for a flat look
        iconTheme: IconThemeData(
          color: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.color, // Icon color based on theme
        ),
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/appstore.png'), // Add your profile picture in assets
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '👋 Hi, I\'m Felix!',
                    style: headerStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Me Section
            Text(
              'About Me',
              style: subHeaderStyle,
            ),
            const SizedBox(height: 8),
            const Text(
              'I\'m a student who developed this app to help with 4th year studies. This is an open-source project that prioritizes user experience and community contributions.',
            ),
            const SizedBox(height: 24),

            // App Information Section
            Text(
              'About the App',
              style: subHeaderStyle,
            ),
            const SizedBox(height: 8),
            const Text(
                'This App is designed to help focus by providing a distraction-free, customizable timer. Stay on track with this app’s timer options, designed to support productivity without interruptions.'),
            const SizedBox(height: 24),

            // GitHub Repository Link
            ListTile(
              leading: Icon(
                Icons.code,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'View on GitHub',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                _launchURL(context, githubRepoLink);
              },
            ),
            const Divider(),

            // Social Media Links Section
            Text(
              'Connect',
              style: subHeaderStyle,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // LinkedIn Icon
                IconButton(
                  icon: const Icon(Icons.email),
                  color: Colors.blue[700],
                  onPressed: () {
                    _launchURL(context, linkedInLink);
                  },
                ),
                const SizedBox(width: 16),

                // Twitter Icon
                IconButton(
                  icon: const Icon(Icons.message),
                  color: Colors.blue,
                  onPressed: () {
                    _launchURL(context, twitterLink);
                  },
                ),
                const SizedBox(width: 16),

                // GitHub Icon
                IconButton(
                  icon: const Icon(Icons.code),
                  color: Colors.black,
                  onPressed: () {
                    _launchURL(context, githubRepoLink);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // License Information Section (Optional)
            Text(
              'License',
              style: subHeaderStyle,
            ),
            const SizedBox(height: 8),
            const Text(
              'This project is licensed under the MIT License. Feel free to use, modify, and distribute it as per the terms of the license.',
            ),
            const SizedBox(height: 24),

            // Footer Section
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
