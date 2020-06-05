import 'package:audioplayers/audioplayers.dart';
import 'package:bonfire/bonfire.dart';

class Sounds {
  static AudioPlayer audioBackground;
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

  static Future<int> stopBackgroundSound() async {
    if (audioBackground != null) {
      int result = await audioBackground.stop();
      audioBackground = null;
      return Future.value(result);
    } else {
      return Future.value(0);
    }
  }

  static void playBackgroundSound() {
    stopBackgroundSound().then((resp) {
      Flame.audio
          .loopLongAudio('sound_bg.mp3', volume: 0.6)
          .then((audioPlayer) {
        audioBackground = audioPlayer;
      });
    });
  }

  static void playBackgroundBoosSound() {
    stopBackgroundSound().then((resp) {
      Flame.audio
          .loopLongAudio('battle_boss.mp3', volume: 0.6)
          .then((audioPlayer) {
        audioBackground = audioPlayer;
      });
    });
  }
}
