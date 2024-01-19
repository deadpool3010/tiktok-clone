import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tiktok/bottomroutes.dart';
import 'package:tiktok/playvideo.dart';
import 'package:tiktok/videoitem.dart';
import 'package:video_player/video_player.dart';

final _auth = FirebaseAuth.instance;
bool _isliked = false;
final _user = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;
final _firebasestorage = FirebaseStorage.instance;
late int likecount;
late String likess;
late int i;

final _userstream = _firestore.collection('video').snapshots();

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  void liked() async {
    DocumentSnapshot dc =
        await _firestore.collection('video').doc('video $i').get();

    if ((dc.data() as dynamic)['likes'].contains(_user.toString())) {
      _isliked = true;
    } else {
      await _firestore
          .collection('video')
          .doc('vide $i')
          .update({'like': _user.toString()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tiktok clone'),
          actions: [
            InkWell(
              child: Icon(Icons.logout),
              onTap: () {
                _auth.signOut().then(
                    (value) => (Navigator.pushNamed(context, '/loginscreen')));
              },
            )
          ],
          automaticallyImplyLeading: false),
      body: StreamBuilder(
        stream: _userstream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('waiting');
          }
          var docs = snapshot.data!.docs;
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              String l = docs[index]['videourl'];
              String usernamee = docs[index]['username'];
              String captionn = docs[index]['caption'];
              String songname = docs[index]['songname'];
              String profile = docs[index]['profile'];

              i = index;

              VideoPlayerController v = VideoPlayerController.network(l);
              v.initialize();
              v.play();
              v.setVolume(1);
              v.setLooping(true);

              return Stack(
                children: [
                  VideoPlayer(v),
                  Positioned(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usernamee,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          captionn,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 10,
                            ),
                            Text(
                              songname,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  Positioned(
                      right: 20,
                      top: 250,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(profile),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.favorite,
                                size: 50,
                                color: _isliked == true
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onTap: (() async {
                                liked();
                              }),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Icon(
                              Icons.message,
                              size: 45,
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Icon(
                              Icons.share,
                              size: 45,
                            ),
                          ],
                        ),
                      ))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
