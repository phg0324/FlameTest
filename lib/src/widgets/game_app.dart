import 'package:flame/game.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/components/components.dart';
import 'package:flame_test/src/config.dart';
import 'package:flame_test/src/widgets/overlays/button_overlay.dart';
import 'package:flame_test/src/widgets/item_buttons.dart';
import 'package:flame_test/src/widgets/overlays/overlay_screen.dart';
import 'package:flame_test/src/widgets/overlays/pause_menu.dart';
import 'package:flame_test/src/widgets/pause_button.dart';
import 'package:flame_test/src/widgets/score_card.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;
  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
              child: Center(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ScoreCard(score: game.score),
                //     ElevatedButton(onPressed: () {}, child: Text("||"))
                //   ],
                // ),
                Expanded(
                  child: FittedBox(
                    child: SizedBox(
                      width: gameWidth,
                      height: gameHeight,
                      child: GameWidget(
                        game: game,
                        initialActiveOverlays: [PauseButton.ID],
                        overlayBuilderMap: {
                          PlayState.welcome.name: (context, game) =>
                              const OverlayScreen(
                                title: 'TAP TO PLAY',
                                subtitle: 'Use arrow keys or swipe',
                              ),
                          PlayState.gameOver.name: (context, game) =>
                              const OverlayScreen(
                                title: 'G A M E   O V E R',
                                subtitle: 'Tap to Play Again',
                              ),
                          PlayState.won.name: (context, game) =>
                              const OverlayScreen(
                                title: 'Y O U   W O N ! ! !',
                                subtitle: 'Tap to Play Again',
                              ),
                          PauseButton.ID: (_, BrickBreaker game) =>
                              PauseButton(gameRef: game),
                          PauseMenu.ID: (_, BrickBreaker game) =>
                              PauseMenu(gameRef: game),
                          "ButtonOverlay": (_, game) =>
                              ButtonOverlay(game as BrickBreaker),
                          "ItemButtons": (_, game) => ItemButtons(
                                itemCounts: (game as BrickBreaker).itemCounts,
                                onItemPressed: game.useItem,
                                itemImages: game.itemImages,
                              ),
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
