import 'package:flame/components.dart';

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
      SpriteComponent(
        sprite: sprite,
        anchor: Anchor.center,
        scale: Vector2.all(0.5),
      ),
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
