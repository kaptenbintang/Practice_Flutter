// import 'dart:io' show file;
// import 'dart:io';
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:html' as html;
import 'dart:io' as ios;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/helper/database_service.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:login_uix_firebase/pages/delete_account_page.dart';

import 'package:login_uix_firebase/widgets/profile_text_input.dart';

import '../main.dart';
import 'change_pw_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profilePage';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataService service = DataService();

  final nameController = TextEditingController();
  final lastsNameController = TextEditingController();
  final emailController = TextEditingController();
  // final ageController = TextEditingController();
  final dateofbirthController = TextEditingController();
  final phonenumberController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  Future<Map<String, dynamic>>? currentUserData;
  Map<String, dynamic>? retrievedUserData;

  var uid;
  var fName,
      lName,
      age,
      uEmail,
      img,
      role,
      dob,
      phNumb,
      clientCode,
      clientTypes;
  bool imgExist = false;

  String? url;

  html.File? fImage;

  XFile? imgXFile;

  Uint8List webImage = Uint8List(10);

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
        img = data["imageUrl"];
        role = data["roles"];
        dob = data["dateofbirth"];
        phNumb = data["phoneNumber"];
        clientCode = data["clientcode"];
        clientTypes = data["clientType"];
      });
      setState(() {
        // if (img != null) {}
        emailController.text = user.email.toString();
        nameController.text = fName;
        lastsNameController.text = lName;
        dateofbirthController.text = dob;
        phonenumberController.text = phNumb;
        // ageController.text = age.toString();
      });
    }
    ;
  }

  @override
  void initState() {
    _initRetrieval();
    // getDataFromDb();
    super.initState();
  }

  Future<void> _initRetrieval() async {
    currentUserData = service.currentUsers(user.uid);
    retrievedUserData = await service.currentUsers(user.uid);
    // print(retrievedUserData!['id']);
    fName = retrievedUserData!["firstName"];
    lName = retrievedUserData!["lastName"];
    age = retrievedUserData!["age"];
    img = retrievedUserData!["imageUrl"];
    role = retrievedUserData!["roles"];
    dob = retrievedUserData!["dateofbirth"];
    phNumb = retrievedUserData!["phoneNumber"];
    clientCode = retrievedUserData!["clientcode"];
    clientTypes = retrievedUserData!["clientType"];

    emailController.text = user.email.toString();
    nameController.text = fName;
    lastsNameController.text = lName;
    dateofbirthController.text = dob;
    phonenumberController.text = phNumb;
  }

  Future editUserDetails(String uid, String firstName, String lastName,
      String email, String dateofbirth, String phNumb) async {
    if (imgExist) {
      final ref = storage.ref().child('usersImage').child('$uid.jpg');
      // html.File file = ios.File(imgXFile.path);

      await ref.putData(webImage);

      url = await ref.getDownloadURL();

      await auth.currentUser?.updateEmail(email);
      UserData userData = UserData(
        firstName: firstName,
        lastName: lastName,
        emailUser: email,
        doBirth: dateofbirth,
        phoneNumber: phNumb,
        // imgUrl: url
      );

      await service.updateUser(userData).onError(
            (error, stackTrace) => print("Error writing document: $error"),
          );
    } else {
      UserData userData = UserData(
        firstName: firstName,
        lastName: lastName,
        emailUser: email,
        doBirth: dateofbirth,
        phoneNumber: phNumb,
        // imgUrl: ""
      );

      await auth.currentUser?.updateEmail(email).then((value) async {
        await service.updateUser(userData).onError(
            (error, stackTrace) => print("Error writing document: $error"));
      });
    }
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
          dateofbirthController.text.trim(),
          phonenumberController.text.trim(),
          // int.parse(ageController.text.trim()),
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

    var f = await pickedImage!.readAsBytes();

    setState(() {
      imgXFile = pickedImage;
      webImage = f;
      imgExist = true;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(future: db.collection("users").doc(uid).get(),builder: (context, DocumentSnapshot snapshot){ final data = snapshot.data() as Map<String, dynamic>;};);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: FutureBuilder(
        future: currentUserData,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
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
                          margin: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          child: CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              child:
                                  // imgExist
                                  // ? kIsWeb
                                  //     ? Image.memory(webImage)
                                  //     : Image.file(new ios.File(imgXFile!.path))
                                  // :
                                  Icon(Icons.person),
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
                                                  await XFile(path)
                                                      .readAsBytes();
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                imgXFile = null;
                                                imgExist = false;
                                              });
                                            },
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                Text('signed in as: ' + user.email.toString()),
                SizedBox(height: 20),
                Text('Role: ' + role),
                SizedBox(height: 20),
                Text('Client Type: ' + clientTypes),
                SizedBox(height: 20),
                Text('Client Code: ' + clientCode),
                SizedBox(height: 20),
                ProfileTextInput(
                  textEditingController: nameController,
                  hintTextString: 'Enter Name',
                  maxLength: 20,
                  labelText: 'First Name',
                  obscure: false,
                  readonly: false,
                ),
                SizedBox(height: 20),
                ProfileTextInput(
                  textEditingController: lastsNameController,
                  hintTextString: 'Enter Last Name',
                  maxLength: 40,
                  labelText: 'Last Name',
                  obscure: false,
                  readonly: false,
                ),
                SizedBox(height: 20),
                // ProfileTextInput(
                //   textEditingController: emailController,
                //   hintTextString: 'Enter Email',
                //   maxLength: 20,
                //   labelText: 'Email',
                //   obscure: false,
                // ),
                // SizedBox(height: 20),

                ProfileTextInput(
                  textEditingController: dateofbirthController,
                  hintTextString: 'Enter Date',
                  maxLength: 20,
                  labelText: 'Date of Birth',
                  obscure: false,
                  readonly: true,
                  fungsitap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            1950), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateofbirthController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                // SizedBox(height: 20),
                // ProfileTextInput(
                //   textEditingController: ageController,
                //   hintTextString: 'Enter Age',
                //   maxLength: 3,
                //   labelText: 'Age',
                //   obscure: false,
                // ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: IntlPhoneField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11)
                    ],
                    controller: phonenumberController,
                    showCountryFlag: true,
                    showDropdownIcon: true,
                    initialCountryCode: 'MY',
                    disableLengthCheck: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.toString().isEmpty) {
                        return "Enter correct phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    editUserData();
                    print('eeeeeeeeeeeee');
                  },
                  child: const Text('Update'),
                ),
                SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const DeleteAccount(),
                //       ),
                //     );
                //   },
                //   child: const Text('Delete'),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) {
                //             return changePasswordPage();
                //           },
                //         ),
                //       );
                //     },
                //     child: const Text('Change Password')),
                // SizedBox(
                //   height: 20,
                // ),
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, ControllerPage.routeName);
                      // ControllerPage();
                    },
                    child: const Text('Sign Out'))
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              retrievedUserData!.isEmpty) {
            return Center(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const <Widget>[
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('No Data Availble'),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    lastsNameController.dispose();
    emailController.dispose();
    dateofbirthController.dispose();
    phonenumberController.dispose();
    // ageController.dispose();
    super.dispose();
  }
}

//testing branch baru
