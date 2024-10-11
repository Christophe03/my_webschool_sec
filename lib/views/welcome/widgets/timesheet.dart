import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/models/timesheet_model.dart';
import 'package:my_webschool_sec/utils/constants_util.dart';
import 'package:my_webschool_sec/utils/string_util.dart';

import 'package:hive/hive.dart';

import 'timesheet_card.dart';

class TimeSheet extends StatefulWidget {
  const TimeSheet({super.key});

  @override
  State<TimeSheet> createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  List<String> tabs = ['aujourdhui', 'demain'];
  List<bool> isSelected = [true, false];
  DateTime today = DateTime.now();
  DateTime tommorow = addDays(DateTime.now(), 1);

  Future<List<TimeSheetModel>> fetchData() async {
    final userHive = Hive.box(hivedb);
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    User? user = FirebaseAuth.instance.currentUser;
    List<TimeSheetModel> timeSheets = [];

    if (user != null) {
      await FirebaseFirestore.instance
          .collection("students_${userHive.get('sid')}")
          .doc(userHive.get('uid'))
          .get()
          .then((value) async {
        if (value.data().toString().contains('cours:')) {
          if (value['cours'] != null && value['cours'] != '') {
            List<dynamic> jsonArray = json.decode(value['cours']);
            for (var jsonMap in jsonArray) {
              timeSheets.add(TimeSheetModel(
                jour: int.parse(jsonMap['jour']),
                matiere: jsonMap['matiere'],
                heure_debut: jsonMap['heure_deb'],
                heure_fin: jsonMap['heure_fin'],
                salle: jsonMap['salle'],
                nom_prof: jsonMap['nom'],
                prenom_prof: jsonMap['prenom'],
                atome: jsonMap['atome'],
              ));
            }
          }
        } else {}
      });
      // net = echeances.fold(
      //     0, (previousValue, element) => previousValue + element.net!);
      // paye = echeances.fold(
      //     0, (previousValue, element) => previousValue + element.montant_paye!);
      return timeSheets;
    } else {
      throw Exception('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          borderColor: Colors.grey,
          selectedBorderColor: kColorPrimary,
          color: Colors.grey,
          selectedColor: Colors.black,
          fillColor: kColorPrimary,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected, //
          children: tabs.map((String tab) {
            return SizedBox(
              width: 100,
              child: Center(
                child: RichText(
                    text: TextSpan(
                        text: tab.tr(),
                        style: TextStyle(
                            fontSize: 18,
                            color: isSelected[tabs.indexOf(tab)]
                                ? Colors.white
                                : Colors.black))),
              ),
            );
          }).toList(),
        ),
        FutureBuilder<List<TimeSheetModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const Center(
                //   child: CircularProgressIndicator(),
                // );
                return Center(
                    child: Container(
                  padding: const EdgeInsets.only(
                      left: 0, top: 30, bottom: 0, right: 0),
                  child: const Center(
                    child: CircularProgressIndicator(
                        // strokeWidth: 5,
                        ),
                  ),
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: RichText(
                      text: TextSpan(text: 'Error: ${snapshot.error}')),
                );
              } /*else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Aucun cours prévu.'),
                );
              } */
              else {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  child: isSelected[0]
                      ? TimesheetCard(
                          index: 1,
                          date: today,
                          cours: getCoursByDate(today, snapshot.data))
                      : TimesheetCard(
                          index: 2,
                          date: tommorow,
                          cours: getCoursByDate(tommorow, snapshot.data)),
                );
              }
            }),
      ],
    );
  }

  List<TimeSheetModel> getCoursByDate(DateTime dt, List<TimeSheetModel>? list) {
    if (list != null) {
      return list.where((element) => element.jour == dt.weekday).toList();
    }
    return [];
  }
}
