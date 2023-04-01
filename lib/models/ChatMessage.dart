import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'ChatMessage.g.dart';

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

enum ChatRole {
  ASSISTANT(code: 'assistant'),
  USER(code: 'user');

  final String code;

  const ChatRole({required this.code});
}

final Uuid uuid = Uuid();

@HiveType(typeId: 1)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String id = uuid.v1();

  @HiveField(1)
  String text;

  @HiveField(2)
  String chatRole;

  @HiveField(3)
  bool isSender;

  @HiveField(4)
  DateTime createdTime = DateTime.now();

  ChatMessage({
    this.text = '',
    required this.chatRole,
    required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    chatRole: ChatRole.ASSISTANT.code,
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    chatRole: ChatRole.USER.code,
    isSender: true,
  )
];
