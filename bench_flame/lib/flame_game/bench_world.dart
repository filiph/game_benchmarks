import 'dart:math';

import 'package:bench_flame/flame_game/bench_flame.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class BenchWorld extends World with TapCallbacks, HasGameReference {
  static const int batchSize = 1000;

  final List<PairedWanderer> wanderers = [];

  final Random _random = Random(42);

  late final Sprite _sprite;

  BenchWorld({
    Random? random,
  });

  @override
  Future<void> onLoad() async {
    _sprite = await Sprite.load('sprite.png');
  }

  @override
  void onTapDown(TapDownEvent event) {}

  void addBatch() {
    assert(batchSize.isEven);
    final worldSize = (parent as BenchFlame).size;
    for (var i = 0; i < batchSize / 2; i++) {
      final a = PairedWanderer(
        velocity: (Vector2.random() - Vector2.all(0.5))..scale(100),
        worldSize: worldSize,
        position: Vector2(worldSize.x * _random.nextDouble(),
            worldSize.y * _random.nextDouble()),
        sprite: _sprite,
      );
      final b = PairedWanderer(
        velocity: (Vector2.random() - Vector2.all(0.5))..scale(100),
        worldSize: worldSize,
        position: Vector2(worldSize.x * _random.nextDouble(),
            worldSize.y * _random.nextDouble()),
        sprite: _sprite,
      );
      a.otherWanderer = b;
      b.otherWanderer = a;
      add(a);
      add(b);
      wanderers.add(a);
      wanderers.add(b);
    }
  }

  void removeBatch() {
    for (var i = wanderers.length - batchSize; i < wanderers.length; i++) {
      wanderers[i].removeFromParent();
    }
    wanderers.removeRange(wanderers.length - batchSize, wanderers.length);
  }
}

class PairedWanderer extends PositionComponent {
  PairedWanderer? otherWanderer;

  final Vector2 velocity;

  final Vector2 worldSize;

  final Sprite sprite;

  PairedWanderer({
    required this.velocity,
    required this.worldSize,
    required super.position,
    required this.sprite,
  });

  @override
  Future<void> onLoad() async {
    await add(
      SpriteComponent(sprite: sprite),
    );
  }

  @override
  void update(double dt) {
    position.addScaled(velocity, dt);
    if (otherWanderer != null) {
      position.addScaled(otherWanderer!.velocity, dt * 0.25);
    }

    if (position.x < 0 && velocity.x < 0) {
      velocity.x = -velocity.x;
    } else if (position.x > worldSize.x && velocity.x > 0) {
      velocity.x = -velocity.x;
    }
    if (position.y < 0 && velocity.y < 0) {
      velocity.y = -velocity.y;
    } else if (position.y > worldSize.y && velocity.y > 0) {
      velocity.y = -velocity.y;
    }
  }
}
