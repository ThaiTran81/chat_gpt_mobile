import 'package:chat_tdt/repository/share_data_repository.dart';
import 'package:chat_tdt/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class SelectLanguageFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.purple.shade900, Colors.black],
          )),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Select Language',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            languageItem(LanguageCode.en.name, context,
                LanguageCode.en.name == ShareDataConfigRepository.languageCode),
            SizedBox(
              height: 5,
            ),
            languageItem(LanguageCode.vi.name, context,
                LanguageCode.vi.name == ShareDataConfigRepository.languageCode),
          ],
        ),
      ),
    );
  }

  Widget languageItem(
      String countryCode, BuildContext context, bool isSelected) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.4),
          side: BorderSide(color: Colors.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(LocaleNames.of(context)?.nameOf(countryCode) ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.white)
        ],
      ),
    );
  }
}
