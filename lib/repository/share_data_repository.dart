import 'package:chat_tdt/utils/l10nUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/text_to_speech.dart';

enum SettingKey {
  autoSpeech('autoSpeech'),
  speechLanguage('speechLanguage');


  final String code;
  const SettingKey(this.code);
}

class ShareDataConfigRepository {
  static bool autoSpeech = true;
  static String speechTextLanguage = 'vi-VN';

  static void initDataConfig(BuildContext context) async {
    await Hive.initFlutter();
    var settingBox = await Hive.openBox('settings');
    var messageHistoryBox = await Hive.openBox("messageHistory");

    autoSpeech = settingBox.get("autoSpeech", defaultValue: true);
    if (!context.mounted) return;
    var languageCode = Localizations.localeOf(context).languageCode;
    if (kDebugMode) {
      print(languageCode);
    }
    speechTextLanguage = settingBox.get("speechLanguage", defaultValue: L10nUtils.getLanguageCodeForTtsFrom(languageCode));

    Text2Speech.setUp(TtsLanguageSetting.getFrom(speechTextLanguage));
  }

  static void saveConfig() async{
    var settingBox = await Hive.box('settings');

    settingBox.put(SettingKey.speechLanguage, speechTextLanguage);
    settingBox.put(SettingKey.autoSpeech, autoSpeech);
  }
}