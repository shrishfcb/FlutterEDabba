import 'package:flutter/material.dart';
import 'package:e_dabba/MenuBVeg.dart';
import 'package:e_dabba/MenuDVeg.dart';
import 'package:e_dabba/MenuLVeg.dart';

class MainUIVeg extends StatelessWidget {
  final TabBarView t1 = TabBarView(
    children: [
      MenuBVeg(),
      MenuLVeg(),
      MenuDVeg(),
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