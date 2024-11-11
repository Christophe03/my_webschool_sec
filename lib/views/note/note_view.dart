import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_sec/models/note_model.dart';
import 'package:my_webschool_sec/utils/string_util.dart';

import '../../utils/constants_util.dart';
import '../../widgets/app_name.dart';
import '../../widgets/drawer_wecome.dart';
import 'widgets/note_card.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> tabs = ['1', '2', '3'];
  List<bool> isSelected = [true, false, false];
  double buttonWidth = 0.0;
  Timestamp? update_at;
  @override
  void initState() {
    super.initState();
  }

  Future<List<NoteModel>> fetchData() async {
    final userHive = Hive.box(hivedb);
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
    User? user = FirebaseAuth.instance.currentUser;
    List<NoteModel> notes = [];

    if (user != null) {
      // Afficher le sid dans la console
      print("Le UID de l'utilisateur est : ${userHive.get('uid')}");

      // Use async/await instead of .then() for better error handling and flow
      DocumentSnapshot value = await FirebaseFirestore.instance
          .collection("students_" + userHive.get('sid'))
          .doc('mpuPsdpyNvbXWxPWY9ghMGbmnu62:250002B')
          // .doc(userHive.get('uid'))
          .get();

      // Ensure that value exists and has data
      if (value.exists && value.data() != null) {
        update_at = value['update_at'];
        userHive.put('update_at', update_at!.millisecondsSinceEpoch);

        // Parse the notes data
        List<dynamic> jsonArray = json.decode(value['notes']);
        notes = jsonArray.map((json) => NoteModel.fromJson(json)).toList();
        print(jsonArray);

        for (var jsonMap in jsonArray) {
          notes.add(NoteModel(
            semestre: jsonMap['semestre'],
            matiere: jsonMap['matiere'],
            moy: jsonMap['moy'].toDouble(),
            moy1: jsonMap['moy'].toDouble(),
            moy2: jsonMap['moy'].toDouble(),
            moyennebase: jsonMap['base'],
            notes: jsonMap['notes'],
          ));
        }
      }

      // Return the notes list; it could be empty but not null
      return notes;
    } else {
      throw Exception('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: AppName(
              fontSize: 19.0,
              school: 'releves.de.notes'.tr(),
            ),
            backgroundColor: kColorPrimary,
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: kColorLight,
                size: 25,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            elevation: 1,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.help,
                  color: kColorLight,
                  size: 25,
                ),
                onPressed: () => update_at != null ? showInfo() : (),
              ),
              const SizedBox(
                width: 5,
              )
            ],
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ];
      }, body: Builder(
        builder: (BuildContext context) {
          return Builder(
            builder: (BuildContext context) {
              return RefreshIndicator(
                onRefresh: () async {
                  // context.read<FeaturedBloc>().onRefresh();
                },
                child: SingleChildScrollView(
                  key: const PageStorageKey('key1'),
                  padding: const EdgeInsets.all(0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ToggleButtons(
                        constraints: BoxConstraints(
                          minWidth: (MediaQuery.of(context).size.width - 3) /
                              tabs.length,
                          minHeight: 48, // Ajustez la hauteur selon vos besoins
                        ),
                        borderColor: Colors.grey,
                        selectedBorderColor: kColorPrimary,
                        color: Colors.grey,
                        selectedColor: Colors.white,
                        fillColor: kColorPrimary,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == index;
                            }
                          });
                        },
                        isSelected: isSelected,
                        children: tabs.map((String tab) {
                          return Center(
                            child: Text(
                              '${'trimestre'.tr()} $tab',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: isSelected[tabs.indexOf(tab)]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<NoteModel>>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                'No data available.',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            );
                          } else {
                            int selectedSemester = isSelected.indexOf(true) + 1;
                            return NoteCard(
                              snapshot: snapshot.data!
                                  .where((note) =>
                                      note.semestre == selectedSemester)
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      )),
    );
  }

  Widget buildButton(int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update the maximum width among all buttons
        buttonWidth = constraints.maxWidth > buttonWidth
            ? constraints.maxWidth
            : buttonWidth;

        return Center(
          child: Text(
            '${'trimestre'.tr()} $index',
          ),
        );
      },
    );
  }

  void showInfo() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 15,
                left: 15,
                right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: RichText(
                        text: TextSpan(
                  text: 'infos'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ))),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                    text: TextSpan(
                  text: 'info.note.text2'.tr(
                    context: context,
                    namedArgs: {
                      'date':
                          formatTimestamp(update_at!, "dd MMMM yyyy à HH:mm")
                    },
                  ),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(
                  text: 'info.note.text3'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                RichText(
                    text: TextSpan(
                  text: 'info.note.text4'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                RichText(
                    text: TextSpan(
                  text: 'info.note.text5'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kColorPrimary),
                          ),
                          child: RichText(
                              text: TextSpan(
                                  text: 'fermer'.tr(),
                                  style: const TextStyle(fontSize: 16))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )));
  }
}
