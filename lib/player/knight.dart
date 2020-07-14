import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/collision/collision.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

class Knight extends SimplePlayer with Lighting {
  final Position initPosition;
  double attack = 25;
  double stamina = 100;
  double initSpeed = tileSize / 0.25;
  Timer _timerStamina;
  bool containKey = false;
  bool showObserveEnemy = false;

  Knight({
    this.initPosition,
  }) : super(
            animIdleLeft: FlameAnimation.Animation.sequenced(
              "player/knight_idle_left.png",
              6,
              textureWidth: 16,
              textureHeight: 16,
            ),
            animIdleRight: FlameAnimation.Animation.sequenced(
              "player/knight_idle.png",
              6,
              textureWidth: 16,
              textureHeight: 16,
            ),
            animRunRight: FlameAnimation.Animation.sequenced(
              "player/knight_run.png",
              6,
              textureWidth: 16,
              textureHeight: 16,
            ),
            animRunLeft: FlameAnimation.Animation.sequenced(
              "player/knight_run_left.png",
              6,
              textureWidth: 16,
              textureHeight: 16,
            ),
            width: tileSize,
            height: tileSize,
            initPosition: initPosition,
            life: 200,
            speed: tileSize / 0.25,
            collision: Collision(
              width: 20,
              height: tileSize * 0.4,
              align: Offset((tileSize - 20) / 2, tileSize * 0.6),
            )) {
    lightingConfig = LightingConfig(
      gameComponent: this,
      radius: width * 1.5,
      blurBorder: width,
    );
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    this.speed = initSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      actionAttack();
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      actionAttackRange();
    }
    super.joystickAction(event);
  }

  @override
  void die() {
    remove();
    gameRef.addGameComponent(
      GameDecoration.sprite(
        Sprite('player/crypt.png'),
        initPosition: Position(
          this.position.center.dx,
          this.position.center.dy,
        ),
        height: 30,
        width: 30,
      ),
    );
    super.die();
  }

  void actionAttack() {
    if (stamina < 15) {
      return;
    }

    Sounds.attackPlayerMelee();
    decrementStamina(15);
    this.simpleAttackMelee(
      damage: attack,
      animationBottom: FlameAnimation.Animation.sequenced(
        'player/atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationLeft: FlameAnimation.Animation.sequenced(
        'player/atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationRight: FlameAnimation.Animation.sequenced(
        'player/atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationTop: FlameAnimation.Animation.sequenced(
        'player/atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      heightArea: tileSize,
      widthArea: tileSize,
    );
  }

  void actionAttackRange() {
    if (stamina < 10) {
      return;
    }

    Sounds.attackRange();

    decrementStamina(10);
    this.simpleAttackRange(
        animationRight: FlameAnimation.Animation.sequenced(
          'player/fireball_right.png',
          3,
          textureWidth: 23,
          textureHeight: 23,
        ),
        animationLeft: FlameAnimation.Animation.sequenced(
          'player/fireball_left.png',
          3,
          textureWidth: 23,
          textureHeight: 23,
        ),
        animationTop: FlameAnimation.Animation.sequenced(
          'player/fireball_top.png',
          3,
          textureWidth: 23,
          textureHeight: 23,
        ),
        animationBottom: FlameAnimation.Animation.sequenced(
          'player/fireball_bottom.png',
          3,
          textureWidth: 23,
          textureHeight: 23,
        ),
        animationDestroy: FlameAnimation.Animation.sequenced(
          'player/explosion_fire.png',
          6,
          textureWidth: 32,
          textureHeight: 32,
        ),
        width: tileSize * 0.65,
        height: tileSize * 0.65,
        damage: 10,
        speed: initSpeed * (tileSize / 32),
        destroy: () {
          Sounds.explosion();
        },
        collision: Collision(
          width: tileSize * 0.5,
          height: tileSize * 0.5,
          align: Offset(tileSize * 0.1, tileSize * 0.1),
        ),
        lightingConfig: LightingConfig(
          gameComponent: this,
          radius: tileSize * 0.9,
          blurBorder: tileSize / 2,
        ));
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyStamina();
    this.seeEnemy(
      radiusVision: tileSize * 6,
      notObserved: () {
        showObserveEnemy = false;
      },
      observed: (enemies) {
        if (showObserveEnemy) return;
        showObserveEnemy = true;
        _showEmote();
      },
    );
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  void _verifyStamina() {
    if (_timerStamina == null) {
      _timerStamina = Timer(Duration(milliseconds: 150), () {
        _timerStamina = null;
      });
    } else {
      return;
    }

    stamina += 2;
    if (stamina > 100) {
      stamina = 100;
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }

  @override
  void receiveDamage(double damage, int id) {
    if (isDead) return;
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Colors.orange,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: FlameAnimation.Animation.sequenced(
          emote,
          8,
          textureWidth: 32,
          textureHeight: 32,
        ),
        target: this,
        width: tileSize / 2,
        height: tileSize / 2,
        positionFromTarget: Position(18, -6),
      ),
    );
  }
}
