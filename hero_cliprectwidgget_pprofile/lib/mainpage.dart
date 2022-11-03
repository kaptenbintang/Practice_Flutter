import 'package:flutter/material.dart';
import 'package:hero_cliprectwidgget_pprofile/secondpage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "latihan hero animation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondPage();
          }));
        },
        child: Hero(
          tag: 'pp',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                width: 100,
                height: 100,
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
