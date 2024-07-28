import 'package:bench_flame/settings/settings.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import 'bench_flame.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [BenchFlame] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final settingsController = context.read<SettingsController>();

    return Scaffold(
      body: GameWidget<BenchFlame>(
        key: const Key('play session'),
        game: BenchFlame(
          audioController: audioController,
          settingsController: settingsController,
        ),
      ),
    );
  }
}
