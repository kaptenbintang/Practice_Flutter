import 'package:flutter/material.dart';
import 'package:httprequest_api/post_result_model.dart';
import 'package:httprequest_api/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic postResult = null;
  dynamic user = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("API demo")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text((postResult != null)
                ? postResult.id +
                    " | " +
                    postResult.name +
                    " | " +
                    postResult.job +
                    " | " +
                    postResult.created
                : "tidak ada data"),
            ElevatedButton(
                onPressed: () {
                  PostResult.connectToAPI("Badu", "Dokter").then((value) {
                    postResult = value;
                    setState(() {});
                  });
                },
                child: Text("Post")),
            ElevatedButton(
                onPressed: () {
                  User.connectToAPI("5").then((value) {
                    user = value;
                    setState(() {});
                  });
                },
                child: Text("get"))
          ],
        )),
      ),
    );
  }
}
