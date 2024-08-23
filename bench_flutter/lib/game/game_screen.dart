import 'package:bench_flutter/audio/audio_controller.dart';
import 'package:bench_flutter/game/button.dart';
import 'package:bench_flutter/game/game_world.dart';
import 'package:bench_flutter/game/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameWorld()),
      ],
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/wood-background.jpg',
              fit: BoxFit.cover,
            ),
            const GameWorldWidget(),
            const RepaintBoundary(child: LogoWidget()),
            const _DisappearingButtons(),
            Positioned(
              left: 250,
              top: 150,
              child: Button(
                label: 'Audio on/off',
                onPressed: () {
                  context.read<AudioController>().toggleAudioOn();
                },
              ),
            ),
            Positioned(
              left: 250,
              top: 250,
              child: Builder(builder: (context) {
                return Button(
                  label: '+100 entities',
                  onPressed: () {
                    final worldSize = MediaQuery.of(context).size;
                    context.read<GameWorld>().addBatch(worldSize: worldSize);
                  },
                );
              }),
            ),
            Positioned(
              left: 250,
              top: 300,
              child: Builder(builder: (context) {
                return Button(
                  label: '-100 entities',
                  onPressed: () {
                    context.read<GameWorld>().removeBatch();
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _DisappearingButtons extends StatefulWidget {
  const _DisappearingButtons();

  @override
  State<_DisappearingButtons> createState() => _DisappearingButtonsState();
}

class _DisappearingButtonsState extends State<_DisappearingButtons> {
  late final List<Widget?> buttons;

  @override
  void initState() {
    buttons = List.generate(
        20,
        (i) => Button(
              label: 'Button ${i + 1}',
              onPressed: () => setState(() => buttons[i] = null),
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 20; i++)
          if (buttons[i] != null)
            Positioned(
              left: 700,
              top: 30.0 + 22 * i,
              child: buttons[i]!,
            ),
      ],
    );
  }
}
