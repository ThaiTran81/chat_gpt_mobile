

class L10nUtils {
  static const VN_TTS = 'vi-VN';
  static const EN_TTS = 'en-US';

  static String getLanguageCodeForTtsFrom(String languageCode) {
    switch(languageCode) {
      case 'vi':
        return VN_TTS;
      case 'en':
      default:
        return EN_TTS;
    }
  }
}