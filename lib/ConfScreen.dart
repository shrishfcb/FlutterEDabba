import 'package:flutter/material.dart';
import 'package:e_dabba/loginScreen.dart';
import 'package:e_dabba/MainUI.dart';
import 'package:e_dabba/Final.dart';
import 'package:e_dabba/GoogleSignIn.dart';
import 'package:e_dabba/SideNavBar.dart';

void main() => runApp(new ConfScreen());

class ConfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Dabba',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.indigo[75],
        brightness: Brightness.dark,
        canvasColor: Colors.brown.withOpacity(0.5),
      ),
      home: Confirmed(),
    );
  }
}

