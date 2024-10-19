import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_webschool_sec/models/student_model.dart';

import '../utils/constants_util.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    super.key,
  });
  _sendEmail() async {
    final userHive = Hive.box(hivedb);
    final mailtoLink = Mailto(
        to: [userHive.get('semail')],
        cc: [userHive.get('email')],
        subject: 'Demande d\'informations',
        body:
            "Posez-nous votre question ou le problème que vous avez rencontré (vous pouvez joindre une capture d'écran pour nous aider à mieux visualiser le souci).\n\nLes informations ci-dessous nous permettront de mieux vous aider, merci de les laisser dans le corps du mail.\n\nMatricule: ${userHive.get('code')} \nNom : ${userHive.get('lastname')}\nPrénom : ${userHive.get('firstname')}\nFormation : ${userHive.get('formation')}\nContact: ${userHive.get('tel1')}");
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    final userHive = Hive.box(hivedb);
    StudentModel student = StudentModel(
        userHive.get('etablissement'),
        userHive.get('annee_acc'),
        userHive.get('code'),
        userHive.get('lastname'),
        userHive.get('firstname'),
        userHive.get('sexe'),
        userHive.get('date_naiss'),
        userHive.get('lieu_naiss'),
        userHive.get('email'),
        userHive.get('tel1'),
        userHive.get('tel2'),
        userHive.get('adresse'),
        userHive.get('formation'),
        userHive.get('niveau'));

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kColorPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: student.sexe == 'M' ? 'm.'.tr() : 'mme.'.tr(),
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.prenom,
                        style: const TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.nom,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                // RichText(
                //   text: TextSpan(
                //     text: student.prenom,
                //     style: const TextStyle(
                //       fontFamily: 'NunitoSans',
                //       fontSize: 15,
                //       color: kColorLight,
                //       fontWeight: FontWeight.w400,
                //     ),
                //     children: <TextSpan>[
                //       const TextSpan(
                //         text: ' ',
                //         style: TextStyle(
                //           fontFamily: 'Poppins',
                //           fontSize: 14,
                //           color: kColorPrimaryDark,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       TextSpan(
                //         text: student.nom,
                //         style: const TextStyle(
                //           fontFamily: 'Poppins',
                //           fontSize: 15,
                //           color: kColorLight,
                //           fontWeight: FontWeight.w900,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: student.sexe == 'M' ? 'ne.le'.tr() : 'nee.le'.tr(),
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.date_naiss,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'a'.tr().toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.lieu_naiss,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'matricule'.tr(),
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: ': ',
                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.code,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: kColorPrimary,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: student.niveau,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: student.niveau == '1' ? 'iere'.tr() : 'ieme'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorPrimaryDark,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'annee'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: kColorLight,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: student.formation,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: student.annee_acc,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: student.etablissement,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 15,
                      color: kColorLight,
                      fontWeight: FontWeight.w900,
                    ),
                    children: <TextSpan>[],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          ListTile(
            title: RichText(
                text: TextSpan(
                    text: 'contact_us'.tr(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: kColorDark,
                      fontWeight: FontWeight.w500,
                    ))),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(MdiIcons.emailOutline, size: 20, color: Colors.white),
            ),
            trailing: Icon(
              MdiIcons.chevronRight,
              size: 20,
            ),
            onTap: () async {
              _sendEmail();
            },
          ),
          const Divider(
            height: 3,
          ),
          ListTile(
            title: RichText(
                text: TextSpan(
                    text: 'rate_this_app'.tr(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: kColorDark,
                      fontWeight: FontWeight.w500,
                    ))),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(MdiIcons.starOutline, size: 20, color: Colors.white),
            ),
            trailing: Icon(
              MdiIcons.chevronRight,
              size: 20,
            ),
            //onTap: () async => LaunchReview.launch(
            //    androidAppId: Config().androidAppId,
            //    iOSAppId: Config().iOSAppId),
          ),
          const Divider(
            height: 3,
          ),
          ListTile(
            title: RichText(
                text: TextSpan(
                    text: 'about_us'.tr(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: kColorDark,
                      fontWeight: FontWeight.w500,
                    ))),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Icon(MdiIcons.informationOutline,
                  size: 20, color: Colors.white),
            ),
            trailing: Icon(
              MdiIcons.chevronRight,
              size: 20,
            ),
            //onTap: () async {
            // launchURL(context, userHive.get('ssiteweb'));
            // },
          ),
          Divider(),
          // Your bottom footer
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: RichText(
                    text: const TextSpan(
                      text: 'MyWebSchool',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.bold,
                          color: kColorDark),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: '1.0',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
