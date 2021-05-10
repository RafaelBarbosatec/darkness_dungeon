import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:darkness_dungeon/enemies/mini_boss.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/enemy_sprite_sheet.dart';
import 'package:darkness_dungeon/util/functions.dart';
import 'package:darkness_dungeon/util/game_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/npc_sprite_sheet.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Boss extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 40;

  bool addChild = false;
  bool firstSeePlayer = false;

  List<Enemy> children = [];

  Boss(this.initPosition)
      : super(
          animation: EnemySpriteSheet.bossAnimations(),
          position: initPosition,
          width: tileSize * 1.5,
          height: tileSize * 1.7,
          speed: tileSize / 0.35,
          life: 200,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Size(valueByTileSize(14), valueByTileSize(16)),
            align: Vector2(valueByTileSize(5), valueByTileSize(11)),
          ),
        ],
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    drawBarSummonEnemy(canvas);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    this.timers['addChild']?.update(dt);
    if (!firstSeePlayer) {
      this.seePlayer(
        observed: (p) {
          firstSeePlayer = true;
          gameRef.gameCamera.moveToPositionAnimated(
            Offset(
              this.position.center.dx,
              this.position.center.dy,
            ),
            zoom: 2,
            finish: () {
              _showConversation();
            },
          );
        },
        radiusVision: tileSize * 7,
      );
    }
    this.seePlayer(
      observed: (player) {
        if (children.isEmpty ||
            children.where((e) => !e.isDead).length == 0 &&
                children.length < 3) {
          addChildInMap();
        }
      },
      radiusVision: tileSize * 3,
    );

    if (life < 150 && children.length == 0) {
      addChildInMap();
    }

    if (life < 100 && children.length == 1) {
      addChildInMap();
    }

    if (life < 50 && children.length == 2) {
      addChildInMap();
    }

    this.seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      radiusVision: tileSize * 3,
    );

    super.update(dt);
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.explosion(),
        position: this.position,
      ),
    );
    children.forEach((e) {
      if (!e.isDead) e.die();
    });
    remove();
    super.die();
  }

  void addChildInMap() {
    if (this.timers['addChild'] == null) {
      this.timers['addChild'] = IntervalTick(5000);
    }

    if (!this.timers['addChild'].update(dtUpdate)) return;

    Vector2Rect positionExplosion;

    switch (this.directionThePlayerIsIn()) {
      case Direction.left:
        positionExplosion = this.position.translate(width * -2, 0);
        break;
      case Direction.right:
        positionExplosion = this.position.translate(width * 2, 0);
        break;
      case Direction.up:
        positionExplosion = this.position.translate(0, height * -2);
        break;
      case Direction.down:
        positionExplosion = this.position.translate(0, height * 2);
        break;
      case Direction.upLeft:
        // TODO: Handle this case.
        break;
      case Direction.upRight:
        // TODO: Handle this case.
        break;
      case Direction.downLeft:
        // TODO: Handle this case.
        break;
      case Direction.downRight:
        // TODO: Handle this case.
        break;
    }

    Enemy e = children.length == 2
        ? MiniBoss(
            Vector2(
              positionExplosion.left,
              positionExplosion.top,
            ),
          )
        : Imp(
            Vector2(
              positionExplosion.left,
              positionExplosion.top,
            ),
          );

    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: positionExplosion,
      ),
    );

    children.add(e);
    gameRef.addGameComponent(e);
  }

  void execAttack() {
    this.simpleAttackMelee(
      height: tileSize * 0.62,
      width: tileSize * 0.62,
      damage: attack,
      interval: 1500,
      attackEffectBottomAnim: EnemySpriteSheet.enemyAttackEffectBottom(),
      attackEffectLeftAnim: EnemySpriteSheet.enemyAttackEffectLeft(),
      attackEffectRightAnim: EnemySpriteSheet.enemyAttackEffectRight(),
      attackEffectTopAnim: EnemySpriteSheet.enemyAttackEffectTop(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void receiveDamage(double damage, dynamic id) {
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

  void drawBarSummonEnemy(Canvas canvas) {
    if (position == null) return;
    double yPosition = position.top;
    double widthBar = (width - 10) / 3;
    if (children.length < 1)
      canvas.drawLine(
          Offset(position.left, yPosition),
          Offset(position.left + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    double lastX = position.left + widthBar + 5;
    if (children.length < 2)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);

    lastX = lastX + widthBar + 5;
    if (children.length < 3)
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
  }

  void _showConversation() {
    Sounds.interaction();
    TalkDialog.show(gameRef.context, [
      Say(
        getString('talk_kid_1'),
        CustomSpriteAnimationWidget(
          animation: NpcSpriteSheet.kidIdleLeft(),
        ),
        personDirection: PersonDirection.RIGHT,
      ),
      Say(
        getString('talk_boss_1'),
        CustomSpriteAnimationWidget(
          animation: EnemySpriteSheet.bossIdleRight(),
        ),
        personDirection: PersonDirection.LEFT,
      ),
      Say(
        getString('talk_player_3'),
        CustomSpriteAnimationWidget(
          animation: PlayerSpriteSheet.idleRight(),
        ),
        personDirection: PersonDirection.LEFT,
      ),
      Say(
        getString('talk_boss_2'),
        CustomSpriteAnimationWidget(
          animation: EnemySpriteSheet.bossIdleRight(),
        ),
        personDirection: PersonDirection.RIGHT,
      ),
    ], finish: () {
      Sounds.interaction();
      addInitChild();
      Future.delayed(Duration(milliseconds: 500), () {
        gameRef.gameCamera.moveToPlayerAnimated();
        Sounds.playBackgroundBoosSound();
      });
    }, onChangeTalk: (index) {
      Sounds.interaction();
    });
  }

  void addInitChild() {
    addImp(position.left - tileSize, position.top - tileSize);
    addImp(position.left - tileSize, position.bottom + tileSize);
  }

  void addImp(double x, double y) {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: Rect.fromLTWH(x, y, 32, 32).toVector2Rect(),
      ),
    );
    gameRef.addGameComponent(Imp(
      Vector2(x, y),
    ));
  }
}
