import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../utils/constants_util.dart';
import '../../../widgets/app_name.dart';

class LanguagePopup extends StatefulWidget {
  const LanguagePopup({super.key});

  @override
  _LanguagePopupState createState() => _LanguagePopupState();
}

class _LanguagePopupState extends State<LanguagePopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppName(
          fontSize: 19.0,
          school: 'select_language'.tr(),
        ),
        backgroundColor: kColorPrimary,
        foregroundColor: kColorLight,
        iconTheme: const IconThemeData(color: kColorLight),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: Config().languages.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(Config().languages[index], index);
        },
      ),
    );
  }

  Widget _itemList(d, index) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: RichText(
              text: TextSpan(
                  text: d,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: kColorDark,
                    fontWeight: FontWeight.w500,
                  ))),
          // Text(d),
          onTap: () async {
            if (d == 'Français') {
              context.locale = const Locale('fr');
            } else if (d == 'English') {
              context.locale = const Locale('en');
            } /*else if (d == 'Arabic') {
              context.locale = Locale('ar');
            }*/
            // else if(d == 'your_language_name'){
            //   context.locale = Locale('your_language_code');
            // }
            Navigator.pop(context);
          },
        ),
        Divider(
          height: 3,
          color: Colors.grey[400],
        )
      ],
    );
  }
}
