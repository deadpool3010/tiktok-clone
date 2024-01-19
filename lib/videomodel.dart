import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Video extends GetxController {
  late String uid;
  late String songname;
  late String caption;
  late String videourl;
  late String username;
  late String profile;
  late List like;
  late int likecount;

  Video(String uid, String songname, String caption, String videourl,
      String username, String profile, List like, int likecount) {
    this.uid = uid;
    this.songname = songname;
    this.caption = caption;
    this.videourl = videourl;
    this.username = username;
    this.profile = profile;
    this.like = like;
    this.likecount = likecount;
  }

  Map<String, dynamic> tojson() {
    return {
      'uid': uid,
      'songname': songname,
      'caption': caption,
      'videourl': videourl,
      'username': username,
      'profile': profile,
      'like': like,
      'likecount': likecount
    };
  }

  void fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    videourl = snapshot['videourl'];
  }
}
