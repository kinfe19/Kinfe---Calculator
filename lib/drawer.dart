import 'package:flutter/material.dart';
import 'main.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Sidepanel',
            style: TextStyle(fontSize: 25),
          ),
          decoration: BoxDecoration(
            color: Colors.deepPurple[300],
          ),
        ),
        ListTile(
          title: Text('Normal Calculator'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        ListTile(
          title: Text('Scientific Calculator'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SCalculator()));
          },
        ),
        ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            }),
      ],
    ),
  );
}
