import 'package:chat_tdt/screen/messages/message_screen_provider.dart';
import 'package:chat_tdt/screen/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return MessageScreenProvider();
      },
      child: Consumer<MessageScreenProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: buildAppBar(context),
            body: Center(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.purple,
                        Colors.purple.shade900,
                        Colors.black
                      ],
                    )),
                    child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Body(provider),
                    ))),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3)),
                    child: InkWell(
                      child:
                          Image.asset("assets/icons/setting.png", height: 24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingScreen(),
                          ),
                        );
                      },
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Suri Bot",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
