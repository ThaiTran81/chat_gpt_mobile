import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/chat_message_repository.dart';

class SettingScreenProvider extends ChangeNotifier {
  ChatMessageRepository chatMessageRepository = ChatMessageRepository.instance;

  String toastMessage = '';

  bool autoSpeech = ShareDataConfigRepository.autoSpeech;

  String selectedLaguage = ShareDataConfigRepository.speechTextLanguage;

  void clearMessageHistory() async {
    chatMessageRepository.deleteAll();
    toastMessage = 'Clear all messages successfully';
    notifyListeners();
  }

  void setAutoSpeech(bool value) {
    ShareDataConfigRepository.setAutoSpeech(value);
    autoSpeech = value;
    notifyListeners();
  }

  void changeLanguageCodeTo(String languageCode) {
    ShareDataConfigRepository.setLanguageCode(languageCode);
    selectedLaguage = languageCode;
  }
}
