import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newszonecollege/view/HomeScreen.dart';
import 'package:newszonecollege/view/mynewsscreen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'auth/loginscreen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase initialization
  await Firebase.initializeApp();

  runApp(GetMaterialApp(home: HomeScreen(),debugShowCheckedModeBanner: false,));
}
