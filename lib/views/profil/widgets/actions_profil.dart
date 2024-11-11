import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../providers/notification_provider.dart';
import '../../../utils/next_screen.dart';
import 'language_profil.dart';
import '../../../providers/sign_in_provider.dart';
import '../../login/login_view.dart';
import '../../../utils/constants_util.dart';

class ActionsProfil extends StatelessWidget {
  const ActionsProfil({super.key});

  _launchMail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Config().supportEmail,
      queryParameters: {
        'subject': 'A propos de ${Config().appName}Ò',
        'body': ''
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch mail';
    }
  }

  void openLogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'logout_title'.tr(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: kColorDark,
                      fontWeight: FontWeight.w500,
                    ))),

            // const Text('logout_title').tr(),
            actions: [
              TextButton(
                child: RichText(
                    text: TextSpan(
                        text: 'no'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorPrimary,
                          fontWeight: FontWeight.w500,
                        ))),

                // const Text('no').tr(),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: RichText(
                    text: TextSpan(
                        text: 'yes'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorPrimary,
                          fontWeight: FontWeight.w500,
                        ))),

                // const Text('yes').tr(),
                onPressed: () async {
                  Navigator.pop(context);
                  await context
                      .read<SignInProvider>()
                      .userSignout()
                      .then((value) =>
                          context.read<SignInProvider>().afterUserSignOut())
                      .then((value) {
                    nextScreenCloseOthers(context, const LoginView());
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), children: [
      const Divider(
        height: 3,
      ),
      ListTile(
        title: RichText(
            text: TextSpan(
                text: 'get_notifications'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: kColorDark,
                  fontWeight: FontWeight.w500,
                ))),
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(5)),
          child: const Icon(LineIcons.bell, size: 22, color: Colors.white),
        ),
        trailing: Switch(
            activeColor: Theme.of(context).primaryColor,
            value: context.watch<NotificationProvider>().subscribed ?? false,
            onChanged: (bool) {
              context.read<NotificationProvider>().fcmSubscribe(bool);
            }),
      ),
      const Divider(
        height: 3,
      ),
      ListTile(
        title: RichText(
            text: TextSpan(
                text: 'language'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: kColorDark,
                  fontWeight: FontWeight.w500,
                ))),
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.pinkAccent, borderRadius: BorderRadius.circular(5)),
          child: Icon(MdiIcons.web, size: 20, color: Colors.white),
        ),
        trailing: Icon(
          MdiIcons.chevronRight,
          size: 20,
        ),
        onTap: () => {nextScreenPopup(context, const LanguagePopup())},
      ),
      const Divider(
        height: 3,
      ),
      ListTile(
        title: RichText(
            text: TextSpan(
                text: 'logout'.tr(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: kColorDark,
                  fontWeight: FontWeight.w500,
                ))),
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
          child: Icon(MdiIcons.logout, size: 20, color: Colors.white),
        ),
        trailing: Icon(
          MdiIcons.chevronRight,
          size: 20,
        ),
        onTap: () => {openLogoutDialog(context)},
      ),
      const Divider(
        height: 3,
      ),
    ]);
  }
}
