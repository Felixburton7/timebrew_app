import 'package:flutter/material.dart';

class BeerCupAnimation extends StatelessWidget {
  final double fillPercentage; // Value between 0.0 and 1.0
  final Size size;

  const BeerCupAnimation(
      {super.key, required this.fillPercentage, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: BeerCupPainter(
        fillPercentage: fillPercentage,
        context: context,
      ),
    );
  }
}

// lib/presentation/widgets/beer_cup_animation.dart

class BeerCupPainter extends CustomPainter {
  final double fillPercentage;
  final BuildContext context;

  BeerCupPainter({required this.fillPercentage, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final cupWidth = size.width;
    final cupHeight = size.height;

    // Access theme colors
    final theme = Theme.of(context);
    final primaryColor = theme.scaffoldBackgroundColor;
    // final secondaryColor = theme.colorScheme.secondary;
    const headColor = Colors.white;

    // Paints
    final cupPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final liquidPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.amber.shade300,
          Colors.amber.shade800,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, cupWidth, cupHeight))
      ..style = PaintingStyle.fill;

    final headPaint = Paint()
      ..color = headColor
      ..style = PaintingStyle.fill;

    // Cup shape without handle and increased height
    final cupBodyPath = Path();
    cupBodyPath.moveTo(cupWidth * 0.2, cupHeight * 0.05);

    // Left side curve
    cupBodyPath.quadraticBezierTo(
      cupWidth * 0.15,
      cupHeight * 0.35, // Adjusted from 0.4 to 0.35 for better proportion
      cupWidth * 0.3,
      cupHeight * 0.95, // Adjusted from 0.9 to 0.95 to make the cup taller
    );

    // Bottom line (narrower)
    cupBodyPath.lineTo(cupWidth * 0.7,
        cupHeight * 0.95); // Adjusted to match the new bottom height

    // Right side curve
    cupBodyPath.quadraticBezierTo(
      cupWidth * 0.85,
      cupHeight * 0.35, // Adjusted from 0.4 to 0.35
      cupWidth * 0.8,
      cupHeight * 0.05,
    );

    cupBodyPath.close();

    // Draw cup outline
    canvas.drawPath(cupBodyPath, cupPaint);

    // Add shadow for depth
    canvas.drawShadow(cupBodyPath, Colors.white, 2.0, false);

    // Liquid fill
    // Increase the liquid fill range from 0.85 to 0.95
    final liquidFillHeight = cupHeight * 0.85; // Increased from 0.8 to 0.85
    final liquidTop = cupHeight * 0.95 - (liquidFillHeight * fillPercentage);

    final liquidPath = Path();
    liquidPath.moveTo(cupWidth * 0.2, liquidTop);
    liquidPath.quadraticBezierTo(
      cupWidth * 0.15,
      cupHeight * 0.35,
      cupWidth * 0.3,
      cupHeight * 0.95,
    );
    liquidPath.lineTo(cupWidth * 0.7, cupHeight * 0.95);
    liquidPath.quadraticBezierTo(
      cupWidth * 0.85,
      cupHeight * 0.35,
      cupWidth * 0.8,
      liquidTop,
    );
    liquidPath.close();

    // Clip and draw the liquid inside the cup
    canvas.save();
    canvas.clipPath(cupBodyPath);
    canvas.drawPath(liquidPath, liquidPaint);

    // Draw the 'head' on top of the liquid
    final headHeight = cupHeight * 0.05; // Adjust if necessary
    final headTop = liquidTop - headHeight;

    if (fillPercentage > 0) {
      final headPath = Path();
      headPath.moveTo(cupWidth * 0.2, headTop);
      headPath.quadraticBezierTo(
        cupWidth * 0.15,
        cupHeight * 0.35,
        cupWidth * 0.3,
        cupHeight * 0.95,
      );
      headPath.lineTo(cupWidth * 0.7, cupHeight * 0.95);
      headPath.quadraticBezierTo(
        cupWidth * 0.85,
        cupHeight * 0.35,
        cupWidth * 0.8,
        headTop,
      );
      headPath.close();

      // Apply gradient to head
      final headGradient = LinearGradient(
        colors: [
          Colors.white.withOpacity(1), // Stronger white at the top
          Colors.white.withOpacity(0.9), // Softer fade
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

      headPaint.shader =
          headGradient.createShader(Rect.fromLTWH(0, 0, cupWidth, headHeight));

      // Clip the head to be only the top of the liquid
      canvas.clipRect(Rect.fromLTWH(0, 0, cupWidth, liquidTop));
      canvas.drawPath(headPath, headPaint);
    }

    canvas.restore();

    // Add reflections
    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.white.withOpacity(0.0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, cupWidth, cupHeight * 0.5))
      ..blendMode = BlendMode.srcOver
      ..style = PaintingStyle.fill;

    final reflectionPath = Path();
    reflectionPath.moveTo(cupWidth * 0.3, cupHeight * 0.2);
    reflectionPath.quadraticBezierTo(
      cupWidth * 0.4,
      cupHeight * 0.1,
      cupWidth * 0.5,
      cupHeight * 0.2,
    );
    reflectionPath.quadraticBezierTo(
      cupWidth * 0.6,
      cupHeight * 0.3,
      cupWidth * 0.7,
      cupHeight * 0.2,
    );
    reflectionPath.close();

    canvas.drawPath(reflectionPath, reflectionPaint);
  }

  @override
  bool shouldRepaint(BeerCupPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.context != context;
  }
}
