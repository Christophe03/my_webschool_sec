import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_webschool_sec/utils/string_util.dart';
import 'package:my_webschool_sec/widgets/circle_avatar.dart';

import '../../models/echeance_model.dart';
import '../../utils/constants_util.dart';
import '../../widgets/app_name.dart';
import '../../widgets/drawer_wecome.dart';
import 'widgets/finance_card.dart';
import 'widgets/finance_list.dart';

class FinanceView extends StatefulWidget {
  const FinanceView({super.key});

  @override
  State<FinanceView> createState() => _FinanceViewState();
}

class _FinanceViewState extends State<FinanceView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double net = 0;
  double paye = 0;
  Timestamp? update_at;
  @override
  void initState() {
    super.initState();
  }

  bool? _hasData;
  bool get hasData => _hasData ?? false;
  String _lastVisible = '';
  String get lastVisible => _lastVisible;
  List<DocumentSnapshot> _snap = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getData(mounted) async {
    final userHive = Hive.box(hivedb);
    _hasData = true;

    QuerySnapshot rawData;
    if (_lastVisible == '') {
      if (userHive.containsKey('sid')) {
        print("Le SID de l'utilisateur est ...M: ${userHive.get('sid')}");
      } else {
        print("La clé 'sid' n'existe pas dans Hive.");
      }

      rawData = await firestore
          .collection("students_" + userHive.get('sid'))
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();
      print('Document récupéré avec succès : ${rawData}');
    } else {
      rawData = await firestore
          .collection("students_" + userHive.get('sid'))
          .orderBy('timestamp', descending: true)
          .startAfter([_lastVisible])
          .limit(10)
          .get();
    }
  }

  Future<List<EcheanceModel>> fetchData() async {
    if (!Hive.isBoxOpen(hivedb)) {
      await Hive.openBox(hivedb);
    }
    final userHive = Hive.box(hivedb);
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay
    User? user = FirebaseAuth.instance.currentUser;
    List<EcheanceModel> echeances = [];
    var userUid = userHive.get('uid');
    var userSid = userHive.get('sid');

    if (user == null) {
      throw Exception('Erreur d\'authentification.');
    }
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("students_" + userHive.get('sid'))
          .doc('mpuPsdpyNvbXWxPWY9ghMGbmnu62:250002B')
          .get();
      print('User : ${userHive.get('sid')}');
      if (docSnapshot.exists) {
        print('Le Document est récupéré avec succès : ${docSnapshot.data()}');
      } else {
        print('Le document n\'existe pas.');
        throw Exception('Document introuvable.');
      }
    } catch (e) {
      print('Erreur lors de l\'accès Firestore : $e');
      throw Exception('Erreur Firestore : $e');
    }

    if (userUid == null || userSid == null) {
      await FirebaseFirestore.instance
          .collection('students_$userSid')
          .doc('mpuPsdpyNvbXWxPWY9ghMGbmnu62:250002B')
          .get()
          .then((value) async {
        print("Le UID de l'utilisateur est : students_$userSid");
        if (!value.exists) {
          print("Le UID de l'utilisateur est : $userSid");
          throw Exception('Le document n\'existe pas.');
        }

        if (!value.data()!.containsKey('paiements')) {
          print("paiements");
          throw Exception('Le champ "paiements" est absent.');
        }

        List<dynamic> jsonArray = json.decode(value['paiements']);

        update_at = value['update_at'];
        userHive.put('update_at', update_at!.millisecondsSinceEpoch);

        for (var jsonMap in jsonArray) {
          echeances.add(EcheanceModel(
            id: jsonMap['id'],
            ordre: jsonMap['ordre'],
            recu: jsonMap['recu'],
            date: jsonMap['date'],
            date_reglement: jsonMap['date_reglement'],
            net: jsonMap['net'].toDouble(),
            montant_paye: jsonMap['montant_paye'].toDouble(),
            est_solde: jsonMap['est_solde'],
          ));
        }
      });
      net = echeances.fold(
          0, (previousValue, element) => previousValue + element.net!);
      paye = echeances.fold(
          0, (previousValue, element) => previousValue + element.montant_paye!);
      return echeances;
    } else {
      throw Exception('Erreur lors de la récupération des données.');
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
              school: 'situation.financiere'.tr(),
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
                      FutureBuilder<List<EcheanceModel>>(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: CircularProgressIndicator()),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No data available.'),
                              );
                            } else {
                              return Column(
                                children: [
                                  FinanceCard(
                                    net: net,
                                    paye: paye,
                                  ),
                                  FinanceList(snapshot: snapshot.data!),
                                ],
                              );
                            }
                          }),
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
                  text: 'info.echeance.text1'.tr(
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
                  text: 'info.echeance.text2'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatarWithText(
                        text: '',
                        radius: 10,
                        backgroundColor: kColorDark,
                        textColor: kColorDark),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                          // textAlign: TextAlign.end,
                          text: TextSpan(
                        text: 'echeance.normale'.tr(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: kColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatarWithText(
                        text: '',
                        radius: 10,
                        backgroundColor: Colors.green,
                        textColor: Colors.green),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                          // textAlign: TextAlign.end,
                          text: TextSpan(
                        text: 'echeance.soldee'.tr(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: kColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatarWithText(
                        text: '',
                        radius: 10,
                        backgroundColor: kColorPink,
                        textColor: kColorPink),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RichText(
                          // textAlign: TextAlign.end,
                          text: TextSpan(
                        text: 'echeance.retard'.tr(),
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: kColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ],
                ),
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
