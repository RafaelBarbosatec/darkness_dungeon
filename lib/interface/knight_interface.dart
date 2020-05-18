import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/decoration/torch.dart';
import 'package:darkness_dungeon/interface/bar_life_component.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/pulse_value.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class KnightInterface extends GameInterface {
  Sprite key;
  Paint _paintFocus;
  Color colorShadow = Colors.black;
  double maxOpacity = 0.5;
  PulseValue pulseAnimation;
  KnightInterface() {
    key = Sprite('itens/key_silver.png');
    _paintFocus = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;
    pulseAnimation = PulseValue();
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

    gameRef.decorations
        .where((i) => i is Torch && i.isVisibleInMap())
        .forEach((d) {
      _drawLightInWorld(canvas, d.position, d.position.width * 2.5, true);
      // and draw an arc
    });

    gameRef.components
        .where((i) => i is AnimatedObjectOnce && i.isVisibleInMap())
        .forEach((d) {
      _drawLightInWorld(canvas, (d as AnimatedObjectOnce).position,
          (d as AnimatedObjectOnce).position.width, false);
      // and draw an arc
    });

    gameRef.components
        .where((i) => i is FlyingAttackObject && i.isVisibleInMap())
        .forEach((d) {
      _drawLightInWorld(canvas, (d as FlyingAttackObject).position,
          (d as FlyingAttackObject).position.width, false);
      // and draw an arc
    });
    Player player = gameRef.player;
    if (player != null)
      _drawLightInWorld(canvas, player.position, player.width * 1.5, false);
    canvas.restore();
  }

  void _drawLightInWorld(
      Canvas canvas, Rect position, double radius, bool pulsar) {
    canvas.drawCircle(
        Offset(position.center.dx, position.center.dy),
        radius * (pulsar ? (1 - pulseAnimation.value * 0.1) : 1),
        _paintFocus
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(20)));

    final Paint paint = new Paint()
      ..color = Colors.orangeAccent[200].withOpacity(0.2)
      ..maskFilter =
          MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(20));
    canvas.drawCircle(Offset(position.center.dx, position.center.dy),
        radius * (pulsar ? (1 - pulseAnimation.value * 0.1) : 1), paint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  void update(double dt) {
    pulseAnimation.update(dt);
    super.update(dt);
  }
}
