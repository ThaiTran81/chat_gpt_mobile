import 'package:chat_tdt/utils/l10nUtils.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../repository/share_data_repository.dart';


enum TtsLanguageSetting {
  vi_VN(
      languageCode: L10nUtils.VN_TTS,
      speechRate: 0.8,
      speechVolume: 1,
      speechPitch: 1),
  en_US(
      languageCode: L10nUtils.EN_TTS,
      speechRate: 0.5,
      speechVolume: 1,
      speechPitch: 1);

  final double speechVolume;
  final double speechPitch;
  final double speechRate;
  final String languageCode;

  const TtsLanguageSetting(
      {required this.languageCode,
      required this.speechVolume,
      this.speechPitch = 1,
      required this.speechRate});

  static TtsLanguageSetting getFrom(String ttsLanguageCode) {
    switch (ttsLanguageCode) {
      case L10nUtils.VN_TTS:
        return TtsLanguageSetting.vi_VN;
      case L10nUtils.EN_TTS:
      default:
        return TtsLanguageSetting.en_US;
    }
  }
}

class Text2Speech {
  static final FlutterTts tts = FlutterTts();
  static bool playing = false;

  static void setUp(TtsLanguageSetting languageSetting) async {
    await tts.setLanguage(languageSetting.languageCode);
    await tts.setVolume(languageSetting.speechVolume);
    await tts.setSpeechRate(languageSetting.speechRate);
    await tts.setPitch(languageSetting.speechPitch);
  }

  static Future speak(String text) async {
    if (text.isEmpty) {
      return;
    }
    var result = await tts.speak(text);
    if (result == 1) {
      playing = true;
    }
  }

  static Future stop() async {
    var result = await tts.stop();
    if (result == 1) {
      playing = false;
    }
  }

  static bool isPlaying() {
    return playing;
  }
}