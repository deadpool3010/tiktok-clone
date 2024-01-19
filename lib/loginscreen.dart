import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok/textfield.dart';
import 'package:get/get.dart';
import 'logintestingpage.dart';

final _email = TextEditingController();
final _password = TextEditingController();
final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Login",
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
            SizedBox(
              height: 8,
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
                onTap: () {
                  _auth
                      .signInWithEmailAndPassword(
                          email: _email.text, password: _password.text)
                      .then((value) {
                    _email.clear();
                    _password.clear();
                    Navigator.pushNamed(context, "/logintesting");
                  }).onError((error, stackTrace) {
                    Get.snackbar(
                      "Error",
                      error.toString(),
                    );
                  });
                  print('login ');
                },
                child: Center(
                    child: Text(
                  'Login',
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
                  "Don't have an account",
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
