import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 203, 203),
      body: Stack(
        children: [
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF6dA7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBigDiameter(context) / 4,
            top: -getBigDiameter(context) / 4,
            child: Container(
              child: Center(
                  child: Text(
                "dribble",
                style: TextStyle(
                    fontFamily: "Pacifico", fontSize: 30, color: Colors.white),
              )),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBigDiameter(context) / 2,
            bottom: -getBigDiameter(context) / 2,
            child: Container(
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(children: [
                    TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Color(0xFFFF4891)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF4891))),
                          labelText: "Email: ",
                          labelStyle: TextStyle(color: Color(0xFFFF4891))),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFF4891))),
                          labelText: "Password: ",
                          labelStyle: TextStyle(color: Color(0xFFFF4891))),
                    )
                  ]),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color(0xFFFF4891), fontSize: 11),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [Color(0xFFB226B2), Color(0xFFFF4891)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        onPressed: () {},
                        child: Image(
                          image: AssetImage("assets/facebook.png"),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        onPressed: () {},
                        child: Image(image: AssetImage("assets/twitter.png")),
                      ),
                    ],
                    // children: [
                    //   Material(
                    //     borderRadius: BorderRadius.circular(20),
                    //     elevation: 2,
                    //     child: Container(
                    //       width: 150,
                    //       height: 40,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           gradient: LinearGradient(
                    //               colors: [Colors.purple, Colors.pink],
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomCenter)),
                    //       child: Material(
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: Colors.transparent,
                    //         child: InkWell(
                    //           splashColor: Colors.amber,
                    //           borderRadius: BorderRadius.circular(20),
                    //           onTap: () {},
                    //           child: Center(
                    //               child: Text(
                    //             "Sign In",
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.w600),
                    //           )),
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    // ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account? ",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.pink,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
