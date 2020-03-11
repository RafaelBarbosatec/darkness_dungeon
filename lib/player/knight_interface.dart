import 'dart:ui';

import 'package:darkness_dungeon/core/game_interface.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  double maxLife = 0;
  double life = 0;
  double widthBar = 115;
  double strokeWidth = 10;
  double padding = 20;
  Sprite healthBar;
  KnightInterface() {
    healthBar = Sprite('health_ui.png');
  }

  @override
  void update(double t) {
    life = this.gameRef.player.life;
    maxLife = this.gameRef.player.maxLife;
    super.update(t);
  }

  @override
  void render(Canvas c) {
    _drawLife(c);
    _drawSprite(c);
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 49;
    double yBar = 32;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(padding + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(padding + currentBarLife, yBar),
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

  void _drawSprite(Canvas c) {
    double w = 120;
    double factor = 0.3375;
    healthBar.renderRect(c, Rect.fromLTWH(padding, padding, w, w * factor));
  }
}
