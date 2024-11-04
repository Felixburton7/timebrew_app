import 'dart:async';
import 'package:flutter/material.dart';
import 'beer_cup_animation.dart';
import 'coffee_cup_animation.dart';
import 'water_cup_animation.dart';
import 'native_cup_animation.dart'; // Import the NativeCupAnimation class

// Define the CupType enum, adding the new cup type.
enum CupType {
  Beer,
  Water,
  Nativecup,
  FullScreenWater, // New cup type added
  Coffee,
}

class GenericCupAnimation extends StatefulWidget {
  final CupType cupType;
  final double fillPercentage;
  final Size size;
  final bool isCompleted;

  const GenericCupAnimation({
    super.key,
    required this.cupType,
    required this.fillPercentage,
    required this.size,
    this.isCompleted = false,
  });

  @override
  _GenericCupAnimationState createState() => _GenericCupAnimationState();
}

class _GenericCupAnimationState extends State<GenericCupAnimation>
    with TickerProviderStateMixin {
  late AnimationController _fillController;
  late AnimationController _shakeController;
  late Animation<double> _fillAnimation;
  bool _showFireworks = false;

  @override
  void initState() {
    super.initState();

    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fillAnimation = Tween<double>(
      begin: widget.fillPercentage,
      end: widget.fillPercentage,
    ).animate(_fillController);
    _fillController.forward();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(GenericCupAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fillPercentage != widget.fillPercentage) {
      // Stop any ongoing animations
      _fillController.stop();

      // Update the animation to go from the current fill level to the new fill level
      _fillAnimation = Tween<double>(
        begin: _fillAnimation.value,
        end: widget.fillPercentage,
      ).animate(_fillController);

      // Reset and start the animation
      _fillController.reset();
      _fillController.forward();
    }

    if (widget.isCompleted && !_showFireworks) {
      _triggerCompletionEffects();
    }
  }

  void _triggerCompletionEffects() {
    _shakeController.repeat(reverse: true);
    setState(() {
      _showFireworks = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _shakeController.stop();
      setState(() {
        _showFireworks = false; // Hide fireworks after they shoot off-screen
      });
    });
  }

  @override
  void dispose() {
    _fillController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fillController,
      builder: (context, child) {
        final offset = widget.isCompleted ? 5.0 * _shakeController.value : 0.0;
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(offset, 0),
              child: _buildCupWidget(_fillAnimation.value),
            ),
            if (_showFireworks) _buildFireworksOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildCupWidget(double fillPercentage) {
    switch (widget.cupType) {
      case CupType.Coffee:
        return CoffeeCupAnimation(
          fillPercentage: fillPercentage,
          size: widget.size,
        );
      case CupType.Water:
        return WaterCupAnimation(
          fillPercentage: fillPercentage,
          size: widget.size,
        );
      case CupType.Beer:
        return BeerCupAnimation(
          fillPercentage: fillPercentage,
          size: widget.size,
        );
      case CupType.Nativecup:
        return NativeCupAnimation(
          fillPercentage: fillPercentage,
        );
      default:
        return CoffeeCupAnimation(
          fillPercentage: fillPercentage,
          size: widget.size,
        );
    }
  }

  Widget _buildFireworksOverlay() {
    return Stack(
      children: [
        _animatedFirework(Alignment.center, const Alignment(-2, -2)),
        _animatedFirework(Alignment.center, const Alignment(2, -2)),
        _animatedFirework(Alignment.center, const Alignment(-2, 2)),
        _animatedFirework(Alignment.center, const Alignment(2, 2)),
      ],
    );
  }

  Widget _animatedFirework(Alignment start, Alignment end) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      left: end.x * 200 + widget.size.width / 2,
      top: end.y * 200 + widget.size.height / 2,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: _showFireworks ? 1.0 : 0.0,
        child: const Icon(
          Icons.star,
          color: Colors.orangeAccent,
          size: 30,
        ),
      ),
    );
  }
}
