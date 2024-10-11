import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants_util.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Text(
                'already_a_member'.tr(),
                style: const TextStyle(
                  color: kColorDarkBlue,
                  fontSize: 12,
                  fontFamily: 'NunitoSans',
                ),
              ),
            ),
            const Text(' '),
            InkWell(
              borderRadius: BorderRadius.circular(2),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.login);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: Text(
                  'login'.tr(),
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
      ),
    );
  }
}
