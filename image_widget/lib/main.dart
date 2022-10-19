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
        appBar: AppBar(
          title: Text("Latihan Image Widget"),
        ),
        body: Center(
            child: Container(
          color: Colors.black,
          width: 200,
          height: 200,
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage("assets/test.jpeg"),
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
          ),
        )),
      ),
    );
  }
}
