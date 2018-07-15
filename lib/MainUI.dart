import 'package:flutter/material.dart';
import 'package:e_dabba/Menu.dart';
import 'package:e_dabba/MenuDNVeg.dart';
import 'package:e_dabba/MenuLNVeg.dart';

class MainUI extends StatelessWidget {
  final TabBarView t1 = TabBarView(
    children: [
      MenuPage(),
      MenuLNVeg(),
      MenuDNVeg(),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(77, 40, 0, 0.9),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Breakfast'),
              Tab(text: 'Lunch'),
              Tab(text: 'Dinner'),
            ],
          ),
          //title: Text('E_Dabba'),
        ),
        body: t1,
      ),
    );
  }
}