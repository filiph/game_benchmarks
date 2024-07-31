import 'dart:math';

import 'package:flame/components.dart';

class Background extends PositionComponent with HasGameRef {
  late final SpriteComponent spriteComponent;

  late final Vector2 _minScale;

  double _age = 0;

  Background();

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load('wood-background.jpg');

    _minScale = Vector2.all(1.2 * gameRef.size.x / sprite.originalSize.x);

    spriteComponent = SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      scale: _minScale,
      position: gameRef.size / 2,
    );
    add(spriteComponent);
  }

  @override
  void update(double dt) {
    _age += dt;

    spriteComponent.scale = _minScale.scaled(1 + sin(_age / 6) * 0.05);
  }
}
