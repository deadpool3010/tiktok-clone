import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;
final _firebasestorage = FirebaseStorage.instance;

class uplaodvideo extends GetxController {
  dynamic upload(String songname, String caption, String videopath) async {
    try {
      String uniqid = _user!.uid;
      DocumentSnapshot db =
          await _firestore.collection('user').doc(uniqid).get();
    } catch (e) {}
  }
}
