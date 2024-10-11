import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSheetModel {
  int? jour;
  String? matiere;
  String? heure_debut;
  String? heure_fin;
  String? salle;
  String? nom_prof;
  String? prenom_prof;
  String? atome;

  TimeSheetModel(
      {this.jour,
      this.matiere,
      this.heure_debut,
      this.heure_fin,
      this.salle,
      this.nom_prof,
      this.prenom_prof,
      this.atome});

  factory TimeSheetModel.fromFirestore(DocumentSnapshot<Object?> d) {
    return TimeSheetModel(
      jour: d['jour'],
      matiere: d['matiere'],
      heure_debut: d['heure_deb'],
      heure_fin: d['heure_fin'],
      salle: d['salle'],
      nom_prof: d['nom'],
      prenom_prof: d['prenom'],
      atome: d['atome'],
    );
  }
  factory TimeSheetModel.fromJson(Map<String, dynamic> json) {
    return TimeSheetModel(
      jour: json['jour'],
      matiere: json['matiere'],
      heure_debut: json['heure_deb'],
      heure_fin: json['heure_fin'],
      salle: json['salle'],
      nom_prof: json['nom'],
      prenom_prof: json['prenom'],
      atome: json['atome'],
    );
  }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'ordre': ordre,
//       'recu': recu,
//       'date': date,
//       'date_reglement': date_reglement,
//       'net': net,
//       'montant_paye': montant_paye,
//       'est_solde': est_solde,
//     };
//   }
}
