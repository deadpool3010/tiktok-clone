import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class User {
  late String username;
  late String uid;
  late String email;
  late String password;
  String? _imagee;

  User(String username, String email, String password, String uid,
      String _imagee) {
    this.username = username;
    this.password = password;
    this.email = email;
    this.uid = uid;
    this._imagee = _imagee;
  }

  Map<String, dynamic> tojson() => {
        "username": username,
        "email": email,
        "password": password,
        "uid": uid,
        "image": _imagee
      };
}
