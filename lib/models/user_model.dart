import 'dart:convert';

import '../utils/string_util.dart';

class UserModel {
  String? uid;
  String? sid;
  String? name;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? avatar;
  String? role;

  UserModel(
    this.uid,
    this.sid,
    this.firstname,
    this.name,
    this.lastname,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.role,
  );
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'sid': sid,
      'firstname': firstname,
      'lastname': lastname,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'avatar': avatar,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      map['uid'],
      map['sid'],
      map['firstname'],
      map['lastname'],
      map['name'],
      map['email'],
      map['password'],
      map['phone'],
      map['avatar'],
      map['role']);

  String get displayName => '${name?.toCapitalized()}}';
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
