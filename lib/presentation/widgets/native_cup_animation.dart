import 'package:flutter/material.dart';

class NativeCupAnimationPage extends StatelessWidget {
  final double fillPercentage; // Value between 0.0 and 1.0

  const NativeCupAnimationPage({super.key, required this.fillPercentage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color here
      body: NativeCupAnimation(fillPercentage: fillPercentage),
    );
  }
}

class NativeCupAnimation extends StatelessWidget {
  final double fillPercentage; // Value between 0.0 and 1.0

  const NativeCupAnimation({super.key, required this.fillPercentage});

  @override
  Widget build(BuildContext context) {
    // Use the full screen size
    final Size size = MediaQuery.of(context).size;

    return CustomPaint(
      size: size,
      painter: NativeCupPainter(
        fillPercentage: fillPercentage,
        context: context, // Pass the context to access theme
      ),
    );
  }
}

class NativeCupPainter extends CustomPainter {
  final double fillPercentage;
  final BuildContext context;

  NativeCupPainter({required this.fillPercentage, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final double cupWidth = size.width;
    final double cupHeight = size.height;

    // Access theme colors
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color dialogBackgroundColor = theme.scaffoldBackgroundColor;
    final Color backgroundColor = theme.scaffoldBackgroundColor;

    // Paints
    final Paint cupPaint = Paint()
      ..color = backgroundColor // Set cup borders to background color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Cup shape - straight sides
    final Path cupBodyPath = Path();
    cupBodyPath.moveTo(cupWidth * 0.1, cupHeight * 0.05); // Top left
    cupBodyPath.lineTo(cupWidth * 0.1, cupHeight * 0.95); // Bottom left
    cupBodyPath.lineTo(cupWidth * 0.9, cupHeight * 0.95); // Bottom right
    cupBodyPath.lineTo(cupWidth * 0.9, cupHeight * 0.05); // Top right
    cupBodyPath.close();

    // Draw cup outline (now invisible as it matches the background)
    canvas.drawPath(cupBodyPath, cupPaint);

    // **Draw the visible line at the bottom**
    final Paint bottomLinePaint = Paint()
      ..color = primaryColor // Use primaryColor for visibility
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(cupWidth * 0.1, cupHeight * 0.95), // Start at bottom left
      Offset(cupWidth * 0.9, cupHeight * 0.95), // End at bottom right
      bottomLinePaint,
    );

    // Liquid fill
    if (fillPercentage > 0.0) {
      // Liquid paint using dialogBackgroundColor
      final Paint liquidPaint = Paint()
        ..color = dialogBackgroundColor
        ..style = PaintingStyle.fill;

      // Calculate the top position of the liquid based on fillPercentage
      final double liquidFillHeight = cupHeight * 0.9;
      final double liquidTop =
          cupHeight * 0.95 - (liquidFillHeight * fillPercentage);

      final Path liquidPath = Path();
      liquidPath.moveTo(cupWidth * 0.1, cupHeight * 0.95);
      liquidPath.lineTo(cupWidth * 0.1, liquidTop);
      liquidPath.lineTo(cupWidth * 0.9, liquidTop);
      liquidPath.lineTo(cupWidth * 0.9, cupHeight * 0.95);
      liquidPath.close();

      // Clip and draw the liquid inside the cup
      canvas.save();
      canvas.clipPath(cupBodyPath);
      canvas.drawPath(liquidPath, liquidPaint);

      // Draw the 'head' on top of the liquid using primaryColor
      final double headHeight = cupHeight * 0.03;
      final double headTop = liquidTop - headHeight;

      if (fillPercentage > 0) {
        final Path headPath = Path();
        headPath.moveTo(cupWidth * 0.1, headTop);
        headPath.lineTo(cupWidth * 0.9, headTop);
        headPath.lineTo(cupWidth * 0.9, liquidTop);
        headPath.lineTo(cupWidth * 0.1, liquidTop);
        headPath.close();

        final Paint headPaint = Paint()
          ..color = primaryColor
          ..style = PaintingStyle.fill;

        // Draw the head on top of the liquid
        canvas.clipRect(Rect.fromLTWH(0, 0, cupWidth, liquidTop));
        canvas.drawPath(headPath, headPaint);
      }

      canvas.restore();
    }

    // No additional reflections or details
  }

  @override
  bool shouldRepaint(NativeCupPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage;
  }
}
