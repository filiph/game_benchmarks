import 'package:bench_flame/flame_game/background.dart';
import 'package:bench_flame/flame_game/callback_button.dart';
import 'package:bench_flame/flame_game/disappearing_button.dart';
import 'package:bench_flame/flame_game/logo.dart';
import 'package:bench_flame/settings/settings.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../audio/audio_controller.dart';
import 'bench_world.dart';

class BenchFlame extends FlameGame<BenchWorld> {
  BenchFlame({
    required this.audioController,
    required this.settingsController,
  }) : super(
          world: BenchWorld(),
          camera: CameraComponent(),
        );

  final AudioController audioController;

  final SettingsController settingsController;

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(Background());

    camera.viewfinder.position = Vector2(size.x / 2, size.y / 2);

    camera.viewport.add(Logo());

    for (var i = 0; i < 20; i++) {
      final disBtn = DisappearingButton('Button ${i + 1}');
      disBtn.position.setValues(700.0, 30.0 + 22 * i);
      camera.viewport.add(disBtn);
    }

    final audBtn = CallbackButton('Audio on/off', callback: () {
      settingsController.toggleAudioOn();
    });
    audBtn.position.setValues(250, 100);
    camera.viewport.add(audBtn);

    final incBtn = CallbackButton(
      '+${BenchWorld.batchSize} entities',
      callback: () => world.addBatch(),
    );
    incBtn.position.setValues(250, 250);
    camera.viewport.add(incBtn);

    final decBtn = CallbackButton(
      '-${BenchWorld.batchSize} entities',
      callback: () => world.removeBatch(),
    );
    decBtn.position.setValues(250, 300);
    camera.viewport.add(decBtn);
  }
}
