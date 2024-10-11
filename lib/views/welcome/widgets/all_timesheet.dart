import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_webschool_sec/models/timesheet_model.dart';
import 'package:my_webschool_sec/utils/constants_util.dart';
import 'package:my_webschool_sec/utils/string_util.dart';
import 'package:my_webschool_sec/views/welcome/widgets/timesheet_card.dart';
import 'package:my_webschool_sec/widgets/app_name.dart';

class AllTimesheet extends StatefulWidget {
  const AllTimesheet({Key? key}) : super(key: key);

  @override
  _AllTimesheetState createState() => _AllTimesheetState();
}

class _AllTimesheetState extends State<AllTimesheet> {
  bool fetching = true;
  List<TimeSheetModel> timesheets = [];
  final List<Map<String, dynamic>> listJour = [
    {'name': 'Lundi', 'index': 1},
    {'name': 'Mardi', 'index': 2},
    {'name': 'Mercredi', 'index': 3},
    {'name': 'Jeudi', 'index': 4},
    {'name': 'Vendredi', 'index': 5},
    {'name': 'Samedi', 'index': 6},
    {'name': 'Dimanche', 'index': 7},
  ];

  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      fetching = true;
    });
    final userHive = Hive.box(hivedb);
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    User? user = FirebaseAuth.instance.currentUser;
    timesheets = [];
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
              timesheets.add(TimeSheetModel(
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
    }
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kColorPrimary,
        titleSpacing: 0,
        title: AppName(
          fontSize: 19.0,
          school: "emploi.du.temps".tr(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kColorLight,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Builder(builder: (BuildContext context) {
        return RefreshIndicator(
            onRefresh: () async {
              fetchData();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: fetching
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ])
                        : timesheets.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Center(
                                      child: Icon(Icons.folder_off_outlined,
                                          size: 100),
                                    ),
                                    Center(
                                      child: Text(
                                        "l.emploie.du.temps.est.vide".tr(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ])
                            : ListView(
                                children: [
                                  ...listJour.map((e) {
                                    return TimesheetCard(
                                      index: 0,
                                      date: DateTime.now(),
                                      cours: getCoursByDate(e['index']),
                                      jour:
                                          e['name'].toString().toCapitalized(),
                                    );
                                  })
                                ],
                              ))
              ],
            ));
      }),
    );
  }

  List<TimeSheetModel> getCoursByDate(int dt) {
    return timesheets.where((element) => element.jour == dt).toList();
  }
}
