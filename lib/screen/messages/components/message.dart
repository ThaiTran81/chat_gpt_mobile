import 'package:flutter/material.dart';

import '../../../models/ChatMessage.dart';
import '../../../utils/constants.dart';
import 'text_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
          return TextMessage(message: message);
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: (message.isSender != null && message.isSender)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/bot.gif"),
            ),
            const SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
        ],
      ),
    );
  }
}

