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
          title: Text("Latihan Stack dan align"),
        ),
        body: Stack(children: [
          Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(color: Colors.white),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(color: Colors.black12),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(color: Colors.black12),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
          ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Ini adalah Text yang ada di lapisan tengah dari stack.",
                      style: TextStyle(fontSize: 55),
                    ),
                  ),
                ],
              )
            ],
          ),
          Align(
              alignment: Alignment(0.2, 0.75),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("My Button"),
                style: ElevatedButton.styleFrom(primary: Colors.amber),
              ))
        ]),
      ),
    );
  }
}
