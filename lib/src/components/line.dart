import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LineComponent extends Component {
  final Vector2 start;
  final Vector2 end;

  LineComponent({
    required this.start,
    required this.end,
  });

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    canvas.drawLine(start.toOffset(), end.toOffset(), paint);
  }
}
