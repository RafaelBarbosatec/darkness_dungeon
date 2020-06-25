import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/decoration/door.dart';
import 'package:darkness_dungeon/decoration/key.dart';
import 'package:darkness_dungeon/decoration/potion_life.dart';
import 'package:darkness_dungeon/decoration/spikes.dart';
import 'package:darkness_dungeon/decoration/torch.dart';
import 'package:darkness_dungeon/enemies/boss.dart';
import 'package:darkness_dungeon/enemies/goblin.dart';
import 'package:darkness_dungeon/enemies/imp.dart';
import 'package:darkness_dungeon/enemies/mini_boss.dart';
import 'package:darkness_dungeon/interface/knight_interface.dart';
import 'package:darkness_dungeon/main.dart';
import 'package:darkness_dungeon/npc/kid.dart';
import 'package:darkness_dungeon/npc/wizard_npc.dart';
import 'package:darkness_dungeon/player/knight.dart';
import 'package:darkness_dungeon/util/dialogs.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game>
    with WidgetsBindingObserver
    implements GameListener {
  bool showGameOver = false;

  GameController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = GameController()..setListener(this);
    Sounds.playBackgroundSound();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Sounds.resumeBackgroundSound();
        break;
      case AppLifecycleState.inactive:
        Sounds.pauseBackgroundSound();
        break;
      case AppLifecycleState.paused:
        Sounds.pauseBackgroundSound();
        break;
      case AppLifecycleState.detached:
        Sounds.stopBackgroundSound();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    tileSize = ((sizeScreen.height < sizeScreen.width)
            ? sizeScreen.height
            : sizeScreen.width) /
        9;
    tileSize = tileSize.roundToDouble();

    return BonfireTiledWidget(
      gameController: _controller,
      joystick: Joystick(
        directional: JoystickDirectional(
          spriteBackgroundDirectional: Sprite('joystick_background.png'),
          spriteKnobDirectional: Sprite('joystick_knob.png'),
          size: 100,
          isFixed: false,
        ),
        actions: [
          JoystickAction(
            actionId: 0,
            sprite: Sprite('joystick_atack.png'),
            spritePressed: Sprite('joystick_atack_selected.png'),
            size: 80,
            margin: EdgeInsets.only(bottom: 50, right: 50),
          ),
          JoystickAction(
            actionId: 1,
            sprite: Sprite('joystick_atack_range.png'),
            spritePressed: Sprite('joystick_atack_range_selected.png'),
            size: 50,
            margin: EdgeInsets.only(bottom: 50, right: 160),
          )
        ],
      ),
      player: Knight(
        initPosition: Position(2 * tileSize, 3 * tileSize),
      ),
      tiledMap: TiledWorldMap(
        'tiled/map.json',
        forceTileSize: tileSize,
      )
        ..registerObject('door',
            (x, y, width, height) => Door(Position(x, y), width, height))
        ..registerObject(
            'torch', (x, y, width, height) => Torch(Position(x, y)))
        ..registerObject(
            'potion', (x, y, width, height) => PotionLife(Position(x, y), 30))
        ..registerObject(
            'wizard', (x, y, width, height) => WizardNPC(Position(x, y)))
        ..registerObject(
            'spikes', (x, y, width, height) => Spikes(Position(x, y)))
        ..registerObject(
            'key', (x, y, width, height) => DoorKey(Position(x, y)))
        ..registerObject('kid', (x, y, width, height) => Kid(Position(x, y)))
        ..registerObject('boss', (x, y, width, height) => Boss(Position(x, y)))
        ..registerObject(
            'goblin', (x, y, width, height) => Goblin(Position(x, y)))
        ..registerObject('imp', (x, y, width, height) => Imp(Position(x, y)))
        ..registerObject(
            'mini_boss', (x, y, width, height) => MiniBoss(Position(x, y)))
        ..registerObject('torch_empty',
            (x, y, width, height) => Torch(Position(x, y), empty: true)),
      interface: KnightInterface(),
      lightingColorGame: Colors.black.withOpacity(0.6),
      background: BackgroundColorGame(Colors.grey[900]),
    );
  }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Game()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player.isDead) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
}
