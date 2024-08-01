import 'package:flame/components.dart';

class Background extends PositionComponent with HasGameRef {
  late final SpriteComponent spriteComponent;

  Background();

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load('wood-background.jpg');

    spriteComponent = SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      scale: Vector2.all(gameRef.size.y / 2160),
      position: gameRef.size / 2,
    );
    add(spriteComponent);
  }
}
