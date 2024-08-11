import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:vector_math/vector_math_64.dart';

class PairedWanderer {
  PairedWanderer? otherWanderer;

  final Vector2 position;

  final Vector2 velocity;

  final Size worldSize;

  PairedWanderer({
    required this.position,
    required this.velocity,
    required this.worldSize,
  });

  void update(double dt) {
    position.addScaled(velocity, dt);
    if (otherWanderer != null) {
      position.addScaled(otherWanderer!.velocity, dt * 0.25);
    }

    if (position.x < 0 && velocity.x < 0) {
      velocity.x = -velocity.x;
    } else if (position.x > worldSize.width && velocity.x > 0) {
      velocity.x = -velocity.x;
    }
    if (position.y < 0 && velocity.y < 0) {
      velocity.y = -velocity.y;
    } else if (position.y > worldSize.height && velocity.y > 0) {
      velocity.y = -velocity.y;
    }
  }
}

class PairedWandererWidget extends StatefulWidget {
  final PairedWanderer wanderer;

  const PairedWandererWidget({required this.wanderer, super.key});

  @override
  State<PairedWandererWidget> createState() => _PairedWandererWidgetState();
}

class _PairedWandererWidgetState extends State<PairedWandererWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  Duration _lastElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.wanderer.position.x - 128 / 4,
      top: widget.wanderer.position.y - 128 / 4,
      child: Image.asset('assets/images/sprite.png', scale: 2),
    );
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _lastElapsed).inMicroseconds / 1000000;
    widget.wanderer.update(dt);
    _lastElapsed = elapsed;
    setState(() {});
  }
}
