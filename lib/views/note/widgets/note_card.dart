import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_webschool_sec/utils/string_util.dart';

import '../../../models/note_model.dart';
import '../../../utils/constants_util.dart';

class NoteCard extends StatelessWidget {
  final List<NoteModel> snapshot;
  const NoteCard({super.key, required this.snapshot});

  getEvals(tab) {
    String s = "";
    List<dynamic> jsonArray = json.decode(tab);
    for (var jsonMap in jsonArray) {
      s = "$s${jsonMap['note']}/${jsonMap['base']} (${jsonMap['type']}), ";
    }
    if (s.endsWith(", ")) {
      s = s.substring(0, s.length - 2);
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...snapshot.map((NoteModel tab) {
          return ListTile(
            leading: RichText(
              text: TextSpan(
                text: formatDoubleToString(tab.moyenne!, decimalPlaces: 2),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: kColorPrimary),
                children: <TextSpan>[
                  const TextSpan(
                    text: " / ",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: kColorPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: tab.moyennebase.toString(),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: kColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            title: RichText(
                // textAlign: TextAlign.end,
                text: TextSpan(
              text: tab.matiere!.toCapitalized(),
              style: const TextStyle(
                color: kColorDark,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    // textAlign: TextAlign.end,
                    text: TextSpan(
                        text: getEvals(tab.notes!),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kColorDark))),
              ],
            ),
            trailing: Column(
              children: [
                RichText(
                    // textAlign: TextAlign.end,
                    text: TextSpan(
                        text: "Crédits",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: kColorDark,
                          fontWeight: FontWeight.w500,
                        ))),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    // textAlign: TextAlign.end,
                    text: TextSpan(
                        text: tab.credit.toString(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: kColorPrimary))),
              ],
            ),
          );
        }).toList()
      ],
    );
  }
}
