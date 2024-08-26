import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/components/components.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<BrickBreaker>, CollisionCallbacks {
  Bullet({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            anchor: Anchor.center,
            priority: 10);
  final Vector2 velocity = Vector2(0, -1000); // 총알의 속도 (위쪽 방향)
  @override
  Future<void> onLoad() async {
    final List<Sprite> sprites = [];
    for (int i = 0; i < 60; i++) {
      final image = await game.images.load('bulletImages/1_$i.png');
      sprites.add(Sprite(image));
    }
    final spriteSheet = await game.images.load('bullet.png');
    final spriteSize = Vector2(100, 100);

    animation = SpriteAnimation.spriteList(
      sprites,
      stepTime: 0.01,
      loop: true,
    );
    angle = pi / 2; // 90도 회전 (라디안 단위)
    add(RectangleHitbox.relative(Vector2(1.0, 1.0), parentSize: size / 2));
    await super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Word) {
      // Word와 충돌 시 Bullet을 제거 (Word는 Word 클래스에서 제거됨)
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt; // 총알을 위로 이동시킴

    //총알이 화면을 벗어나면 제거
    if (position.y < 0) {
      removeFromParent();
    }
  }
}
