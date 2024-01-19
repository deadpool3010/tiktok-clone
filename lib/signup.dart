import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/usermodel.dart' as u;

final _email = TextEditingController();
final _password = TextEditingController();
final _username = TextEditingController();
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _firebasestorage = FirebaseStorage.instance;

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var _pick = ImagePicker();
  String? downoad;
  File? image;
  String? dow;
  Future getimage() async {
    var iimage = (await _pick.pickImage(source: ImageSource.gallery));
    setState(() {
      image = File(iimage!.path);
    });
    Reference rf = _firebasestorage.ref().child('/folder');
    UploadTask up = rf.putFile(image!.absolute);
    await Future.value(up);
    dow = await rf.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    void login(String username, String email, String password) async {
      try {
        if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);

          u.User user = u.User(_username.text, _email.text, _password.text,
              cred.user!.uid, dow!);

          _firestore
              .collection('user')
              .doc(cred.user!.uid)
              .set(user.tojson())
              .then((value) {
            _email.clear();
            _username.clear();
            _password.clear();
            Navigator.pushNamed(context, "/loginscreen");
          }).onError((error, stackTrace) {
            Get.snackbar("Error", error.toString());
          });
        } else {
          Get.snackbar("Nullity", "Feilds cant be null");
        }
      } catch (e) {
        Get.snackbar("Hello", e.toString());
      }
    }

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    image == null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/813px-Unknown_person.jpg?20200423155822'),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(image!),
                          ),
                    Positioned(
                        bottom: -7,
                        left: 80,
                        child: IconButton(
                            onPressed: () {
                              getimage();
                            },
                            icon: Icon(Icons.add_a_photo)))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person),
                      labelStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      labelStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                      labelStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 35,
                  height: 54,
                  child: InkWell(
                    onTap: () async {
                      login(_username.text, _email.text, _password.text);
                    },
                    child: Center(
                        child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Alredy have an account?",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginscreen');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        resizeToAvoidBottomInset: false);
  }
}
