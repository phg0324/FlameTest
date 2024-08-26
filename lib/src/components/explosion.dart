import 'package:flame/components.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flutter/material.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<BrickBreaker> {
  Explosion({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
          priority: 10, // Z-인덱스 설정
        );

  @override
  Future<void> onLoad() async {
    final spriteSheet = await game.images.load('explosion_effect.png');
    final spriteSize = Vector2(32, 32); // 스프라이트 시트에서 각 프레임의 크기
    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 8, // 스프라이트 시트에 포함된 프레임 수
        textureSize: spriteSize,
        stepTime: 0.1, // 각 프레임이 보여지는 시간
        loop: false,
      ),
    );

    await super.onLoad();
    // 애니메이션이 완료되면 해당 객체를 제거합니다.
  }

  @override
  void update(double dt) {
    super.update(dt);
    print('Explosion update called, ticker done: ${animationTicker?.done()}');

    if (animationTicker?.done() == true) {
      print('Explosion finished');
      removeFromParent();
    }
  }
}
