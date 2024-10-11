import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  int? semestre;
  String? matiere;
  int? credit;
  double? moyenne;
  int? moyennebase;
  String? notes;
  NoteModel(
      {this.semestre,
      this.matiere,
      this.credit,
      this.moyenne,
      this.moyennebase,
      this.notes});

  factory NoteModel.fromFirestore(DocumentSnapshot<Object?> d) {
    return NoteModel(
      semestre: d['semestre'],
      matiere: d['matiere'],
      credit: d['credit'],
      moyenne: d['moyenne'],
      moyennebase: d['base'],
      notes: d['notes'],
    );
  }
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      semestre: json['semestre'],
      matiere: json['matiere'],
      credit: json['credit'] ? json['credit'] : 0,
      moyenne: json['moyenne'] ? json['moyenne'] : 0,
      moyennebase: json['base'] ? json['base'] : 0,
      notes: json['notes'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'semestre': semestre,
      'matiere': matiere,
      'credit': credit,
      'moyenne': moyenne,
      'base': moyennebase,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
