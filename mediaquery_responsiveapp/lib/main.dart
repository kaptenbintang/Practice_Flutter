import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Media Query"),
      ),
      //penulisan if disini menggunakan (isinya) lalu ? jika tidak menggunakan :
      //if media query orientation portrait maka dia akan return column jika tidak makan aka return row
      body: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? Column(
              children: generateContainers, //refractor menggunakan extra method
            )
          : Row(
              children: generateContainers,
            ),
      // body: Container(
      //   color: Colors.red,
      //   // lebar sepertiga dari layar dan tinggi setengah dari layar jadi klo nanti layarnya ganti ganti nanti di akan ngikutin layar devicenya
      //   width: MediaQuery.of(context).size.width / 3,
      //   height: MediaQuery.of(context).size.height / 2,
      // ),
    );
  }

//hasil dari refractor extra method dengan nama generateContainers
  List<Widget> get generateContainers {
    return [
      Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
      Container(
        color: Colors.green,
        width: 100,
        height: 100,
      ),
      Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      ),
    ];
  }
}
