import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class GoogleLogin extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final void Function() onTap;
  const GoogleLogin({super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedLoadingButton(
            controller: controller,
            onPressed: () => onTap(),
            width: MediaQuery.of(context).size.width * 0.80,
            color: Colors.blueAccent,
            elevation: 0,
            child: Wrap(
              children: [
                const Icon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Sign In with Google',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ).tr()
              ],
            ),
            //borderRadius: 3,
          ),
        ],
      ),
    );
  }
}
