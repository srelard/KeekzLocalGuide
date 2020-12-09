import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:keekz_local_guide/models/user_data.dart';
import 'package:provider/provider.dart';

class AuthService {
  static final _auth = auth.FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      auth.UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.User signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logout() {
    _auth.signOut();
  }

  static void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
