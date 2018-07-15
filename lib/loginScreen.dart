import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_dabba/SecondScreen.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInScreenState();
  }
}



class LogInScreenState extends State<LogIn> {

  final TextEditingController _textEditingControllerUn = new TextEditingController();
  final TextEditingController _textEditingControllerPw = new TextEditingController();

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

  signFunction() {
    signInWithGoogle();
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

  Widget _buildEditText() {
    Stack _returnStack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/back.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
            ),
          ),
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            //color: Color.fromRGBO(51, 17, 0, 0.4),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25.0),
            //boxShadow: [BoxShadow(color: Colors.black, blurRadius: 30.0),],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: RaisedButton(
                  onPressed: () => signFunction(),
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text('Log In with Google', style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 30.0, fontWeight: FontWeight.w100,),),
                  ),
                  elevation: 10.0,
                  highlightElevation: 25.0,
                  highlightColor: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return _returnStack;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _buildEditText(),
    );
  }
}
