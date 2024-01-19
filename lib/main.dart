import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/playvideo.dart';
import 'package:tiktok/splash.dart';
import 'package:tiktok/loginscreen.dart';
import 'package:tiktok/logintestingpage.dart';
import 'package:tiktok/signup.dart';
import 'package:tiktok/themeclass.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: signup(),
      // themeMode:ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: splash(),
      routes: {
        "/loginscreen": (context) => loginscreen(),
        '/signup': (context) => signup(),
        "/logintesting": (context) => logintesting(),
        "/playvideo": (context) => playvideo()
      },
    );
  }
}
