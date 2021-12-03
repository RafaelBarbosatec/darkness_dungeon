import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/enemy_sprite_sheet.dart';
import 'package:darkness_dungeon/util/functions.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MiniBoss extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 50;
  bool _seePlayerClose = false;

  MiniBoss(this.initPosition)
      : super(
          animation: EnemySpriteSheet.miniBossAnimations(),
          position: initPosition,
          width: tileSize * 0.68,
          height: tileSize * 0.93,
          speed: tileSize / 0.35,
          life: 150,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Size(valueByTileSize(6), valueByTileSize(7)),
            align: Vector2(valueByTileSize(2.5), valueByTileSize(8)),
          ),
        ],
      ),
    );
  }

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
          radiusVision: tileSize * 3,
        );
      },
      radiusVision: tileSize * 3,
    );
    if (!_seePlayerClose) {
      this.seeAndMoveToAttackRange(
        positioned: (p) {
          execAttackRange();
        },
        radiusVision: tileSize * 5,
      );
    }
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: this.position,
      ),
    );
    removeFromParent();
    super.die();
  }

  void execAttackRange() {
    this.simpleAttackRange(
      animationRight: GameSpriteSheet.fireBallAttackRight(),
      animationLeft: GameSpriteSheet.fireBallAttackLeft(),
      animationUp: GameSpriteSheet.fireBallAttackTop(),
      animationDown: GameSpriteSheet.fireBallAttackBottom(),
      animationDestroy: GameSpriteSheet.fireBallExplosion(),
      width: tileSize * 0.65,
      height: tileSize * 0.65,
      damage: attack,
      speed: this.speed * (tileSize / 32),
      execute: () {
        Sounds.attackRange();
      },
      destroy: () {
        Sounds.explosion();
      },
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Size(tileSize / 2, tileSize / 2),
          ),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withOpacity(0.4),
      ),
    );
  }

  void execAttack() {
    this.simpleAttackMelee(
      height: tileSize * 0.62,
      width: tileSize * 0.62,
      damage: attack / 3,
      interval: 300,
      animationBottom: EnemySpriteSheet.enemyAttackEffectBottom(),
      animationLeft: EnemySpriteSheet.enemyAttackEffectLeft(),
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      animationTop: EnemySpriteSheet.enemyAttackEffectTop(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void receiveDamage(double damage, dynamic id) {
    this.showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }
}
