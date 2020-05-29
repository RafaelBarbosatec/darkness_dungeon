import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MiniBoss extends SimpleEnemy {
  final Position initPosition;
  double attack = 50;
  bool _seePlayerClose = false;

  MiniBoss({
    @required this.initPosition,
  }) : super(
          animationIdleRight: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_idle.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationIdleLeft: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_idle_left.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationRunRight: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_run_right.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          animationRunLeft: FlameAnimation.Animation.sequenced(
            "enemy/mini_boss/mini_boss_run_left.png",
            4,
            textureWidth: 16,
            textureHeight: 24,
          ),
          initPosition: initPosition,
          width: tileSize * 0.68,
          height: tileSize * 0.93,
          speed: tileSize / 0.35,
          life: 150,
          collision: Collision(
            width: tileSize * 0.4,
            height: tileSize * 0.55,
          ),
        );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _seePlayerClose = false;
    this.seePlayer(
      observed: (player) {
        _seePlayerClose = true;
        this.seeAndMoveToPlayer(
          closePlayer: (player) {
            execAttack();
          },
          visionCells: 3,
        );
      },
      visionCells: 3,
    );
    if (!_seePlayerClose) {
      this.seeAndMoveToAttackRange(
        positioned: (p) {
          execAttackRange();
        },
        visionCells: 7,
      );
    }
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "smoke_explosin.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: positionInWorld,
      ),
    );
    remove();
    super.die();
  }

  void execAttackRange() {
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
      damage: attack,
      speed: speed * 1.5 * (tileSize / 32),
      execute: () {
        Sounds.attackRange();
      },
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
      ),
    );
  }

  void execAttack() {
    this.simpleAttackMelee(
      heightArea: tileSize * 0.62,
      widthArea: tileSize * 0.62,
      damage: attack / 3,
      interval: 300,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'enemy/atack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void receiveDamage(double damage, int id) {
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }
}
