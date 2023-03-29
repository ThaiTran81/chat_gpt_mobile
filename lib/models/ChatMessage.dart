import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

enum ChatRole {
  ASSISTANT(code: 'assistant'),
  USER(code: 'user');
  final String code;

  const ChatRole({required this.code});
}

  class ChatMessage {
  static final Uuid uuid  = Uuid();
  final String? id = uuid.v1();
  final String text;
  final ChatRole chatRole;
  MessageStatus? messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.chatRole,
    this.messageStatus,
    required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    chatRole: ChatRole.ASSISTANT,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    chatRole: ChatRole.USER,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  )
];
