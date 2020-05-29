import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/collision/collision.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

class Knight extends SimplePlayer with WithLighting {
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
            collision: Collision(width: 20, height: tileSize * 0.7)) {
    lightingConfig = LightingConfig(
      gameComponent: this,
      color: Colors.white.withOpacity(0.1),
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
    gameRef.addDecoration(
      GameDecoration.sprite(
        Sprite('player/crypt.png'),
        initPosition: Position(
          positionInWorld.left,
          positionInWorld.top,
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
        width: tileSize * 0.8,
        height: tileSize * 0.8,
        damage: 10,
        speed: initSpeed * 1.5 * (tileSize / 32),
        destroy: () {
          Sounds.explosion();
        },
        collision: Collision(
          width: tileSize * 0.5,
          height: tileSize * 0.5,
          align: CollisionAlign.CENTER,
        ),
        lightingConfig: LightingConfig(
          gameComponent: this,
          color: Colors.yellow.withOpacity(0.1),
          radius: tileSize * 0.9,
          blurBorder: tileSize / 2,
        ));
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _verifyStamina();
    this.seeEnemy(
      visionCells: 6,
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
