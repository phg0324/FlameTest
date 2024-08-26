import 'package:flutter/material.dart';

const brickColors = [
  // Add this const
  Color(0xfff94144),
  Color(0xfff3722c),
  Color(0xfff8961e),
  Color(0xfff9844a),
  Color(0xfff9c74f),
  Color(0xff90be6d),
  Color(0xff43aa8b),
  Color(0xff4d908e),
  Color(0xff277da1),
  Color(0xff577590),
];
final List<String> randomWords = [
  "사과",
  "바나나",
  "체리",
  "포도",
  "딸기",
  "수박",
  "멜론",
  "복숭아",
  "자두",
  "망고",
  "귤",
  "레몬",
  "오렌지",
  "파인애플",
  "참외",
  "배",
  "블루베리",
  "라즈베리",
  "크랜베리",
  "무화과",
  "대추",
  "감",
  "밤",
  "호두",
  "아몬드",
  "잣",
  "도토리",
  "코코넛",
  "감귤",
  "매실"
];
final Map<String, List<String>> wordMappings = {
  "사과": ["사파", "자과", "사광"],
  "바나나": ["바나마", "바바나", "파나나"],
  "체리": ["체이", "재리", "테리"],
  "포도": ["포로", "호도", "토도"],
  "딸기": ["딸히", "딸이", "딸귀"],
  "수박": ["수팍", "수밬", "슈박"],
  "멜론": ["멜른", "멜롱", "멜논"],
  "복숭아": ["복수아", "봌숭아", "복숭라"],
  "자두": ["자루", "자두 ", "차두"],
  "망고": ["만고", "망호", "망오"],
  "귤": ["굴", "귤 ", "귤이"],
  "레몬": ["레몽", "레몬 ", "네몬"],
  "오렌지": ["오랜지", "오렌찌", "오레지"],
  "파인애플": ["파이애플", "파인에플", "파인에플 "],
  "참외": ["참왜", "참와", "삼외"],
  "배": ["패", "벼", "페"],
  "블루베리": ["블루뱌리", "블루베니", "블루베리 "],
  "라즈베리": ["라즈뱌리", "라즈베니", "라즈베리 "],
  "크랜베리": ["크랜베니", "크랜버리", "크렝베리"],
  "무화과": ["무화나", "무홰과", "무화꽈"],
  "대추": ["대주", "대츄", "되추"],
  "감": ["감 ", "깜", "감이"],
  "밤": ["밤 ", "밥", "범"],
  "호두": ["호두 ", "호루", "호두이"],
  "아몬드": ["아몬르", "아먼드", "아몬두"],
  "잣": ["잧", "잣이", "잠"],
  "도토리": ["도톨이", "도토르", "도토리 "],
  "코코넛": ["코코넝", "코코넛 ", "코코늣"],
  "감귤": ["감굴", "감결", "감귤 "],
  "매실": ["매실 ", "매쉴", "매실이"],
};
const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;
const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.5;
const wordWidth = gameWidth * 0.2;
const wordHeight = gameHeight * 0.05;

const charWidth = 144.0;
const charHeight = 192.0;

const endLine = gameHeight - (charHeight / 3) * 2;
