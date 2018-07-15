import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_dabba/SecondScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  GoogleSignInAccount user = _googleSignIn.currentUser;
  if (user == null) {
    user = await _googleSignIn.signInSilently();
  }
  if (user==null) {
    user = await _googleSignIn.signIn();
  }

  final GoogleSignInAuthentication auth = await user.authentication;

  final FirebaseUser firebaseUser = await _auth.signInWithGoogle(
    idToken: auth.idToken,
    accessToken: auth.accessToken,
  );

  assert (firebaseUser!=null);
  assert (!firebaseUser.isAnonymous);

  print("UserName: ${firebaseUser.displayName}");
  return firebaseUser;
}

Future<Null> signOutWithGoogle() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
}

class SplashPage extends StatefulWidget {
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Listen for our auth event (on reload or start)
    // Go to our /todos page once logged in
    _auth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      //Navigator.of(context).pushReplacementNamed('/todos');
      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
    });

    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 1))
        .then((_) => signInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new SizedBox(width: 20.0),
              new Text("Please wait..."),
            ],
          ),
        ],
      ),
    );
  }
}