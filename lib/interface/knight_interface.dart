import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/decoration/torch.dart';
import 'package:darkness_dungeon/interface/bar_life_component.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  Sprite key;
  Paint _paintFocus;
  Color colorShadow = Colors.black;
  double maxOpacity = 0.3;
  KnightInterface() {
    key = Sprite('itens/key_silver.png');
    _paintFocus = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;
  }

  @override
  void resize(Size size) {
    add(BarLifeComponent());
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    _drawLight(canvas);
    try {
      _drawKey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Knight).containKey) {
      key.renderRect(c, Rect.fromLTWH(150, 20, 35, 30));
    }
  }

  void _drawLight(Canvas canvas) {
    Size size = gameRef.size;
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawColor(colorShadow.withOpacity(maxOpacity), BlendMode.dstATop);

    gameRef.decorations.where((i) => i is Torch).forEach((d) {
      canvas.drawCircle(Offset(d.position.center.dx, d.position.center.dy),
          d.width * 2.5, _paintFocus);

      Gradient gradient = new RadialGradient(
        colors: <Color>[
          Colors.black.withOpacity(0.0),
          Colors.black.withOpacity(0.1),
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(maxOpacity),
        ],
        stops: [
          0.0,
          0.8,
          0.9,
          1.0,
        ],
      );

      Rect rect = new Rect.fromCircle(
        center: new Offset(d.position.center.dx, d.position.center.dy),
        radius: d.width * 2.5,
      );
      // create the Shader from the gradient and the bounding square
      final Paint paint = new Paint()..shader = gradient.createShader(rect);
      canvas.drawCircle(Offset(d.position.center.dx, d.position.center.dy),
          d.width * 2.5, paint);
      // and draw an arc
    });
    canvas.restore();
  }
}
