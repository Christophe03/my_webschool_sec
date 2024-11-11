import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_sec/views/welcome/widgets/user_name.dart';

import '../../utils/constants_util.dart';
import '../../widgets/page_title.dart';
import 'widgets/actions_profil.dart';
import 'widgets/header_profil.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  @override
  void initState() {
    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final userHive = Hive.box(hivedb);
    print(userHive.toMap());
    print(userHive);
    var userid = userHive.get('uid');
    var sid = userHive.get('sid');
    print(userid);
    var userName = user?.displayName ?? 'Nom inconnu';
    print(userName); // Affiche le nom de l'utilisateur ou 'Nom inconnu'

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(
          fontSize: 19.0,
          title: 'mon_profil'.tr(),
        ),
        backgroundColor: kColorPrimary,
        foregroundColor: kColorLight,
        centerTitle: true,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderProfil(
            uid: userid,
            title: userName,
            onTap: () {},
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(5),
            child: const ActionsProfil(),
          ))
        ],
      ),
    );
  }
}
