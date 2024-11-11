import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/social_icon.dart';

class SocialLoginWidget extends StatelessWidget {
  final void Function() onTap;
  const SocialLoginWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(
              child: Divider(
                color: Colors.grey,
                endIndent: 20,
              ),
            ),
            Text(
              'social_login'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Expanded(
              child: Divider(
                color: Colors.grey,
                indent: 20,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialIcon(
              colors: const [
                Color(0xff102397),
                Color(0xff187adf),
              ],
              iconData: FontAwesomeIcons.google,
              onPressed: onTap,
            ),
          ],
        ),
      ],
    );
  }
}
