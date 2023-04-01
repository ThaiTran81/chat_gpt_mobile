import 'package:chat_tdt/screen/welcome/welcome_screen.dart';
import 'package:chat_tdt/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(ChatTDTApp());
}

class ChatTDTApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("settings").listenable(),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        var languageCode = box.get('speechLanguage', defaultValue: 'en');
        return MaterialApp(
          locale: Locale(languageCode),
          supportedLocales: [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
          title: 'Chat TDT',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            LocaleNamesLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: lightThemeData(context),
          home: MainScreen(),
        );
        ;
      },
    );
  }
}
