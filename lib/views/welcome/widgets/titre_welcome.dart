import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants_util.dart';

class TitreWelcome extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const TitreWelcome({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, top: 5, bottom: 0, right: 2),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 23,
                  width: 4,
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 6,
                ),
                RichText(
                    text: TextSpan(
                        text: title.tr(),
                        style: const TextStyle(
                            color: kColorDark,
                            fontSize: 22,
                            letterSpacing: -0.6,
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold))),
                const Spacer(),
                TextButton(
                  onPressed: onPressed,
                  child: RichText(
                      text: TextSpan(
                    text: 'view_all'.tr(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark),
                  )),
                )
              ]),
        )
      ]),
    );
  }
}
