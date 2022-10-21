import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "latihan hero animation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'pp',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
                width: 200,
                height: 200,
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://thumbs.dreamstime.com/z/portrait-smart-male-profile-symbol-portrait-smart-male-profile-symbol-minimal-cartoon-style-166146967.jpg"))),
          ),
        ),
      ),
    );
  }
}
