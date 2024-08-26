import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/components/bullet.dart';
import 'package:flame_test/src/components/explosion.dart';
import 'package:flame_test/src/config.dart';
import 'package:flutter/material.dart';

class Word extends SpriteAnimationComponent
    with HasGameReference<BrickBreaker>, CollisionCallbacks {
  Word({
    required super.position,
    required this.velocity,
    required Color color,
    required this.text, // 추가된 텍스트 매개변수
  }) : super(
            size: Vector2(wordWidth, wordHeight),
            anchor: Anchor.bottomCenter,
            paint: Paint()
              ..color = color
              ..style = PaintingStyle.fill,
            children: [
              RectangleHitbox(),
              TextComponent(
                text: text,
                textRenderer: TextPaint(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
                anchor: Anchor.topCenter,
                position: Vector2(wordWidth / 2, wordHeight / 2),
              ),
            ]);
  final String text;
  Vector2 velocity;
  // @override
  // Future<void> onLoad() async {
  //   add(RectangleHitbox.relative(Vector2(1.0, 1.0), parentSize: size));
  //   sprite = await Sprite.load('wordImage.png');
  // }

  @override
  Future<void> onLoad() async {
    final image = await game.images.load('bird.png');

    const frameWidth = 128.0;
    const frameHeight = 128.0;
    const yOffset = 2 * frameHeight;

    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(frameWidth, frameHeight),
    );

    animation = spriteSheet.createAnimation(
      from: 0,
      to: 7,
      row: 2,
      stepTime: 0.1,
    );
    //angle = pi;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.y >= endLine) {
      game.score.value -= 1000;
      removeFromParent(); // 화면 밖으로 나가면 제거
    }
  }

  void updateVelocity(Vector2 newVelocity) {
    velocity = newVelocity;
  }

  void showExplosionAndRemove() {
    // 현재 위치에 Explosion 애니메이션을 추가합니다.
    final explosion = Explosion(
      position: position.clone(),
      size: Vector2.all(128), // 폭발 애니메이션 크기
    );
    game.world.add(explosion);

    // Word 객체를 제거합니다.
    removeFromParent();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      game.score.value += 100;
      // Bullet과 충돌하면 Word를 제거
      showExplosionAndRemove();
      other.removeFromParent(); // 총알도 제거
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
