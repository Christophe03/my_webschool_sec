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

  Future<List<EcheanceModel>> fetchData() async {
    final userHive = Hive.box(hivedb);
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay
    User? user = FirebaseAuth.instance.currentUser;
    List<EcheanceModel> echeances = [];

    if (user != null) {
      await FirebaseFirestore.instance
          .collection("students_" + userHive.get('sid'))
          .doc(userHive.get('uid'))
          .get()
          .then((value) async {
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
