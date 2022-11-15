// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';

import '../main.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/mainPage';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class DoctorItem extends StatelessWidget {
  final String image;
  final String name;
  final String specialist;
  const DoctorItem({
    Key? key,
    required this.image,
    required this.name,
    required this.specialist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
            color: const Color.fromARGB(95, 179, 173, 173),
            borderRadius: BorderRadius.circular(15.0)),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$name",
              overflow: TextOverflow.fade,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              specialist,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

class SpecialistItem extends StatelessWidget {
  final String imagePath;
  final String imageName;
  const SpecialistItem({
    Key? key,
    required this.imagePath,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(95, 179, 173, 173),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 32,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            imageName,
            style: const TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}

class _MainPageState extends State<MainPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  // final auth = FirebaseAuth.instance;
  // final db = FirebaseFirestore.instance;
  // var uid;
  // var fName, lName, age;

  // Future<void> getDataFromDb() async {
  //   if (auth.currentUser != null) {
  //     uid = auth.currentUser?.uid;
  //     await db.collection("users").doc(uid).get().then((DocumentSnapshot doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       fName = data["firstName"];
  //       lName = data["lastName"];
  //       age = data["age"];
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   getDataFromDb();
  //   super.initState();
  // }

  // CollectionReference _getUsername =
  //     FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: Colors.blueAccent,
      //   items: <Widget>[
      //     Icon(Icons.home_outlined, size: 30),
      //     Icon(Icons.calendar_month_outlined, size: 30),
      //     Icon(Icons.chat_bubble_outline, size: 30),
      //     Icon(Icons.notifications_none_outlined, size: 30),
      //   ],
      //   onTap: (index) {
      //     //Handle button tap
      //   },
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // StreamBuilder<QuerySnapshot>(
                  //     stream: _getUsername.snapshots(),
                  //     builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Center(child: Text(snapshot.error.toString()));
                  //       }
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.active) {
                  //         QuerySnapshot querySnapshot = snapshot.data;
                  //       }
                  //       return Center(child: CircularProgressIndicator());
                  //     })),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProfilePage.routeName);
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("lib/icons/user.png"),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(95, 179, 173, 173),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "lib/icons/consultation.png",
                      width: 92,
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How do you feel?",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          width: 120,
                          child: Text(
                            "Fill out your medical right now",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 35,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: const Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 64,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(95, 179, 173, 173),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 32,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "How can we help you?",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SpecialistItem(
                      imagePath: "lib/icons/calendar.png",
                      imageName: "Booking",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "lib/icons/calendar.png",
                      imageName: "Booking",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "lib/icons/calendar.png",
                      imageName: "Booking",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "lib/icons/calendar.png",
                      imageName: "Booking",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Consultant list",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DoctorItem(
                      image: "lib/images/doctor.png",
                      name: "Bintang",
                      specialist: "Consultant",
                    ),
                    DoctorItem(
                      image: "lib/images/doctor.png",
                      name: "Gilland",
                      specialist: "Consultant",
                    ),
                    DoctorItem(
                      image: "lib/images/doctor.png",
                      name: "Zul",
                      specialist: "Consultant",
                    ),
                    DoctorItem(
                      image: "lib/images/doctor.png",
                      name: "test",
                      specialist: "Consultant",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//test123
