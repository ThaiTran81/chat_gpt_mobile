import 'package:chat_tdt/models/ChatMessage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class ChatMessageRepository {
  static final ChatMessageRepository instance = _getInstance();
  static const String name = "chatHistory";

  var chatMessagebox;

  ChatMessageRepository();

  static ChatMessageRepository _getInstance() {
    var chatMessageRepository = ChatMessageRepository();
    return chatMessageRepository;
  }

  void init() async {
    if (!Hive.isAdapterRegistered(ChatMessageAdapter.ID)) {
      Hive.registerAdapter(ChatMessageAdapter());
    }
    chatMessagebox = await Hive.openBox<ChatMessage>(name);
  }

  Future<List<ChatMessage>> getChatMessageHistory() async {
    var list = chatMessagebox.values.toList();
    return list;
  }

  void saveAll(List<ChatMessage> chatMessages) async {
    for (var chatMessage in chatMessages) {
      chatMessagebox.put(chatMessage.id, chatMessage);
    }
  }

  void save(ChatMessage chatMessage) async {
    chatMessagebox.put(chatMessage.id, chatMessage);
  }

  void deleteAll() async {
    await chatMessagebox.clear();
  }
}
