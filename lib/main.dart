import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_test/src/brick_breaker.dart';
import 'package:flame_test/src/screens/main_menu.dart';
import 'package:flame_test/src/widgets/game_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark()
          .copyWith(textTheme: GoogleFonts.bungeeInlineTextTheme()),
      home: MainMenu()));
}
