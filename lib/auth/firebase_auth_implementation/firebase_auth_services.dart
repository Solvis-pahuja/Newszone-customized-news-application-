import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance.collection("Users").doc(credentials.user!.email).set(
          {
            'username' : email.split('@')[0].toString()
          });
      return credentials.user;
    } catch (e) {
      print("some error occured ");
    }
    return null;
  }

  Future<User?> loginwithEmailandPassword(String email, String password) async {
    try {
      UserCredential credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user;
    } catch (e) {
      print("some error occured ");
    }
    return null;
  }
}
