import 'dart:math';

import 'package:flame/components.dart';

class Logo extends PositionComponent with HasGameRef {
  late final SpriteComponent spriteComponent;

  double _age = 0;

  Logo();

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load('logo.png');

    final scale = Vector2.all(0.25 * gameRef.size.y / sprite.originalSize.y);

    spriteComponent = SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      scale: scale,
      position: Vector2(gameRef.size.x * 0.4, gameRef.size.y * 0.12),
    );
    add(spriteComponent);
  }

  @override
  void update(double dt) {
    _age += dt;

    spriteComponent.angle = sin(_age / 2) * 0.05;
  }
}
