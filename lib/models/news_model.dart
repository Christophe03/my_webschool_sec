import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String? id;
  String? message;
  String? categorie;
  String? color;
  String? sender;
  String? timestamp;
  NewsModel(
      {this.id,
      this.message,
      this.categorie,
      this.color,
      this.sender,
      this.timestamp});

  factory NewsModel.fromFirestore(DocumentSnapshot<Object?> d) {
    return NewsModel(
      id: d['id'],
      message: d['message'],
      categorie: d['categorie'],
      color: d['color'],
      sender: d['sender'],
      timestamp: d['timestamp'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'categorie': categorie,
      'color': color,
      'sender': sender,
      'timestamp': timestamp,
    };
  }

  String toJson() => json.encode(toMap());
}
