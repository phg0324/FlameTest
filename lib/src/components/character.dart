import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flutter/material.dart';

class Character extends SpriteAnimationComponent
    with HasGameReference<BrickBreaker> {
  Character({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            anchor: Anchor.bottomCenter,
            priority: 10);

  @override
  Future<void> onLoad() async {
    final spriteSheet = await game.images.load('idle_up.png');
    final spriteSize = Vector2(48, 64);
    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 8, // 스프라이트 시트에 포함된 프레임 수
        textureSize: spriteSize,
        stepTime: 0.1, // 각 프레임이 보여지는 시간
        loop: true,
      ),
    );
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Character의 바닥에 선을 그립니다.
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    final lineStart = Offset(position.x, position.y + size.y);
    final lineEnd = Offset(position.x + size.x, position.y + size.y);

    canvas.drawLine(lineStart, lineEnd, paint);
  }
}
