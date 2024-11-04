import 'package:final_timebrew_app/presentation/pages/homepage.dart';
import 'package:final_timebrew_app/presentation/pages/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _steamController;
  late AnimationController _buttonController;
  late AnimationController _pressController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _positionAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _pressScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for steam
    _steamController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    // Set up animations for opacity (fade in and out) and position (move up)
    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _steamController, curve: Curves.easeInOut));

    _positionAnimation = Tween<double>(begin: 0.0, end: -70.0).animate(
      CurvedAnimation(parent: _steamController, curve: Curves.easeIn),
    );

    // Initialize button animations
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.ease),
    );
    _pressScaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.ease),
    );

    // Start the button animation when page loads
    _buttonController.forward();
  }

  @override
  void dispose() {
    _steamController.dispose();
    _buttonController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 31, 31, 31), // Black
              Color.fromARGB(255, 0, 0, 0), // Black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Icon(Icons.coffee, color: Color(0xFF1DB954), size: 200),
                  Image.asset(
                    'assets/images/appstore3.png',
                    width: 200,
                    height: 200,
                  ),
                  Positioned(
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSteamLine(16, 0.7), // Smalß
                        const SizedBox(width: 5),
                        _buildSteamLine(22, 0.7), // Big
                        const SizedBox(width: 5),
                        _buildSteamLine(16, 0.7), // Small
                        const SizedBox(width: 22),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Positioned(
                    left: 3,
                    child: Text(
                      'TimeBrew',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    child: Text(
                      'TimeBrew',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 68.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'TimeBrew',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 68.0,
                      // fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45.0),
              GestureDetector(
                onTapDown: (_) => _pressController.forward(),
                onTapUp: (_) {
                  _pressController.reverse();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child: ScaleTransition(
                    scale: _pressScaleAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 44, 179, 91), // Green background color
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 9),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color(0xFF1DB954),
        backgroundColor: Colors.black.withOpacity(0.1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
        child: const Icon(Icons.settings, color: Colors.white, size: 30),
      ),
    );
  }

  // Method to build each steam line with a specific size and opacity
  Widget _buildSteamLine(double size, double opacity) {
    return AnimatedBuilder(
      animation: _steamController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _positionAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value * opacity,
            child: Icon(
              Icons.waves,
              color: Colors.white.withOpacity(opacity),
              size: size,
            ),
          ),
        );
      },
    );
  }
}
