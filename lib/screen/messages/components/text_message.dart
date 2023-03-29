import 'package:chat_tdt/screen/messages/message_screen_provider.dart';
import 'package:chat_tdt/utils/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/ChatMessage.dart';
import '../../../utils/constants.dart';

class TextMessage extends StatefulWidget {
  TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  State<TextMessage> createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController playTextController;
  late bool isSpeaking;

  @override
  void initState() {
    super.initState();
    playTextController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    isSpeaking = false;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MessageScreenProvider>(context);
    var chatMessage = widget.message;

    handleSpeakMessage(provider);

    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width * 0.75,
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(chatMessage!.isSender ? 1 : 0.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                chatMessage!.text,
                style: TextStyle(
                  color: chatMessage!.isSender ? Colors.black : Colors.white,
                ),
                maxLines: 100,
              ),
            ),
            if (!chatMessage.isSender)
              InkWell(
                child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: playTextController),
                onTap: () {
                  if (provider.currentMessageSpeech == chatMessage.id) {
                    provider.setCurrentMessage(null);
                  } else {
                    provider.setCurrentMessage(chatMessage.id);
                  }
                },
              )
          ]),
        ),
      ),
    );
  }

  void handleSpeakMessage(MessageScreenProvider provider) async {
    if (provider.currentMessageSpeech == null) {
      await Text2Speech.tts.stop();
      playTextController.reset();
    }

    var chatMessage = widget.message;

    Text2Speech.tts.setCompletionHandler(() {
      provider.setCurrentMessage(null);
    });

    if (provider.currentMessageSpeech == chatMessage?.id) {
      playTextController.forward(from: 2);
      await Text2Speech.tts.speak(chatMessage!.text);
    } else {
      playTextController.reset();
    }
  }
}
