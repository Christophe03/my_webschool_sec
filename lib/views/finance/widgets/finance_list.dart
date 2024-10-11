import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/models/echeance_model.dart';
import 'package:my_webschool_sec/utils/string_util.dart';

import '../../../utils/constants_util.dart';
import '../../../widgets/circle_avatar.dart';

class FinanceList extends StatefulWidget {
  final List<EcheanceModel> snapshot;
  const FinanceList({super.key, required this.snapshot});

  @override
  State<FinanceList> createState() => _FinanceListState();
}

class _FinanceListState extends State<FinanceList> {
  getStatusColor(EcheanceModel e) {
    return e.est_solde == 'Y'
        ? Colors.green
        : calculateDifferenceInDaysFirebase(e.date!) > 0
            ? kColorPink
            : kColorDark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.snapshot.map((EcheanceModel tab) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    kColorPrimaryDark, // Change the color of the border as needed
                width: 1.0, // Adjust the width of the border as needed
              ),
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the border radius as needed
            ),
            child: ListTile(
              leading: CircleAvatarWithText(
                text: tab.ordre.toString(),
                backgroundColor: kColorPrimary,
                textColor: Colors.white,
                radius: 20.0,
              ),
              title: RichText(
                  text: TextSpan(
                text: formatDateFirebase(tab.date!),
                style: TextStyle(
                  fontSize: 13,
                  color: getStatusColor(tab),
                  fontWeight: FontWeight.w400,
                ),
              )),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'reste.a.payer'.tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                      children: <TextSpan>[
                        const TextSpan(
                          text: "  ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: formatDoubleWithThousandSeparator(
                              tab.net! - tab.montant_paye!),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(
                          text: " CFA",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: InkWell(
                  onTap: () {
                    showDetails(tab);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'voir.details'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: kColorDark,
                            fontWeight: FontWeight.w500,
                          )))
                  // Text('voir.details',
                  //     style: TextStyle(
                  //       fontFamily: 'Poppins',
                  //       fontSize: 12,
                  //       color: kColorDark,
                  //       fontWeight: FontWeight.w500,
                  //     )).tr(),
                  ),
            ),
          );
        }).toList()
      ],
    );
  }

  void showDetails(EcheanceModel e) async {
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
                  text: 'details'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kColorDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ))),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "num.echeance".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: e.ordre.toString(),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "date.echeance".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: formatDateFirebase(e.date!),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: e.est_solde == 'Y',
                  child: Column(children: [
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(
                          text: "date.reglement".tr(),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kColorDark),
                        )),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              text: e.date_reglement != null
                                  ? formatDateFirebase(e.date_reglement ?? "")
                                  : "",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: kColorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(
                          text: "nrecu".tr(),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kColorDark),
                        )),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              text: e.recu != null ? e.recu! : '',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: kColorPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "montant.a.payer".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: formatDoubleWithThousandSeparator(e.net!),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                          children: const <TextSpan>[
                            TextSpan(
                              text: " CFA",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: kColorPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "montant.paye".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: formatDoubleWithThousandSeparator(
                              e.montant_paye!),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                          children: const <TextSpan>[
                            TextSpan(
                              text: " CFA",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: kColorPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "reste.a.payer".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: formatDoubleWithThousandSeparator(
                              e.net! - e.montant_paye!),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                          children: const <TextSpan>[
                            TextSpan(
                              text: " CFA",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: kColorPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "statut".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: e.est_solde == 'Y'
                              ? "payee".tr()
                              : "non.payee".tr(),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: e.est_solde == 'Y'
                                  ? Colors.green
                                  : kColorPink),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
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
