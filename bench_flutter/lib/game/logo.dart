import 'dart:math';

import 'package:flutter/widgets.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({super.key});

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(microseconds: (4 * pi * 1000000).round()));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RotationTransition(
        turns:
            CurvedAnimation(parent: _controller, curve: const _WobbleCurve()),
        child: FractionallySizedBox(
          heightFactor: 0.25,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}

class _WobbleCurve extends Curve {
  const _WobbleCurve();

  @override
  double transformInternal(double t) => sin(t * pi * 2) * 0.05 / pi;
}
