import 'package:bonfire/bonfire.dart';

class Sounds {
  static bool isLoadAudio = false;
  static void initialize() {
    Flame.bgm.initialize();
    if (!isLoadAudio) {
      isLoadAudio = true;
      Flame.audio.loadAll([
        'attack_player.mp3',
        'attack_fire_ball.wav',
        'attack_enemy.mp3',
        'explosion.wav',
        'sound_interaction.wav',
      ]);
    }
  }

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

  static void interaction() {
    Flame.audio.play('sound_interaction.wav', volume: 0.4);
  }

  static stopBackgroundSound() {
    return Flame.bgm.stop();
  }

  static void playBackgroundSound() async {
    Flame.bgm.stop();
    Flame.bgm.play('sound_bg.mp3');
  }

  static void playBackgroundBoosSound() {
    Flame.bgm.play('battle_boss.mp3');
  }

  static void pauseBackgroundSound() {
    Flame.bgm.pause();
  }

  static void resumeBackgroundSound() {
    Flame.bgm.resume();
  }

  static void dispose() {
    Flame.bgm.dispose();
  }
}
