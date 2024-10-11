import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/constants_util.dart';

class UserName extends StatelessWidget {
  final String name;
  UserName({super.key, required this.name});

  final List<String> encouragements = [
    "believe_in_yourself",
    "aim_high",
    "always_persevere",
    "be_bold",
    "strength_and_courage",
    "you_are_capable",
    "go_and_succeed",
    "believe_in_your_dreams",
    "surpass_yourself_every_day",
    "the_future_is_yours",
    "perseverance_and_success",
    "learn_and_grow",
    "spread_your_wings",
    "be_determined",
    "aim_for_excellence",
    "knowledge_is_power",
    "every_day_counts",
    "success_is_waiting",
    "progress_every_day",
    "go_to_the_end"
  ];

  Future<String> checkPhoto() async {
    String path = "";
    await Future.delayed(const Duration(seconds: 0));
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    path = appDocumentsDirectory.path;
    bool pfExists = await File('$path/profil.png').exists();
    if (pfExists) {
      return '$path/profil.png';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomEncouragement =
        encouragements[random.nextInt(encouragements.length)];

    return FutureBuilder<String>(
      future: checkPhoto(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              height: 41,
              alignment: Alignment.center, // This is needed
              child: Image.asset(
                'assets/images/profil.png',
                fit: BoxFit.contain,
                width: 41,
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                height: 41,
                alignment: Alignment.center, // This is needed
                child: Image.asset(
                  'assets/images/profil.png',
                  fit: BoxFit.contain,
                  width: 41,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  snapshot.data != ''
                      ? Container(
                          height: 41,
                          alignment: Alignment.center, // This is needed
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(File(snapshot.data!)),
                          ),
                        )
                      : Container(
                          height: 41,
                          alignment: Alignment.center, // This is needed
                          child: Image.asset(
                            'assets/images/profil.png',
                            fit: BoxFit.contain,
                            width: 41,
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'hello'.tr(),
                            style: const TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                              color: kColorPrimaryDark,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' $name',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: kColorPrimary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(
                                text: ',',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: kColorPrimaryDark,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                  text: TextSpan(
                                text:
                                    // 'how_are_you_today'.tr(),
                                    randomEncouragement.tr(),
                                // "ererer",

                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
