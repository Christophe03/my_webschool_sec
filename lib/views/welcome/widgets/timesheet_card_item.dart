import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_sec/models/timesheet_model.dart';

import '../../../utils/constants_util.dart';

class TimesheetCardItem extends StatelessWidget {
  final TimeSheetModel cour;
  const TimesheetCardItem({super.key, required this.cour});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: RichText(
                    text: TextSpan(
                  text: "${cour.matiere ?? ""} (${cour.atome ?? ""})",
                  // 'Base de données avancées',
                  style: TextStyle(
                    color: kColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                )),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.person,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    "${cour.prenom_prof ?? ''} ${cour.nom_prof ?? ''}",
                                style: const TextStyle(
                                    fontSize: 18, color: kColorPrimary)))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.time,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                text: formatHeures(cour.heure_debut ?? "",
                                    cour.heure_fin ?? ""),
                                style:
                                    TextStyle(fontSize: 18, color: kColorDark)))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.home,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                text: cour.salle ?? "",
                                style: const TextStyle(
                                    fontSize: 16, color: kColorDark)))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  String formatHeures(String debut, String fin) {
    if (debut == "" || fin == "") {
      return 'NA - NA';
    }
    // Conversion des heures en DateTime
    DateTime debutHeure = DateTime.parse("2024-03-18 $debut");
    DateTime finHeure = DateTime.parse("2024-03-18 $fin");

    // Formatage des heures
    String debutFormat = debutHeure.minute == 0
        ? '${debutHeure.hour}H'
        : '${debutHeure.hour}H${debutHeure.minute}';
    String finFormat = finHeure.minute == 0
        ? '${finHeure.hour}H'
        : '${finHeure.hour}H${finHeure.minute}';

    return '$debutFormat - $finFormat';
  }
}
