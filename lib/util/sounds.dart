import 'package:bonfire/bonfire.dart';

class Sounds {
  static void attackPlayerMelee() {
    Flame.audio.play('attack_player.mp3', volume: 0.4);
  }

  static void attackRange() {
    Flame.audio.play('attack_fire_ball.wav', volume: 0.3);
  }

  static void attackEnemyMelee() {
    Flame.audio.play('attack_enemy.mp3', volume: 0.4);
  }

  static void explosion() {
    Flame.audio.play('explosion.wav');
  }
}
