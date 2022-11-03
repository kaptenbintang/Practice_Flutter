import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(
        indicatorColor: Colors.red,
        indicator: BoxDecoration(
            color: Colors.red,
            border: Border(top: BorderSide(color: Colors.purple, width: 5))),
        tabs: [
          Tab(
            icon: Icon(Icons.comment),
            text: "Comments",
          ),
          Tab(
            icon: Icon(Icons.computer),
            text: "Computers",
          ),
        ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Contoh Tab Bar"),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
                  child: Container(color: Colors.amber, child: myTabBar))),
          body: TabBarView(children: [
            Center(
              child: Text("tab 1"),
            ),
            Center(
              child: Text("tab 2"),
            ),
          ]),
        ),
      ),
    );
  }
}
