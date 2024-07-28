import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CallbackButton extends PositionComponent with TapCallbacks {
  final String label;

  final Function() callback;

  late final TextComponent _textComponent;

  CallbackButton(this.label, {required this.callback});

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
    callback();
  }
}
