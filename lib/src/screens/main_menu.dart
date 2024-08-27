import 'package:flame_test/src/screens/game_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text("MainMenu")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GamePlay()));
                },
                child: Text("Play")),
            ElevatedButton(onPressed: () {}, child: Text("Options")),
          ],
        ),
      ),
    );
  }
}
