import 'package:ToDo_bloc/drawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('About')), drawer: MainDrawer(),
    body:Column(children: [Text('')]));
  }
}
