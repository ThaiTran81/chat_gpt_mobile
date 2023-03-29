import 'package:chat_tdt/models/ChatMessage.dart';
import 'package:dio/dio.dart';

class OpenAIRepository {
  static final dio = Dio();
  static final _API_OPENAI =
      'https://chatgpt-mobile-server.herokuapp.com/api/v1/chat';

  static Future<String> sendMessage(List<ChatMessage> chatMessages) async {
    final response = await dio.post(_API_OPENAI, data: {
      'messages': chatMessages
          .map((e) => {'role': e.chatRole.code, 'content': e.text})
          .toList()
    });
    String res = response.data != null ? response.data['message']['content'] : 'please try again, something wrong';
    return res;
  }
}
