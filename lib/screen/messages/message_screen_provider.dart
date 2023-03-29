import 'dart:async';

import 'package:chat_tdt/models/Chat.dart';
import 'package:chat_tdt/repository/openai_repository.dart';
import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:chat_tdt/utils/text_to_speech.dart';
import 'package:flutter/cupertino.dart';

import '../../models/ChatMessage.dart';

class MessageScreenProvider extends ChangeNotifier {
  List<ChatMessage> messageHistory = List.empty(growable: true);
  String? currentMessageSpeech;
  ChatMessage? lastChatMessage;
  ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  void addMessage(ChatMessage chatMessage) {
    messageHistory.add(chatMessage);
    lastChatMessage = chatMessage;
    notifyListeners();
    Timer(Duration(milliseconds: 100), () => _scrollDown());
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendUserMessage(String content) async {
    addMessage(ChatMessage(chatRole: ChatRole.USER, isSender: true, text: content));
    OpenAIRepository.sendMessage(messageHistory).then((value) {
      ChatMessage chatMessage = addAssistantMessage(value);
      if (ShareDataConfigRepository.autoSpeech) {
        setCurrentMessage(chatMessage.id);
      }
    }, onError: (e) {
      print(e);
    });
  }

  int getMessageHistoryLength() {
    return messageHistory.length;
  }

  ChatMessage addAssistantMessage(String content) {
    var chatMessage = ChatMessage(chatRole: ChatRole.ASSISTANT, isSender: false, text: content);
    addMessage(chatMessage);
    return chatMessage;
  }

  void startSpeechMessage(String? msgId) {
    setCurrentMessage(msgId);
  }

  void stopSpeechMessage() {
    setCurrentMessage(null);
  }

  void setCurrentMessage(String? msgId) {
    currentMessageSpeech = msgId;
    notifyListeners();
  }

}