import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_dabba/loginScreen.dart';

class SignOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new so();
  }
}

class so extends State<SignOut> {
  GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return new Text('hello');
  }

  @override
  void initState() {
    super.initState();
    signOut();
  }

  Future<LogIn>signOut() async {
    await FirebaseAuth.instance.signOut();
    //GoogleSignIn.games().signOut();
    return new LogIn();
  }
}