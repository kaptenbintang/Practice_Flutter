import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.green,
          body: Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: [
                buildCard(Icons.account_box, "Account Box", Colors.amber),
                buildCard(Icons.adb, "Android Bugs", Colors.green)
              ],
            ),
          )),
    );
  }

  Card buildCard(IconData iconData, String text, Color color) {
    return Card(
      elevation: 10,
      child: Row(children: [
        Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              iconData,
              color: color,
            )),
        Text(text)
      ]),
    );
  }
}
