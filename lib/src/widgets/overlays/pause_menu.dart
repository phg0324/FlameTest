import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/screens/main_menu.dart';
import 'package:flame_test/src/widgets/pause_button.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final BrickBreaker gameRef;

  const PauseMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text("Paused")),
        ElevatedButton(
            onPressed: () {
              gameRef.resumeEngine();
              gameRef.overlays.remove(PauseMenu.ID);
              gameRef.overlays.add(PauseButton.ID);
            },
            child: Text("Resume")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainMenu()));
            },
            child: Text("Exit")),
      ],
    ));
  }
}
