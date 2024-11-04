// import 'package:flutter/material.dart';

// class CoffeeCupAnimation extends StatelessWidget {
//   final double fillPercentage; // Value between 0.0 and 1.0
//   final Size size;

//   const CoffeeCupAnimation(
//       {super.key, required this.fillPercentage, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: size,
//       painter: CoffeeCupPainter(
//         fillPercentage: fillPercentage,
//         context: context, // Pass the context to access theme
//       ),
//     );
//   }
// }

// class CoffeeCupPainter extends CustomPainter {
//   final double fillPercentage;
//   final BuildContext context;

//   CoffeeCupPainter({required this.fillPercentage, required this.context});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final cupWidth = size.width;
//     final cupHeight = size.height;

//     // Access theme colors
//     final theme = Theme.of(context);
//     final primaryColor = theme.colorScheme.primary;
//     final secondaryColor = theme.colorScheme.secondary;
//     final headColor = theme.colorScheme.onSecondary;

//     // Paints
//     final cupPaint = Paint()
//       ..color = primaryColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5; // Thicker outline

//     // Cup shape
//     final cupBodyPath = Path();
//     cupBodyPath.moveTo(cupWidth * 0.2, cupHeight * 0.1);

//     // Left side curve
//     cupBodyPath.quadraticBezierTo(
//       cupWidth * 0.15,
//       cupHeight * 0.5,
//       cupWidth * 0.3,
//       cupHeight * 0.85,
//     );

//     // Bottom line
//     cupBodyPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);

//     // Right side curve
//     cupBodyPath.quadraticBezierTo(
//       cupWidth * 0.85,
//       cupHeight * 0.5,
//       cupWidth * 0.8,
//       cupHeight * 0.1,
//     );

//     cupBodyPath.close();

//     // Draw cup outline
//     canvas.drawPath(cupBodyPath, cupPaint);

//     // Handle shape
//     final handlePaint = Paint()
//       ..color = primaryColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5;

//     // Outer Path
//     final handleOuterPath = Path();
//     handleOuterPath.moveTo(cupWidth * 0.81, cupHeight * 0.25);
//     handleOuterPath.quadraticBezierTo(
//       cupWidth * 1.05,
//       cupHeight * 0.3,
//       cupWidth * 0.76,
//       cupHeight * 0.68,
//     );
//     canvas.drawPath(handleOuterPath, handlePaint);

//     // Inner Path with consistent offset
//     final handleInnerPath = Path();
//     handleInnerPath.moveTo(cupWidth * 0.81, cupHeight * 0.3);
//     handleInnerPath.quadraticBezierTo(
//       cupWidth * 0.98,
//       cupHeight * 0.3,
//       cupWidth * 0.78,
//       cupHeight * 0.6,
//     );
//     canvas.drawPath(handleInnerPath, handlePaint);

//     // Only draw the liquid if fillPercentage is greater than zero
//     if (fillPercentage > 0.0) {
//       // Liquid paint with gradient
//       final liquidPaint = Paint()
//         ..shader = LinearGradient(
//           colors: [secondaryColor, secondaryColor.withOpacity(0.7)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ).createShader(Rect.fromLTWH(0, 0, cupWidth, cupHeight))
//         ..style = PaintingStyle.fill;

//       // Liquid fill
//       final liquidTop = cupHeight * 0.85 - (cupHeight * 0.75 * fillPercentage);

//       final liquidPath = Path();
//       liquidPath.moveTo(cupWidth * 0.2, liquidTop);
//       liquidPath.quadraticBezierTo(
//         cupWidth * 0.15,
//         cupHeight * 0.5,
//         cupWidth * 0.3,
//         cupHeight * 0.85,
//       );
//       liquidPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);
//       liquidPath.quadraticBezierTo(
//         cupWidth * 0.85,
//         cupHeight * 0.5,
//         cupWidth * 0.8,
//         liquidTop,
//       );
//       liquidPath.close();

//       // Clip and draw the liquid inside the cup
//       canvas.save();
//       canvas.clipPath(cupBodyPath);
//       canvas.drawPath(liquidPath, liquidPaint);

//       // Draw the 'head' on top of the liquid
//       final headHeight = cupHeight * 0.03;
//       final headTop = liquidTop - headHeight;

//       final headPath = Path();
//       headPath.moveTo(cupWidth * 0.2, headTop);
//       headPath.quadraticBezierTo(
//         cupWidth * 0.15,
//         cupHeight * 0.5,
//         cupWidth * 0.3,
//         cupHeight * 0.85,
//       );
//       headPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);
//       headPath.quadraticBezierTo(
//         cupWidth * 0.85,
//         cupHeight * 0.5,
//         cupWidth * 0.8,
//         headTop,
//       );
//       headPath.close();

//       // Apply gradient to head (foam)
//       final headPaint = Paint()
//         ..shader = LinearGradient(
//           colors: [
//             headColor.withOpacity(0.9),
//             headColor.withOpacity(0.7),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ).createShader(Rect.fromLTWH(0, headTop, cupWidth, headHeight))
//         ..style = PaintingStyle.fill;

//       // Clip the head to be only on top of the liquid
//       canvas.clipRect(Rect.fromLTWH(0, 0, cupWidth, liquidTop));
//       canvas.drawPath(headPath, headPaint);

//       canvas.restore();
//     }
//     // If fillPercentage is zero, do not fill the cup's interior
//     // The background will show through the cup's interior naturally
//   }

//   @override
//   bool shouldRepaint(CoffeeCupPainter oldDelegate) {
//     return oldDelegate.fillPercentage != fillPercentage;
//   }
// }
import 'package:flutter/material.dart';

class CoffeeCupAnimation extends StatelessWidget {
  final double fillPercentage; // Value between 0.0 and 1.0
  final Size size;

  const CoffeeCupAnimation({
    Key? key,
    required this.fillPercentage,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: CoffeeCupPainter(
        fillPercentage: fillPercentage,
        context: context, // Pass the context to access theme
      ),
    );
  }
}

class CoffeeCupPainter extends CustomPainter {
  final double fillPercentage;
  final BuildContext context;

  CoffeeCupPainter({required this.fillPercentage, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final cupWidth = size.width;
    final cupHeight = size.height;

    // Access theme colors
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final headColor = theme.colorScheme.onSecondary;

    // Paints
    final cupPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6; // Increased stroke width

    // Cup shape
    final cupBodyPath = Path();
    cupBodyPath.moveTo(cupWidth * 0.2, cupHeight * 0.1);

    // Left side curve
    cupBodyPath.quadraticBezierTo(
      cupWidth * 0.15,
      cupHeight * 0.5,
      cupWidth * 0.3,
      cupHeight * 0.85,
    );

    // Bottom line
    cupBodyPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);

    // Right side curve
    cupBodyPath.quadraticBezierTo(
      cupWidth * 0.85,
      cupHeight * 0.5,
      cupWidth * 0.8,
      cupHeight * 0.1,
    );

    cupBodyPath.close();

    // Draw cup outline
    canvas.drawPath(cupBodyPath, cupPaint);

    // Handle shape
    final handlePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    // Outer Path
    final handleOuterPath = Path();
    handleOuterPath.moveTo(cupWidth * 0.81, cupHeight * 0.25);
    handleOuterPath.quadraticBezierTo(
      cupWidth * 1.05,
      cupHeight * 0.3,
      cupWidth * 0.76,
      cupHeight * 0.68,
    );
    canvas.drawPath(handleOuterPath, handlePaint);

    // Inner Path with consistent offset
    final handleInnerPath = Path();
    handleInnerPath.moveTo(cupWidth * 0.81, cupHeight * 0.3);
    handleInnerPath.quadraticBezierTo(
      cupWidth * 0.98,
      cupHeight * 0.3,
      cupWidth * 0.78,
      cupHeight * 0.6,
    );
    canvas.drawPath(handleInnerPath, handlePaint);

    // Only draw the liquid if fillPercentage is greater than zero
    if (fillPercentage > 0.0) {
      // Liquid paint with gradient
      final liquidPaint = Paint()
        ..shader = LinearGradient(
          colors: [secondaryColor, secondaryColor.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, cupWidth, cupHeight))
        ..style = PaintingStyle.fill;

      // Liquid fill
      final liquidTop = cupHeight * 0.85 - (cupHeight * 0.75 * fillPercentage);

      final liquidPath = Path();
      liquidPath.moveTo(cupWidth * 0.2, liquidTop);
      liquidPath.quadraticBezierTo(
        cupWidth * 0.15,
        cupHeight * 0.5,
        cupWidth * 0.3,
        cupHeight * 0.85,
      );
      liquidPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);
      liquidPath.quadraticBezierTo(
        cupWidth * 0.85,
        cupHeight * 0.5,
        cupWidth * 0.8,
        liquidTop,
      );
      liquidPath.close();

      // Clip and draw the liquid inside the cup
      canvas.save();
      canvas.clipPath(cupBodyPath);
      canvas.drawPath(liquidPath, liquidPaint);

      // Draw the 'head' on top of the liquid
      final headHeight = cupHeight * 0.03;
      final headTop = liquidTop - headHeight;

      final headPath = Path();
      headPath.moveTo(cupWidth * 0.2, headTop);
      headPath.quadraticBezierTo(
        cupWidth * 0.15,
        cupHeight * 0.5,
        cupWidth * 0.3,
        cupHeight * 0.85,
      );
      headPath.lineTo(cupWidth * 0.7, cupHeight * 0.85);
      headPath.quadraticBezierTo(
        cupWidth * 0.85,
        cupHeight * 0.5,
        cupWidth * 0.8,
        headTop,
      );
      headPath.close();

      // Apply gradient to head (foam)
      final headPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            headColor.withOpacity(0.9),
            headColor.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, headTop, cupWidth, headHeight))
        ..style = PaintingStyle.fill;

      // Clip the head to be only on top of the liquid
      canvas.clipRect(Rect.fromLTWH(0, 0, cupWidth, liquidTop));
      canvas.drawPath(headPath, headPaint);

      canvas.restore();
    }
    // If fillPercentage is zero, do not fill the cup's interior
    // The background will show through the cup's interior naturally
  }

  @override
  bool shouldRepaint(CoffeeCupPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage;
  }
}
