import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;

class check {
  void login(BuildContext context) {
    if (_user != null) {
      Timer(Duration(seconds: 3), (() {
        Navigator.pushNamed(context, '/logintesting');
      }));
    } else {
      Timer(Duration(seconds: 3), (() {
        Navigator.pushNamed(context, '/loginscreen');
      }));
    }
  }
}
