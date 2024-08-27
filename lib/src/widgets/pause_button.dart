import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/widgets/overlays/pause_menu.dart';
import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final BrickBreaker gameRef;

  const PauseButton({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu.ID);
            gameRef.overlays.remove(PauseButton.ID);
          },
          child: Icon(
            Icons.pause_rounded,
            color: Colors.white,
          )),
    );
  }
}
