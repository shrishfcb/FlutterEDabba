import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_dabba/MainUI.dart';
import 'package:e_dabba/MainUIVeg.dart';
import 'package:e_dabba/SignOut.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Non-Veg", Icons.rss_feed),
    new DrawerItem("Veg", Icons.local_pizza),
    new DrawerItem("Sign Out", Icons.adb)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  FirebaseUser user;
  FirebaseAuth _auth;
  String name="";

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    getUser();
  }


  getUser() async {
    user = await _auth.currentUser();
    name = user.displayName;
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainUI();
      case 1:
        return new MainUIVeg();
      case 3:
        return new SignOut();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(name), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}