import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final String label;

  final VoidCallback onPressed;

  const Button({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        onPressed();
      },
      child: Text(label),
    );
  }
}
