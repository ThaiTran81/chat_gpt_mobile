import 'package:chat_tdt/models/ChatMessage.dart';
import 'package:chat_tdt/screen/messages/message_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import '../../../utils/constants.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final String _nonclick_mic_ic = 'assets/icons/assistant_ic.gif';
  final String _click_mic_ic = 'assets/icons/click_assistant_ic.gif';
  bool _isSpeechListening = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  var _txtInputController = TextEditingController();
  late MessageScreenProvider provider;

  @override
  void initState() {
    super.initState();
    _isSpeechListening = false;
    _initSpeech();
  }

  /// init speech to text
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: (level) {
        print(level.abs());
      },
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isSpeechListening = false;
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    var recognizedWords = result.recognizedWords;

    setState(() {
      _txtInputController.text = recognizedWords;
    });

    if (_speechToText.isNotListening) {
      setState(() {
        _isSpeechListening = false;
        _txtInputController.text = '';
      });
      _submitInputValue(recognizedWords, provider);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MessageScreenProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                SizedBox(width: kDefaultPadding / 4),
                Expanded(
                  child: TextField(
                    controller: _txtInputController,
                    onSubmitted: (value) {
                      _submitInputValue(value, provider);
                    },
                    decoration: InputDecoration(
                      hintText: "Type message",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _submitInputValue(_txtInputController.text, provider);
                    },
                    icon: Icon(Icons.send_rounded))
              ],
            ),
          ),
          SizedBox(width: kDefaultPadding),
          InkWell(
            onTap: () {
              print(_speechToText.isNotListening);
              _speechToText.isNotListening ? _startListening : _stopListening;
              setState(() {
                _isSpeechListening = !_isSpeechListening;
                if (!_isSpeechListening) {
                  _stopListening();
                } else {
                  _startListening();
                }
              });
            },
            child: Image.asset(
              _isSpeechListening ? _click_mic_ic : _nonclick_mic_ic,
              height: 60,
            ),
          )
        ],
      ),
    );
  }

  void _submitInputValue(String dataInput, MessageScreenProvider provider) {
    if (dataInput.isEmpty) return;
    clearInputData();
    provider.sendUserMessage(dataInput);
  }

  void clearInputData() {
    _txtInputController.text = '';
  }
}
