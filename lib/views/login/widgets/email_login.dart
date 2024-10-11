import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/constants_util.dart';

class EmailLogin extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final void Function() onTap;
  const EmailLogin({super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: () => onTap(),
      width: MediaQuery.of(context).size.width * 0.80,
      color: kColorPrimary,
      elevation: 0,
      borderRadius: 3,
      child: Wrap(
        children: [
          const Text(
            'login',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ).tr()
        ],
      ),
    );
  }
}
