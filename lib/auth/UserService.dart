import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'User.dart';

class AuthService {
  String email;
  String password;
  AuthService({this.email, this.password});
  final FirebaseAuth _auth = FirebaseAuth.instance;

//sign in with email and password

  Future logIn() async {
    try {
      (await _auth.signInWithEmailAndPassword(
        email: this.email,
        password: this.password,
      ))
          .user;

      return true;
    } catch (e) {
      print("error:${e}");
      return e.message;
    }
  }

//register with email and password
  Future signUp() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: this.email,
        password: this.password,
      ))
          .user;
      return true;
    } catch (e) {
      print("error:${e}");
      return e.message;
    }
  }

//sgin out

  void signOut(context) async {
    await _auth.signOut();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppUser()));
  }

  String userData() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    return uid;
  }
}
