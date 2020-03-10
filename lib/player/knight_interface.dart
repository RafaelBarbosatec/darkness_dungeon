import 'dart:ui';

import 'package:darkness_dungeon/core/game_interface.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  double maxLife = 0;
  double life = 0;
  double widthBar = 200;
  double strokeWidth = 10;
  double padding = 20;

  @override
  void update(double t) {
    life = this.gameRef.player.life;
    maxLife = this.gameRef.player.maxLife;
    super.update(t);
  }

  @override
  void render(Canvas c) {
    _drawLife(c);
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    canvas.drawLine(
        Offset(padding, padding),
        Offset(padding + widthBar, padding),
        Paint()
          ..color = Colors.blueGrey
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(padding, padding),
        Offset(padding + currentBarLife, padding),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
