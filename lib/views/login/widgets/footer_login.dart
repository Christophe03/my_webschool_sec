import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants_util.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Text(
              'dont_have_an_account'.tr(),
              style: const TextStyle(
                color: kColorDarkBlue,
                fontSize: 12,
                fontFamily: 'NunitoSans',
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(2),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.signup);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Text(
                'register_now'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kColorPrimary,
                  fontSize: 13,
                  fontFamily: 'NunitoSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
