import 'package:chat_tdt/screen/welcome/welcome_screen.dart';
import 'package:chat_tdt/theme.dart';
import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:chat_tdt/utils/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  runApp(ChatTDTApp());
}

class ChatTDTApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Chat TDT',
      localizationsDelegates: const [
        LocaleNamesLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      home: MainScreen(),
    );
    return materialApp;
  }
}
