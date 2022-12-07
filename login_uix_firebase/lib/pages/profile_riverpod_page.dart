import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:login_uix_firebase/provider/profile_provider.dart/edit_user_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider.dart/user_profile_provider.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';

class ProfileRiverpodPage extends ConsumerWidget {
  static const routeName = '/profilePageRiverpod';

  const ProfileRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final lastsNameController = TextEditingController();
    final dateofbirthController = TextEditingController();
    final phonenumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("dasdsadsa"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userData = ref.watch(
            userDetailProvider,
          );
          return Center(
            child: userData.when(
              data: (data) {
                String? namef = data?['firstName'];
                String? namel = data?['lastName'];
                String? phone = data?['phoneNumber'];
                String? dob = data?['dateofbirth'];

                nameController.text = namef ?? '';
                lastsNameController.text = namel ?? '';
                phonenumberController.text = phone.toString();
                dateofbirthController.text = dob ?? '';

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
                                                // onTap: () async {
                                                //   String path =
                                                //       pickImageCamera().toString();
                                                //   Uint8List imageData =
                                                //       await XFile(path)
                                                //           .readAsBytes();
                                                // },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Colors.purpleAccent,
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
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Colors.purpleAccent,
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
                                                // onTap: () {
                                                //   setState(() {
                                                //     imgXFile = null;
                                                //     imgExist = false;
                                                //   });
                                                // },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color:
                                                            Colors.purpleAccent,
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
                    Text('signed in as: ' + data?['email']),
                    SizedBox(height: 20),
                    Text('Role: ' + data?['roles']),
                    SizedBox(height: 20),
                    Text('Client Type: ' + data?['clientType']),
                    SizedBox(height: 20),
                    Text('Client Code: ' + data?['clientcode']),
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

                          dateofbirthController.text =
                              formattedDate; //set output date to TextField value.

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
                      onPressed: () async {
                        UserData userData = UserData(
                          id: FirebaseAuth.instance.currentUser!.uid,
                          firstName: nameController.text,
                          lastName: lastsNameController.text,
                          doBirth: dateofbirthController.text,
                          phoneNumber: phonenumberController.text,
                        );
                        await ref
                            .read(editUserProvider.notifier)
                            .editUser(userData: userData);
                        print(userData.toMap());
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
              },
              error: (error, stackTrace) => Text('Error ??' '$error'),
              loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
      // body: Consumer(
      //   builder: (context, ref, child) {
      //     final userData = ref.watch(
      //       userDetailProvider,
      //     );
      //     return Center(
      //       child: userData.when(
      //         data: (data) {
      //           return Column(
      //             children: [
      //               Text(
      //                 data?['firstName'],
      //                 style: const TextStyle(
      //                   fontSize: 40,
      //                 ),
      //               ),
      //               SizedBox(height: 10),
      //               Text(data?['email']),
      //               SizedBox(height: 20),
      //               Text(data?['roles']),
      //               SizedBox(height: 20),
      //               Text(data?['clientType']),
      //               SizedBox(height: 20),
      //               Text(data?['clientcode']),
      //               SizedBox(height: 20),
      //             ],
      //           );
      //         },
      //         error: (error, stackTrace) => Text('Error ??' '$error'),
      //         loading: () => const Padding(
      //           padding: EdgeInsets.all(8.0),
      //           child: CircularProgressIndicator(),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
