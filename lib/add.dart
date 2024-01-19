import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;
final _firestore = FirebaseFirestore.instance;
final _firebasestorage = FirebaseStorage.instance;

final _picker = ImagePicker();
File? pickedvideo;
XFile? video;
String? url;

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  Future pickvideo() async {
    video = await _picker.pickVideo(source: ImageSource.camera);

    setState(() {
      pickedvideo = File(video!.path);
      if (pickedvideo != null) {
        Navigator.pushNamed(context, '/playvideo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: (() {
          pickvideo();
        }),
        child: Container(
          color: Colors.red,
          height: 55,
          width: 190,
          child: Center(
            child: Text(
              'Add video',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
