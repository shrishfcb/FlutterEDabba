import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:e_dabba/Final.dart';

String uid;
class MenuLVeg extends StatefulWidget {
  @override
  _MenuPageState createState() => new _MenuPageState();
}


class Breakfast {
  final String key;
  String p1,p2,d1,d2,d3;

  Breakfast.fromJson(this.key, Map data) {
    p1 = data['primary1'];
    p2 = data['primary2'];
    d1 = data['drink1'];
    d2 = data['drink2'];
  }
}


class getFromFirebase {
  static Future<Breakfast> getBreakfastOnce(String type) async {
    Completer<Breakfast> completer = new Completer<Breakfast>();

    FirebaseDatabase.instance
        .reference()
        .child("Menu")
        .child("Lunch")
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

class _MenuPageState extends State<MenuLVeg> {
  int currentValue=0;
  int currentValue2=0;
  int currentValue3=0;

  FirebaseUser user;
  FirebaseAuth _auth;

  String bp1 = "Selection 1";
  String bp2 = "Selection 2";
  String bd1 = "Selection 1";
  String bd2 = "Selection 2";
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    getUser();
    getFromFirebase.getBreakfastOnce("Veg").then(_updateBreakfast);
  }

  _updateBreakfast(Breakfast value) {
    var p1 = value.p1;
    var p2 = value.p2;
    var d1 = value.d1;
    var d2 = value.d2;
    setState(() {
      bp1 = p1;
      bp2 = p2;
      bd1 = d1;
      bd2 = d2;
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
                      child: Text('Select Your Dish:', style: TextStyle(fontFamily: 'Raleway' ,fontSize: 25.0,)),
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
                        Text(bp1,style: TextStyle(fontFamily: 'Raleway'),),
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
                        Text(bp2, style: TextStyle(fontFamily: 'Raleway'),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,),
                      child: Text('Selection Your Drink:', style: TextStyle(fontFamily: 'Raleway',fontSize: 25.0,),),
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
                      child: Text('Every tiffin will have included: Veg Fruit Salad (made with regional fruits) and Salad masala', style: TextStyle(fontFamily: 'Raleway' ,fontSize: 20.0,),),
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