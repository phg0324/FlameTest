import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/src/brick_breaker.dart';

abstract class Item extends SpriteComponent with CollisionCallbacks {
  Item() : super();

  void applyEffect();
}
