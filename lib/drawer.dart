import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon,String title,Function tapHandler){
    return ListTile(
            leading: Icon(icon, size: 26),
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              tapHandler();
            },
          );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Text(
              'To Do!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(Icons.check, 'Home',() {Navigator.of(context).pushReplacementNamed('/');}),
          buildListTile(Icons.check,'Completed',() {Navigator.of(context).pushReplacementNamed('/completed');}),
          buildListTile(Icons.check,'In Completed',() {Navigator.of(context).pushReplacementNamed('/incomplete');})
        ],
      ),
    );
  }
}
