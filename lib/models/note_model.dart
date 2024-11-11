import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  int? semestre;
  String? matiere;
  int? credit;
  double? moy;
  double? moy1;
  double? moy2;
  int? moyennebase;
  String? notes;
  NoteModel(
      {this.semestre,
      this.matiere,
      this.moy,
      this.moy1,
      this.moy2,
      this.moyennebase,
      this.notes});

  factory NoteModel.fromFirestore(DocumentSnapshot<Object?> d) {
    return NoteModel(
      semestre: d['semestre'],
      matiere: d['matiere'],
      moy: d['moy'],
      moy1: d['moy1'],
      moy2: d['moy2'],
      moyennebase: d['base'],
      notes: d['notes'],
    );
  }
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      semestre: json['semestre'] ?? 0,
      matiere: json['matiere'] ?? '',
      moy: json['moy'] != null ? json['moy'].toDouble() : 0.0,
      moy1: json['moy1'] != null ? json['moy1'].toDouble() : 0.0,
      moy2: json['moy2'] != null ? json['moy2'].toDouble() : 0.0,
      moyennebase: json['base'] ?? 0,
      notes: json['notes'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'semestre': semestre,
      'matiere': matiere,
      'moy': moy,
      'moy1': moy1,
      'moy2': moy2,
      'base': moyennebase,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
