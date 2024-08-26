import 'package:flame_test/src/brick_breaker.dart';
import 'package:flutter/material.dart';

class ButtonOverlay extends StatelessWidget {
  final BrickBreaker game;

  const ButtonOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 70,
      left: 0,
      right: 0,
      child: ValueListenableBuilder<List<String>>(
        valueListenable: game.buttonTexts,
        builder: (context, buttonTexts, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 4; i++)
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    game.removeFirstWord(i);
                  },
                  child: Text(
                    buttonTexts[i],
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            ],
          );
        },
      ),
    );
  }
}
