import 'package:chat_tdt/repository/chat_message_repository.dart';
import 'package:chat_tdt/utils/constants.dart';
import 'package:chat_tdt/utils/l10nUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/ChatMessage.dart';
import '../utils/text_to_speech.dart';

enum SettingKey {
  autoSpeech('autoSpeech'),
  speechLanguage('speechLanguage'),
  languageCode('languageCode');

  final String code;

  const SettingKey(this.code);
}

class ShareDataConfigRepository {
  static bool autoSpeech = true;
  static String speechTextLanguage = 'vi-VN';
  static String languageCode = LanguageCode.en.name;

  static void initDataConfig(BuildContext context) async {
    await Hive.initFlutter();
    ChatMessageRepository.instance.init();
    var settingBox = await Hive.openBox('settings');
    var messageHistoryBox = await Hive.openBox("messageHistory");

    autoSpeech = settingBox.get("autoSpeech", defaultValue: true);
    if (!context.mounted) return;
    languageCode = Localizations.localeOf(context).languageCode;
    if (kDebugMode) {
      print(languageCode);
    }
    speechTextLanguage = settingBox.get("speechLanguage",
        defaultValue: L10nUtils.getLanguageCodeForTtsFrom(languageCode));

    Text2Speech.setUp(TtsLanguageSetting.getFrom(speechTextLanguage));
  }

  static void saveConfig() async {
    var settingBox = Hive.box('settings');

    settingBox.put(SettingKey.speechLanguage.code, speechTextLanguage);
    settingBox.put(SettingKey.autoSpeech.code, autoSpeech);
  }

  static void setAutoSpeech(bool value) {
    autoSpeech = value;
  }
}