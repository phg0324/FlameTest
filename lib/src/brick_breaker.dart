import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_test/src/components/bullet.dart';
import 'package:flame_test/src/components/character.dart';
import 'package:flame_test/src/components/line.dart';
import 'package:flame_test/src/config.dart';
import 'package:flame_test/src/items/bomb_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';

enum PlayState { welcome, playing, gameOver, won }

class BrickBreaker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  BrickBreaker()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: gameWidth, height: gameHeight));

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;
  final ValueNotifier<List<String>> buttonTexts =
      ValueNotifier(["", "", "", ""]);
  String currentWord = "";
  int currentCorrectIndex = -1;
  ValueNotifier<int> life = ValueNotifier(3);
  ValueNotifier<double> wordVelocity = ValueNotifier(100);
  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  //////////////////////////////////////////////////
  /// 아이템 사용 횟수
  final List<int> itemCounts = [3, 0, 0];
  final List<String> itemImages = ['bomb.png', 'clock.png', 'show.png'];
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft; // (0,0)에 고정
    world.add(PlayArea());
    playState = PlayState.welcome;
    debugMode = true;
  }

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Word>());

    playState = PlayState.playing;
    overlays.add("ButtonOverlay");
    // 오버레이 등록
    overlays.add('ItemButtons'); // 게임 시작 시 오버레이를 활성화
    score.value = 0;
    final characterX = (width) / 2;
    final characterY = height - (charHeight / 3);
    world.add(Character(
      position: Vector2(characterX, characterY),
      size: Vector2(charWidth, charHeight),
    ));
    final lineStart = Vector2(0, endLine);
    final lineEnd = Vector2(width, endLine);
    world.add(LineComponent(start: lineStart, end: lineEnd));
    for (int i = 0; i < 30; i++) {
      Future.delayed(Duration(milliseconds: i * 2000), () {
        final word = Word(
          position: Vector2(rand.nextDouble() * width, 0), // 랜덤한 x 위치
          velocity: Vector2(0, wordVelocity.value), // y축 방향으로 속도 설정
          color: Colors.blue,
          text: randomWords[i],
        );

        world.add(word);
      });
    }
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final words = world.children.query<Word>();
    if (words.isNotEmpty) {
      final firstWordText = words.first.text;
      debugPrint(firstWordText);
      if (currentWord != firstWordText) {
        currentWord = firstWordText;
        updateButtonTexts(firstWordText);
      }
    } else {
      if (buttonTexts.value.first.isNotEmpty) {
        buttonTexts.value = ["", "", "", ""];
      }
    }
  }

  void updateButtonTexts(String correctText) {
    final correctIndex = rand.nextInt(4);
    final wrongOptions = wordMappings[correctText]?.toList() ?? ["", "", ""];
    currentCorrectIndex = correctIndex;
    // 오타 목록을 무작위로 섞기
    wrongOptions.shuffle();
    List<String> sub = ["", "", "", ""];
    for (int i = 0; i < 4; i++) {
      if (i == correctIndex) {
        sub[i] = correctText;
      } else {
        sub[i] = wrongOptions.removeLast();
      }
    }
    buttonTexts.value = sub;
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);

  // 가장 먼저 생성된 Word를 찾아 제거하고 버튼 텍스트 업데이트
  void removeFirstWord(int i) {
    final words = world.children.query<Word>();

    if (words.isNotEmpty && i == currentCorrectIndex) {
      final wordToRemove = words.first;
      final wordXPosition = wordToRemove.position.x;

      final character = world.children.query<Character>().first;

      character.position.x = wordXPosition;
      score.value += 100;
      final existingBullet = world.children.query<Bullet>();
      if (existingBullet.isEmpty) {
        // 총알이 없을 때만 발사
        shootBullet();
      }
      //if (score.value % 100 == 0) {
      wordVelocity.value = wordVelocity.value + 50;
      for (final word in words) {
        word.updateVelocity(Vector2(
          0,
          wordVelocity.value,
        ));
        debugPrint(word.velocity.toString());
      }
      //}
      //world.remove(wordToRemove);
    } else {
      score.value -= 100;
    }
  }

  void shootBullet() {
    final character = world.children.query<Character>().first;
    final characterPosition = character.position.clone();
    final bullet = Bullet(
      position: characterPosition +
          Vector2(0, -character.size.y / 2), // 캐릭터의 발사 위치 (중앙 위쪽)
      size: Vector2(200, 200), // 총알의 크기
    );
    world.add(bullet); // 총알을 월드에 추가
  }

  void useItem(int index) {
    if (itemCounts[index] > 0) {
      switch (index) {
        case 0:
          // 폭탄 아이템 사용
          useBomb();
          break;
        case 1:
          // 다른 아이템 사용
          // useOtherItem();
          break;
        // 추가적인 아이템 사용 로직...
      }

      itemCounts[index]--; // 사용 횟수 감소
      overlays.remove('ItemButtons');
      overlays.add('ItemButtons');
      if (itemCounts[index] == 0) {
        // 아이템 사용 횟수가 0이면 버튼 비활성화 또는 숨기기
        overlays.remove('ItemButtons');
        overlays.add('ItemButtons'); // 버튼 UI를 갱신
      }
    }
  }

  void useBomb() {
    BombItem.applyEffect(this);
  }
}
