import 'package:cloud_firestore/cloud_firestore.dart';

class EcheanceModel {
  int? id;
  int? ordre;
  String? recu;
  String? date;
  String? date_reglement;
  double? net;
  double? montant_paye;
  String? est_solde;
  EcheanceModel({
    this.id,
    this.ordre,
    this.recu,
    this.date,
    this.date_reglement,
    this.net,
    this.montant_paye,
    this.est_solde,
  });

  factory EcheanceModel.fromFirestore(DocumentSnapshot<Object?> d) {
    return EcheanceModel(
      id: d['id'],
      ordre: d['ordre'],
      recu: d['recu'],
      date: d['date'],
      date_reglement: d['date_reglement'],
      net: d['net'],
      montant_paye: d['montant_paye'],
      est_solde: d['est_solde'],
    );
  }
  factory EcheanceModel.fromJson(Map<String, dynamic> json) {
    return EcheanceModel(
      id: json['id'],
      ordre: json['ordre'],
      recu: json['recu'],
      date: json['date'],
      date_reglement: json['date_reglement'],
      net: json['net'] ? json['net'] : 0,
      montant_paye: json['montant_paye'] ? json['montant_paye'] : 0,
      est_solde: json['est_solde'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ordre': ordre,
      'recu': recu,
      'date': date,
      'date_reglement': date_reglement,
      'net': net,
      'montant_paye': montant_paye,
      'est_solde': est_solde,
    };
  }
}
