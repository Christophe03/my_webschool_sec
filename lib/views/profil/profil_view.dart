import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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

  @override
  Widget build(BuildContext context) {
    final userHive = Hive.box(hivedb);
    var userid = userHive.get('uid');
    var userName = userHive.get('name');

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
