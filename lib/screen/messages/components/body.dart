import 'package:chat_tdt/screen/messages/message_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/ChatMessage.dart';
import '../../../utils/constants.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  MessageScreenProvider provider;

  Body(this.provider);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MessageScreenProvider>(context);

    var listView = ListView.builder(
      controller: provider.scrollController,
      itemCount: provider.getMessageHistoryLength()+1,
      itemBuilder: (context, index) {
        if (index == provider.getMessageHistoryLength()) {
          return SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          );
        }
        return Message(message: provider.messageHistory[index]);
      }
    );


    var mainWidget = SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: listView,
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
    return mainWidget;
  }

}
