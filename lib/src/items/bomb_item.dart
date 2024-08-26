import 'package:flame/components.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/components/components.dart';
import 'package:flame_test/src/items/item.dart';

class BombItem {
  BombItem._(); // 생성자 사용 방지

  static void applyEffect(BrickBreaker game) {
    final words = game.world.children.query<Word>();
    for (final word in words) {
      word.showExplosionAndRemove();
    }
  }
}
