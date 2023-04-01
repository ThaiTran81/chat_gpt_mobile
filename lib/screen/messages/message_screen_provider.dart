import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_tdt/generated/l10n.dart';
import 'package:chat_tdt/repository/chat_message_repository.dart';
import 'package:chat_tdt/repository/openai_repository.dart';
import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/ChatMessage.dart';

class MessageScreenProvider extends ChangeNotifier {
  ChatMessageRepository chatMessageRepository = ChatMessageRepository.instance;
  List<ChatMessage> messageHistory = List.empty(growable: true);
  String? currentMessageSpeech;
  ChatMessage? lastChatMessage;
  final ScrollController _scrollController = ScrollController();
  late BuildContext _context;
  var audioPlayer = AssetsAudioPlayer.newPlayer();
  bool isProcessing = false;

  ScrollController get scrollController => _scrollController;

  MessageScreenProvider(this._context) {
    chatMessageRepository.getChatMessageHistory().then((value) {
      messageHistory = value;
      messageHistory.sort(
        (a, b) {
          return a.createdTime.compareTo(b.createdTime);
        },
      );
      notifyListeners();
    });
  }

  void addMessage(ChatMessage chatMessage) {
    messageHistory.add(chatMessage);
    lastChatMessage = chatMessage;
    notifyListeners();
    Timer(Duration(milliseconds: 100), () => _scrollDown());
    chatMessageRepository.save(chatMessage);
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendUserMessage(String content) async {
    var message = ChatMessage(
        chatRole: ChatRole.USER.code, isSender: true, text: content);
    addMessage(message);
    audioPlayer.open(Audio("assets/sounds/typing.mp3"),
        autoStart: true,
        showNotification: true,
        loopMode: LoopMode.single,
        volume: 1);

    setIsProcessing(true);
    OpenAIRepository.sendMessage(messageHistory).then((value) {
      ChatMessage chatMessage = addAssistantMessage(value);
      if (ShareDataConfigRepository.autoSpeech) {
        setCurrentMessage(chatMessage.id);
      }
      audioPlayer.stop();
      setIsProcessing(false);
    }, onError: (e) {
      print(e);
      ChatMessage chatMessage = addAssistantMessage(
          AppLocalizations.of(_context).message_err_unexpected);
      if (ShareDataConfigRepository.autoSpeech) {
        setCurrentMessage(chatMessage.id);
      }
      audioPlayer.stop();
      setIsProcessing(false);
    });
  }

  int getMessageHistoryLength() {
    return messageHistory.length;
  }

  ChatMessage addAssistantMessage(String content) {
    var chatMessage = ChatMessage(
        chatRole: ChatRole.ASSISTANT.code, isSender: false, text: content);
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

  void clearMessageHistory() {
    chatMessageRepository.deleteAll();
    messageHistory.clear();
    notifyListeners();
  }

  void refreshMessageHisory() async {
    messageHistory = await chatMessageRepository.getChatMessageHistory();
    messageHistory.sort(
      (a, b) {
        return a.createdTime.compareTo(b.createdTime);
      },
    );
    notifyListeners();
  }

  void setIsProcessing(bool value) {
    isProcessing = value;
    notifyListeners();
  }
}