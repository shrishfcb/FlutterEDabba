import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:e_dabba/Final.dart';

String uid;
class MenuDVeg extends StatefulWidget {
  @override
  _MenuPageState createState() => new _MenuPageState();
}


class Breakfast {
  final String key;
  String ps,vs,d1,d2,r1,r2;

  Breakfast.fromJson(this.key, Map data) {
    ps = data['paneer_subzi'];
    vs = data['veg_subzi'];
    d1 = data['dessert1'];
    d2 = data['dessert2'];
    r1 = data['roti1'];
    r2 = data['roti2'];
  }
}


class getFromFirebase {
  static Future<Breakfast> getBreakfastOnce(String type) async {
    Completer<Breakfast> completer = new Completer<Breakfast>();

    FirebaseDatabase.instance
        .reference()
        .child("Menu")
        .child("Dinner")
        .child(type)
        .once()
        .then((DataSnapshot snapShot) {
      var breakfast = new Breakfast.fromJson(snapShot.key, snapShot.value);
      completer.complete(breakfast);
    });

    return completer.future;
  }
  static Future<void> addOrder() async {
    FirebaseDatabase.instance
        .reference()
        .child("Orders")
        .child(uid)
        .set({
      "type": "abc",
      "sel1": "pqr",
      "sel2": "xyz",
    });
    return new Confirmed();
  }
}

class _MenuPageState extends State<MenuDVeg> {
  int currentValue=0;
  int currentValue2=0;
  int currentValue3=0;

  FirebaseUser user;
  FirebaseAuth _auth;

  String bp1 = "Selection 1";
  String bp2 = "Selection 2";
  String bd1 = "Selection 1";
  String bd2 = "Selection 2";
  String br1 = "Selection 1";
  String br2 = "Selection 2";

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    getUser();
    getFromFirebase.getBreakfastOnce("Veg").then(_updateBreakfast);
  }

  _updateBreakfast(Breakfast value) {
    var p1 = value.ps;
    var p2 = value.vs;
    var d1 = value.d1;
    var d2 = value.d2;
    var r1 = value.r1;
    var r2 = value.r2;
    setState(() {
      bp1 = p1;
      bp2 = p2;
      bd1 = d1;
      bd2 = d2;
      br1 = r1;
      br2 = r2;
    });
  }


  getUser() async {
    user = await _auth.currentUser();
    uid = user.uid;
  }



  void handleChanged(int value) {
    setState(() {
      currentValue = value;
    });
  }
  void handle2(int value) {
    setState(() {
      currentValue2 = value;
    });
  }
  void handle3(int value) {
    setState(() {
      currentValue3=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Select Your Roti Type:', style: TextStyle(fontFamily: 'Raleway' ,fontSize: 25.0,)),
                    ),
                    Row (
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Radio<int>(
                            value: 0,
                            groupValue: currentValue,
                            onChanged: handleChanged,
                          ),
                        ),
                        Text(br1,style: TextStyle(fontFamily: 'Raleway'),),
                      ],
                    ),
                    Row (
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          child: Radio<int>(
                            value: 1,
                            groupValue: currentValue,
                            onChanged: handleChanged,
                          ),
                        ),
                        Text(br2, style: TextStyle(fontFamily: 'Raleway'),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,),
                      child: Text('Select Your Dessert:', style: TextStyle(fontFamily: 'Raleway',fontSize: 25.0,),),
                    ),
                    Row (
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Radio<int>(
                            value: 0,
                            groupValue: currentValue2,
                            onChanged: handle2,
                          ),
                        ),
                        Text(bd1,style: TextStyle(fontFamily: 'Raleway'),),
                      ],
                    ),
                    Row (
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          child: Radio<int>(
                            value: 1,
                            groupValue: currentValue2,
                            onChanged: handle2,
                          ),
                        ),
                        Text(bd2,style: TextStyle(fontFamily: 'Raleway'),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Today\'s subzi: ${bp1} and ${bp2}, along with papad and salad ' , style: TextStyle(fontFamily: 'Raleway' ,fontSize: 20.0,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () => getUser(),
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Text('Submit', style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 15.0, fontWeight: FontWeight.w100,),),
                          ),
                          elevation: 10.0,
                          highlightElevation: 25.0,
                          highlightColor: Colors.indigo,
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}