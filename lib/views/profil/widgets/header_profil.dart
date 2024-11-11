import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_webschool_sec/views/profil/widgets/infos_profil.dart';

import '../../../providers/sign_in_provider.dart';
import '../../../utils/constants_util.dart';
import '../../../utils/next_screen.dart';
import '../../login/login_view.dart';

class HeaderProfil extends StatelessWidget {
  final String uid;
  final String title;
  final void Function() onTap;

  const HeaderProfil({
    super.key,
    required this.title,
    required this.onTap,
    required this.uid,
  });

  void openLogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('logout_title').tr(),
            actions: [
              TextButton(
                child: const Text('no').tr(),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('yes').tr(),
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

  Future<String> checkPhoto() async {
    String path = "";
    await Future.delayed(const Duration(seconds: 0));
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    path = appDocumentsDirectory.path;
    bool pfExists = await File('$path/profil.png').exists();
    if (pfExists) {
      return '$path/profil.png';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: checkPhoto(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorSecondaryLight,
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/profil.png',
                  fit: BoxFit.contain,
                  width: 41,
                ),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColorSecondaryLight,
                ),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/profil.png',
                    fit: BoxFit.contain,
                    width: 41,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ]),
                  child: Wrap(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          snapshot.data != ''
                              ? Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColorSecondaryLight,
                                  ),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 32,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          FileImage(File(snapshot.data!)),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kColorSecondaryLight,
                                  ),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/profil.png',
                                      fit: BoxFit.contain,
                                      width: 41,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                              text: title,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                color: kColorLight,
                                fontWeight: FontWeight.w900,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    children: [
                      ListTile(
                          title: RichText(
                              text: TextSpan(
                                  text: 'vos.informations'.tr(),
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
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(MdiIcons.prescription,
                                size: 20, color: Colors.white),
                          ),
                          trailing: Icon(
                            MdiIcons.chevronRight,
                            size: 20,
                          ),
                          onTap: () => {
                                nextScreenPopup(
                                    context, const InfosProfilPopup())
                              }),
                    ],
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
