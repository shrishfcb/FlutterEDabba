import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:e_dabba/SideNavBar.dart';

class Confirmed extends StatefulWidget {
  @override
  ConfirmedState createState() => new ConfirmedState();
}
String uid;
class ConfirmedState extends State<Confirmed>
{
  FirebaseUser user;
  FirebaseAuth _auth;

  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    getUser();
  }

  getUser() async {
    user = await _auth.currentUser();
    uid = user.uid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConfirmPage(),
    );
  }
}

class ConfirmPage extends StatefulWidget {
  ConState createState() => new ConState();
}

class ConState extends State<ConfirmPage> {
  static Future<void> delOrder(String uid) async {
    FirebaseDatabase.instance
        .reference()
        .child("Orders")
        .child(uid)
        .remove();
  }

  delData() {
    delOrder(uid);
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 300.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    onPressed: () => delData(),
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text('I have recieved my order', style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15.0, fontWeight: FontWeight.w100,),),
                    ),
                    elevation: 10.0,
                    highlightElevation: 25.0,
                    highlightColor: Colors.indigo,
                  ),
                ),
          ),
              )],
      ),
    ]),
    );
  }
}