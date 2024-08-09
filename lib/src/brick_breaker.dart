import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/src/config.dart';

class BrickBreaker extends FlameGame {
  BrickBreaker()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: gameWidth, height: gameHeight));
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onload() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;
  }
}
