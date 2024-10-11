import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants_util.dart';
import '../../../utils/string_util.dart';

class FinanceCard extends StatelessWidget {
  final double net;
  final double paye;
  const FinanceCard({super.key, required this.net, required this.paye});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: kColorPrimary,
        border: Border.all(
          color: kColorPrimaryDark,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'montant.a.payer'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'montant.paye'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'reste.a.payer'.tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kColorLight),
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(net),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorLight),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(paye),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorLight),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: formatDoubleWithThousandSeparator(net - paye),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: kColorAmber),
                  children: const <TextSpan>[
                    TextSpan(
                      text: " CFA",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: kColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
