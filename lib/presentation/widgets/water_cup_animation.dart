import 'dart:math';
import 'package:flutter/material.dart';

class WaterCupAnimation extends StatefulWidget {
  final double fillPercentage; // Value between 0.0 and 1.0
  final Size size;

  const WaterCupAnimation(
      {super.key, required this.fillPercentage, required this.size});

  @override
  _WaterCupAnimationState createState() => _WaterCupAnimationState();
}

class _WaterCupAnimationState extends State<WaterCupAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int waveSegments = 50; // Number of segments for smoothness
  double waveFrequency = 2.0; // Initial wave frequency

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(seconds: 8), // Slower animation for wave movement
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles tap events and increases wave frequency if tapped within the water area.
  void _handleTapDown(TapDownDetails details, Size size) {
    final tapX = details.localPosition.dx;
    final tapY = details.localPosition.dy;

    final cupWidth = size.width;
    final cupHeight = size.height;

    // Calculate liquidTop based on fillPercentage
    final liquidTop =
        cupHeight * 0.95 - (cupHeight * 0.85 * widget.fillPercentage);

    // Check if the tap is within the water area
    if (tapY >= liquidTop && tapY <= cupHeight * 0.95) {
      setState(() {
        waveFrequency += 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleTapDown(details, widget.size),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: widget.size,
            painter: WaterCupPainter(
              fillPercentage: widget.fillPercentage,
              context: context,
              wavePhase: _controller.value * 2 * pi, // Shift wave phase
              waveSegments: waveSegments,
              waveFrequency: waveFrequency, // Pass current wave frequency
            ),
          );
        },
      ),
    );
  }
}

class WaterCupPainter extends CustomPainter {
  final double fillPercentage;
  final BuildContext context;
  final double wavePhase;
  final int waveSegments;
  final double waveFrequency;

  WaterCupPainter({
    required this.fillPercentage,
    required this.context,
    required this.wavePhase,
    required this.waveSegments,
    required this.waveFrequency,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cupWidth = size.width;
    final cupHeight = size.height;

    // Access theme colors
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final headColor = theme.colorScheme.onSecondary;

    // Paints
    final cupPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final liquidPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.shade300,
          Colors.blue.shade700,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, cupWidth, cupHeight))
      ..style = PaintingStyle.fill;

    final headPaint = Paint()
      ..color = headColor
      ..style = PaintingStyle.fill;

    // **Adjusted Cup Shape: Thinner and Longer**
    final cupBodyPath = Path();

    // Reduced the width proportions to make the cup thinner
    final topWidth = cupWidth * 0.65; // Previously 0.8
    final bottomWidth = cupWidth * 0.45; // Previously 0.6

    // Adjusted vertical positions to make the cup longer
    final topOffsetX = (cupWidth - topWidth) / 2;
    final bottomOffsetX = (cupWidth - bottomWidth) / 2;

    // Changed vertical positions from 0.1 and 0.85 to 0.05 and 0.95
    cupBodyPath.moveTo(topOffsetX, cupHeight * 0.05); // Top of the cup
    cupBodyPath.lineTo(bottomOffsetX, cupHeight * 0.95); // Bottom left
    cupBodyPath.lineTo(
        cupWidth - bottomOffsetX, cupHeight * 0.95); // Bottom right
    cupBodyPath.lineTo(cupWidth - topOffsetX, cupHeight * 0.05); // Top right
    cupBodyPath.close();

    // Draw cup outline
    canvas.drawPath(cupBodyPath, cupPaint);

    // **Adjusted Liquid Fill Position**
    // Recalculated liquidTop based on new vertical positions
    final liquidTop = cupHeight * 0.918 - (cupHeight * 0.85 * fillPercentage);

    final waveAmplitude = cupHeight * 0.01; // Adjusted amplitude for smoothness

    final liquidPath = Path();

    // Start the wave from the left
    liquidPath.moveTo(0, liquidTop);

    for (int i = 0; i <= waveSegments; i++) {
      final double x = (i / waveSegments) * cupWidth;
      final double sineValue =
          sin((x / cupWidth) * 2 * pi * waveFrequency + wavePhase);
      final double y = liquidTop + sineValue * waveAmplitude;

      // Define control points for smooth quadratic Bezier curves
      if (i == 0) {
        liquidPath.lineTo(x, y);
      } else {
        final double prevX = (i - 1) / waveSegments * cupWidth;
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
    liquidPath.lineTo(cupWidth, cupHeight * 0.99);
    liquidPath.lineTo(0, cupHeight * 0.99);
    liquidPath.close();

    // Clip and draw the liquid inside the cup
    canvas.save();
    canvas.clipPath(cupBodyPath);
    canvas.drawPath(liquidPath, liquidPaint);

    // Draw the 'head' on top of the liquid with a smooth, flat top
    final headHeight = cupHeight * 0.01;
    final headTop = liquidTop - headHeight;

    if (fillPercentage > 0) {
      final headPath = Path();
      headPath.moveTo(0, headTop); // Flat top line start
      headPath.lineTo(cupWidth, headTop); // Flat top line end
      headPath.lineTo(cupWidth, liquidTop);
      headPath.lineTo(0, liquidTop);
      headPath.close();

      final headGradient = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

      headPaint.shader =
          headGradient.createShader(Rect.fromLTWH(0, 0, cupWidth, headHeight));

      // Draw the flat top head of the liquid
      canvas.drawPath(headPath, headPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(WaterCupPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.wavePhase != wavePhase ||
        oldDelegate.waveFrequency != waveFrequency ||
        oldDelegate.context != context;
  }
}
