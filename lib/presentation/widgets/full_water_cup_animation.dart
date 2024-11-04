import 'dart:math';
import 'package:flutter/material.dart';
// Import statements...

class FullWidthWaterCup extends StatefulWidget {
  final double fillPercentage;
  final Size size;

  const FullWidthWaterCup(
      {Key? key, required this.fillPercentage, required this.size})
      : super(key: key);

  @override
  FullWidthWaterCupState createState() => FullWidthWaterCupState();
}

class FullWidthWaterCupState extends State<FullWidthWaterCup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int waveSegments = 100;
  double waveFrequency = 2.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void increaseWaveFrequency() {
    setState(() {
      waveFrequency += 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: FullWidthWaterPainter(
            fillPercentage: widget.fillPercentage,
            context: context,
            wavePhase: _controller.value * 2 * pi,
            waveSegments: waveSegments,
            waveFrequency: waveFrequency,
          ),
        );
      },
    );
  }
}

class FullWidthWaterPainter extends CustomPainter {
  final double fillPercentage;
  final BuildContext context;
  final double wavePhase;
  final int waveSegments;
  final double waveFrequency;

  FullWidthWaterPainter({
    required this.fillPercentage,
    required this.context,
    required this.wavePhase,
    required this.waveSegments,
    required this.waveFrequency,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Access theme colors
    final theme = Theme.of(context);
    final waterColor = theme.colorScheme.primary.withOpacity(0.7);

    // Calculate liquidTop based on fillPercentage
    final liquidTop = height * (1 - fillPercentage);

    final waveAmplitude = height * 0.02; // Adjust amplitude as needed

    final liquidPath = Path();

    // Start the wave from the left
    liquidPath.moveTo(0, liquidTop);

    for (int i = 0; i <= waveSegments; i++) {
      final double x = (i / waveSegments) * width;
      final double sineValue =
          sin((x / width) * 2 * pi * waveFrequency + wavePhase);
      final double y = liquidTop + sineValue * waveAmplitude;

      if (i == 0) {
        liquidPath.lineTo(x, y);
      } else {
        final double prevX = (i - 1) / waveSegments * width;
        final double prevY = liquidTop +
            sin(((i - 1) / waveSegments) * 2 * pi * waveFrequency + wavePhase) *
                waveAmplitude;
        final double controlX = (prevX + x) / 2;
        final double controlY = (prevY + y) / 2;

        liquidPath.quadraticBezierTo(prevX, prevY, controlX, controlY);
        liquidPath.quadraticBezierTo(x, y, x, y);
      }
    }

    // Complete the path for the liquid shape
    liquidPath.lineTo(width, height);
    liquidPath.lineTo(0, height);
    liquidPath.close();

    final liquidPaint = Paint()
      ..color = waterColor
      ..style = PaintingStyle.fill;

    // Draw the liquid
    canvas.drawPath(liquidPath, liquidPaint);
  }

  @override
  bool shouldRepaint(FullWidthWaterPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.wavePhase != wavePhase ||
        oldDelegate.waveFrequency != waveFrequency;
  }
}
