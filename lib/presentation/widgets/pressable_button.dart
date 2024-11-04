// lib/presentation/widgets/pressable_button.dart

import 'package:flutter/material.dart';

class PressableButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonStyle style;

  const PressableButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.style,
  });

  @override
  _PressableButtonState createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _pressAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_pressController);
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pressAnimation,
      child: ElevatedButton(
        onPressed: () async {
          await _pressController.forward();
          await _pressController.reverse();
          widget.onPressed();
        },
        style: widget.style,
        child: Text(
          widget.label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
