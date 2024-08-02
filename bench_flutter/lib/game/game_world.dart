import 'dart:math';

import 'package:bench_flutter/game/wanderer.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

class GameWorld extends ChangeNotifier {
  static final Logger _log = Logger('GameWorld');

  static const int batchSize = 100;

  final List<PairedWanderer> wanderers = [];

  final Random _random = Random(42);

  void addBatch({required Size worldSize}) {
    assert(batchSize.isEven);
    for (var i = 0; i < batchSize / 2; i++) {
      final a = PairedWanderer(
        velocity: (Vector2.random() - Vector2.all(0.5))..scale(100),
        worldSize: worldSize,
        position: Vector2(worldSize.width * _random.nextDouble(),
            worldSize.height * _random.nextDouble()),
        //sprite: _sprite,
      );
      final b = PairedWanderer(
        velocity: (Vector2.random() - Vector2.all(0.5))..scale(100),
        worldSize: worldSize,
        position: Vector2(worldSize.width * _random.nextDouble(),
            worldSize.height * _random.nextDouble()),
        //sprite: _sprite,
      );
      a.otherWanderer = b;
      b.otherWanderer = a;
      wanderers.add(a);
      wanderers.add(b);
    }

    notifyListeners();
  }

  void removeBatch() {
    if (wanderers.isEmpty) {
      _log.info('Cannot remove from empty list.');
      return;
    }

    for (var i = wanderers.length - batchSize; i < wanderers.length; i++) {
      // TODO?
    }
    wanderers.removeRange(wanderers.length - batchSize, wanderers.length);

    notifyListeners();
  }
}

class GameWorldWidget extends StatefulWidget {
  const GameWorldWidget({super.key});

  @override
  State<GameWorldWidget> createState() => _GameWorldWidgetState();
}

class _GameWorldWidgetState extends State<GameWorldWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    final world = context.watch<GameWorld>();

    return Stack(
      children: [
        for (final wanderer in world.wanderers)
          PairedWandererWidget(wanderer: wanderer),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
}
