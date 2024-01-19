import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/add.dart';
import 'package:tiktok/bottomroutes.dart';
import 'package:tiktok/videomodel.dart';
import 'package:video_player/video_player.dart';

final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;
final _firebasestorage = FirebaseStorage.instance;
String? url;
String? username;
String? caption;
String? songname;

bool isloading = false;

class playvideo extends StatefulWidget {
  const playvideo({super.key});

  @override
  State<playvideo> createState() => _playvideoState();
}

late VideoPlayerController _playvid;
TextEditingController _songname = TextEditingController();
TextEditingController _caption = TextEditingController();

class _playvideoState extends State<playvideo> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _playvid = VideoPlayerController.file(pickedvideo!);
    });
    _playvid.initialize();
    _playvid.play();
    _playvid.setLooping(true);
  }

  String? url;
  Future uploadStorage(String len) async {
    Reference rf = _firebasestorage.ref().child("video").child(len);
    UploadTask up = rf.putFile(pickedvideo!);
    await up;
    url = await rf.getDownloadURL();
  }

  void uplaod(String songname, String caption) async {
    try {
      DocumentSnapshot userdoc =
          await _firestore.collection('user').doc(_user!.uid).get();

      var all = await _firestore.collection('video').get();
      int len = all.docs.length;
      await uploadStorage("video $len");

      final username =
          await (userdoc.data() as Map<String, dynamic>)['username'];
      final profile = await (userdoc.data() as Map<String, dynamic>)['image'];
      final likes = await (userdoc.data() as dynamic)['likes'];
      print(likes.toString());

      Video v = Video(_user!.uid, _songname.text, _caption.text, url!,
          username.toString(), profile.toString(), [], 0);

      _firestore
          .collection('video')
          .doc('video $len')
          .set(v.tojson())
          .then((value) {
        Get.snackbar("Successfully uploaded", "",
            snackPosition: SnackPosition.BOTTOM);
      });

      Get.back();
    } catch (e) {
      Get.snackbar("error", e.toString());
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(_playvid),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: TextField(
              controller: _songname,
              decoration: InputDecoration(
                labelText: "Songname",
                prefixIcon: Icon(Icons.music_note),
                labelStyle: TextStyle(fontSize: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: TextField(
              controller: _caption,
              decoration: InputDecoration(
                labelText: "Caption",
                prefixIcon: Icon(Icons.message),
                labelStyle: TextStyle(fontSize: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: (() {
              setState(() {
                songname = _songname.text;
                caption = _caption.text;
                print(songname);
                print(caption);
              });
              uplaod(_songname.text, _caption.text);
            }),
            child: Text(
              'Share',
              style: TextStyle(fontSize: 15),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
          )
        ],
      )),
    );
  }
}
