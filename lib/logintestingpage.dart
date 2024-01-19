import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'bottomroutes.dart';

final _auth = FirebaseAuth.instance;
final _user = _auth.currentUser;
int index = 0;

class logintesting extends StatefulWidget {
  const logintesting({super.key});

  @override
  State<logintesting> createState() => _logintestingState();
}

class _logintestingState extends State<logintesting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) => {
                setState(() {
                  index = value;
                })
              }),
          backgroundColor: Colors.black,
          currentIndex: index,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'search',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 60,
                ),
                label: ""),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 30,
              ),
              label: 'message',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'person',
            ),
          ]),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("tiktok"),
      //   actions: [
      //     IconButton(
      //         onPressed: (() {
      //           _auth.signOut().then((value) {
      //             Navigator.pushNamed(context, "/loginscreen");
      //           });
      //         }),
      //         icon: Icon(Icons.logout_sharp))
      //   ],
      //   centerTitle: true,
      //   backgroundColor: Colors.red,
      // ),
      body: l[index],
    );
  }
}
