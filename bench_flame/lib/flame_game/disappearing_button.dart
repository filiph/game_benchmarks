import 'package:flame/components.dart';
import 'package:flame/events.dart';

class DisappearingButton extends PositionComponent with TapCallbacks {
  final String label;

  late final TextComponent _textComponent;

  DisappearingButton(this.label);

  @override
  bool containsLocalPoint(Vector2 point) {
    return _textComponent.containsLocalPoint(point);
  }

  @override
  Future<void> onLoad() async {
    _textComponent = TextComponent(text: label);
    await add(_textComponent);
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
  }
}
