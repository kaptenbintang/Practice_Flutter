// import 'dart:html';
import 'dart:io' show file;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/delete_account_page.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';
import 'package:image_picker/image_picker.dart';
import 'change_pw_page.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final lastsNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  bool imgExist = false;

  String? url;

  var uid;
  var fName, lName, age;

  File? fImage;

  XFile? imgXFile;

  Future<void> getDataFromDb() async {
    if (auth.currentUser != null) {
      uid = auth.currentUser?.uid;

      // var a = await db.collection("users").doc(uid).get();
      // return a.data();
      // then((DocumentSnapshot doc) {
      // final data = doc.data() as Map<String, dynamic>;
      // String fName = data['first name'];
      // print(uid + 'UID');
      // return data;
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text('halo: $fName'),
      //     );
      //   },
      // );
      await db.collection("users").doc(uid).get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        fName = data["firstName"];
        lName = data["lastName"];
        age = data["age"];
      });
      setState(() {
        emailController.text = user.email.toString();
        nameController.text = fName;
        lastsNameController.text = lName;
        ageController.text = age.toString();
      });
    }
    ;
  }

  @override
  void initState() {
    getDataFromDb();
    super.initState();
  }

  Future editUserDetails(String uid, String firstName, String lastName,
      String email, int age) async {
    final ref = storage.ref().child('usersImage').child('$uid.jpg');
    File file = File(imgXFile!.path);
    await ref.putFile(file);

    url = await ref.getDownloadURL();
    print(email);
    await auth.currentUser?.updateEmail(email);
    await db.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'imageUrl': url,
    }).onError((error, stackTrace) => print("Error writing document: $error"));
  }

  Future editUserData() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        SnackBar(
          content: const Text('There is no User Login'),
        );
      } else {
        uid = auth.currentUser?.uid;
        editUserDetails(
          uid,
          nameController.text.trim(),
          lastsNameController.text.trim(),
          emailController.text.trim(),
          int.parse(ageController.text.trim()),
        );
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Your personal details has been updated"),
              );
            });
        print("aku");
      }
    });
  }

  Future<String?> pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);
    // final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imgXFile = pickedImage;
      imgExist = true;
    });
    Navigator.pop(context);
    return pickedImage?.path;
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(future: db.collection("users").doc(uid).get(),builder: (context, DocumentSnapshot snapshot){ final data = snapshot.data() as Map<String, dynamic>;};);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          child: imgExist
                              ? kIsWeb
                                  ? Image.network(imgXFile!.path)
                                  : Image.file(File(imgXFile!.path))
                              : Icon(Icons.person),
                          // kIsWeb
                          //     ? Image.file(File(imgXFile!.path))
                          //     : Icon(Icons.person),
                          // child: kIsWeb
                          //     ? Image.network(_imageFileList![0].path)
                          //     : Image.file(File(_imageFileList![0].path)),
                          radius: 65,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 110,
                      child: RawMaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Choose Option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.lightBlue),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          String path =
                                              pickImageCamera().toString();
                                          Uint8List imageData =
                                              await XFile(path).readAsBytes();
                                        },
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Remove',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        elevation: 10,
                        fillColor: Colors.grey.shade300,
                        child: Icon(Icons.add_a_photo),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('signed in as: ' + user.email!),
            SizedBox(height: 20),
            ProfileTextInput(
              textEditingController: nameController,
              hintTextString: 'Enter Name',
              maxLength: 20,
              labelText: 'Name',
              obscure: false,
            ),
            SizedBox(height: 20),
            ProfileTextInput(
              textEditingController: lastsNameController,
              hintTextString: 'Enter Last Name',
              maxLength: 40,
              labelText: 'Last Name',
              obscure: false,
            ),
            SizedBox(height: 20),
            ProfileTextInput(
              textEditingController: emailController,
              hintTextString: 'Enter Email',
              maxLength: 20,
              labelText: 'Email',
              obscure: false,
            ),
            SizedBox(height: 20),
            ProfileTextInput(
              textEditingController: ageController,
              hintTextString: 'Enter Age',
              maxLength: 3,
              labelText: 'Age',
              obscure: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                editUserData();
                print('User : $user');
              },
              child: const Text('Update'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteAccount(),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return changePasswordPage();
                      },
                    ),
                  );
                },
                child: const Text('Change Password')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign Out'),
            ),
            // buildProgress(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    lastsNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
