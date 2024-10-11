import 'package:flutter/material.dart';
import 'package:my_webschool_sec/models/timesheet_model.dart';
import 'package:my_webschool_sec/utils/constants_util.dart';
import 'package:my_webschool_sec/utils/string_util.dart';

import 'timesheet_card_item.dart';

class TimesheetCard extends StatelessWidget {
  final int index;
  final DateTime date;
  final List<TimeSheetModel> cours;
  String? jour;
  TimesheetCard(
      {super.key,
      required this.index,
      required this.date,
      required this.cours,
      this.jour});

  // final List<String> items = List.generate(5, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    // print(items);
    if (jour != null) {
      return Material(
        // elevation: 2,
        child: cours.isEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: kColorPrimary),
                    child: Column(
                      children: [
                        // Text(
                        //   jour ?? "e",
                        //   style: TextStyle(fontSize: 15, color: Colors.white),
                        // ),
                        RichText(
                            text: TextSpan(
                          text: jour ?? '',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 20, bottom: 20, right: 0),
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Aucun cours prévu.',
                              style:
                                  TextStyle(color: kColorDark, fontSize: 22))),

                      // Text('Aucun cours prévu.'),
                    ),
                  ))
                ],
              )
            // return

            : Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: kColorPrimary),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: jour ?? ' ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...cours.map((TimeSheetModel tab) {
                    return TimesheetCardItem(cour: tab);
                  })
                ],
              ),
      );
    } else {
      if (cours.isEmpty) {
        return Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: jour ??
                        formatDateTime(date, 'EEEE dd MMMM yyyy', context)
                            .toCapitalized(),
                    style: TextStyle(color: kColorDark, fontSize: 20))),
            const SizedBox(
              height: 5,
            ),
            Center(
                child: Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 30, bottom: 0, right: 0),
              child: Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Aucun cours prévu.',
                        style: TextStyle(color: kColorDark, fontSize: 22))),
              ),
            ))
          ],
        );
        // return
      } else {
        return Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: jour ??
                        formatDateTime(date, 'EEEE dd MMMM yyyy', context)
                            .toCapitalized(),
                    style: TextStyle(color: kColorDark, fontSize: 20))),
            const SizedBox(
              height: 5,
            ),
            ...cours.map((TimeSheetModel tab) {
              return TimesheetCardItem(cour: tab);
            })
          ],
        );
      }
    }
  }
}
