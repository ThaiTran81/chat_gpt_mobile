import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/select_language.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isAutoSpeech = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.purple.shade900, Colors.black],
              )),
              child: body())),
    );
  }


  @override
  void dispose() {
    ShareDataConfigRepository.saveConfig();
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
                      child: Icon(Icons.arrow_back_rounded),
                      onTap: () => Navigator.pop(context),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Settings",
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

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/bot.gif", height: 120),
            buildSettingItem(
                "Language",
                null,
                () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),),
                    context: context,
                    builder: (context) => SelectLanguageFragment())),
            buildSettingItem(
                "Auto play text to speech",
                Switch(
                  activeColor: Colors.purple,
                  value: isAutoSpeech,
                  onChanged: (bool value) {
                    setState(() {
                      isAutoSpeech = value;
                    });
                  },
                ),
                null),
            buildSettingItem("Clear message history", null, () => null)
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem(String title, Widget? child, Function()? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent),
      onPressed: onPressed,
      child: Container(
        // height: 60,
        // margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white.withOpacity(0.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Container(child: child)
          ],
        ),
      ),
    );
  }
}
