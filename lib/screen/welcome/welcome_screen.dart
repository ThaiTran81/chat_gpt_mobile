import 'package:chat_tdt/screen/messages/message_screen.dart';
import 'package:flutter/material.dart';

import '../../components/gradient_text.dart';
import '../../utils/constants.dart';
import '../../repository/share_data_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareDataConfigRepository.initDataConfig(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset("assets/images/welcome.gif"),
              Spacer(flex: 3),
              Text(
                AppLocalizations.of(context).onboarding_title_header,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            GradientText(
              AppLocalizations.of(context).onboarding_title_main_header,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                gradient: LinearGradient(colors: [
                  Colors.purpleAccent,
                  Colors.purpleAccent,
                  Colors.purpleAccent,
                  // Color.fromRGBO(222, 178, 197, 1),
                  Colors.white,
                Colors.white,

              ]),
            ),
              Spacer(),
              Text(
                AppLocalizations.of(context).onboarding_sub_header,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.64),
                ),
              ),
              Spacer(flex: 3),
              FittedBox(
                child: TextButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagesScreen(),
                          ),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context).obboarding_btn_start,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.8),
                                  ),
                        ),
                        SizedBox(width: kDefaultPadding / 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.8),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
