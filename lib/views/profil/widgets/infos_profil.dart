import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../widgets/app_name.dart';

import '../../../utils/constants_util.dart';

class InfosProfilPopup extends StatefulWidget {
  const InfosProfilPopup({super.key});

  @override
  _LanguagePopupState createState() => _LanguagePopupState();
}

class _LanguagePopupState extends State<InfosProfilPopup> {
  @override
  Widget build(BuildContext context) {
    final userHive = Hive.box(hivedb);
    var nom = userHive.get('nom');
    var prenom = userHive.get('prenom');
    var sexe = userHive.get('sexe');
    var lieu_naiss = userHive.get('lieu_naiss');
    var email = userHive.get('email');
    var tel1 = userHive.get('tel1');
    var tel2 = userHive.get('tel2');
    var ville = userHive.get('ville');
    var adresse = userHive.get('adresse');
    var date_naiss = userHive.get('date_naiss');
    var etablissement = userHive.get('etablissement');
    var annee_acc = userHive.get('annee_acc');
    var formation = userHive.get('formation');
    var code = userHive.get('code');
    var niveau = userHive.get('niveau');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppName(
          fontSize: 19.0,
          school: 'vos.informations'.tr(),
        ),
        backgroundColor: kColorPrimary,
        foregroundColor: kColorLight,
        iconTheme: const IconThemeData(color: kColorLight),
      ),
      body: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'matricule'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: code,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'prenom'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: prenom,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'nom'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: nom,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'sexe'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: sexe,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'date.naissance'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: date_naiss,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'lieu.naissance'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: lieu_naiss,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'telephone1'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: tel1,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'telephone2'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: tel2,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'email'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: email,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'ville'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: ville,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text: 'adresse'.tr(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: adresse,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 3,
              color: Colors.grey[400],
            ),
            Container(
              decoration: const BoxDecoration(
                color: kColorPrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: niveau,
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
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
                          text: niveau == '1' ? 'iere'.tr() : 'ieme'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
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
                          text: 'annee'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
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
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: formation,
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
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
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: annee_acc,
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
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
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: etablissement,
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
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
          ],
        ),
      ),
    );
  }
}
