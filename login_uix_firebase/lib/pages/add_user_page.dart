// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/database_service.dart';
import 'package:login_uix_firebase/model/roles_data.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';

class AddUserPage extends StatefulWidget {
  static const routeName = '/addUserPage';

  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  DataService service = DataService();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailNameController = TextEditingController();
  final _dobNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final searchDropRoles = TextEditingController();
  final countryDial = "0";

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String? selectedValue;
  String? selectedValueRoles;
  List<RolesData>? rolesList;

  final _formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();

  final searchDropClientType = TextEditingController();

  List<String> listOfValueRoles = [];

  List<String> listOfValue = [
    'satu',
    'dua',
    'tiga',
    'enam',
    'sembilan',
    'none',
    'unassigned',
  ];

  @override
  void initState() {
    _initRetrieval();
    super.initState();
  }

  Future _initRetrieval() async {
    rolesList = await service.retrieveRoles();
    setState(() {
      rolesList?.forEach((element) {
        listOfValueRoles.add(element.rolesName.toString());
      });
    });
  }

  Future signUp() async {
    String userUid;

    //authenticate user
    if (passwordConfirmed()) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

      try {
        //create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailNameController.text.trim(),
            password: _passwordController.text.trim());

        //add user details
        auth.authStateChanges().listen((User? user) {
          if (user == null) {
            SnackBar(
              content: const Text('There is no User Login'),
            );
          } else {
            userUid = user.uid;
            addUserDetails(
                userUid,
                _firstNameController.text.trim(),
                _lastNameController.text.trim(),
                _emailNameController.text.trim(),
                _phoneNumberController.text.trim(),
                _dobNameController.text.trim());
          }
        });
      } on FirebaseAuthException catch (e) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }
      Navigator.of(context).pop();
    }
  }

  Future addUserDetails(String uid, String firstName, String lastName,
      String email, String phoneNumber, String dateofbirth) async {
    await db.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      // 'age': age,
      'phoneNumber': countryDial + phoneNumber,
      'dateofbirth': dateofbirth,
      'roles': selectedValueRoles,
      'clientType': selectedValue,
      'clientcode': getLastInitials(_lastNameController.text.toString()) +
          getInitials(_firstNameController.text.toString()) +
          '-' +
          generateRandomString(2),
      'imageUrl': '',
      'createdAt': DateTime.now().toString(),
      'markDeleted': false,
    });
  }

  String getInitials(String _firstNameController) =>
      _firstNameController.contains(' ')
          ? _firstNameController
              .trim()
              .split(RegExp(' +'))
              .reversed
              .map((s) => s[0])
              .take(2)
              .join()
              .toUpperCase()
          : _firstNameController
                  .trim()
                  .split(RegExp(' +'))
                  .map((s) => s[0])
                  .take(1)
                  .join()
                  .toUpperCase() +
              _firstNameController
                  .trim()
                  .split(RegExp(' +'))
                  .map((s) => s[1])
                  .take(1)
                  .join()
                  .toUpperCase();

  String getLastInitials(String _lastNameController) =>
      _lastNameController.isNotEmpty
          ? _lastNameController
              .trim()
              .split(RegExp(' +'))
              .map((s) => s[0])
              .take(1)
              .join()
              .toUpperCase()
          : '';

  // Define a reusable function
  String generateRandomString(int length) {
    final random = Random();
    const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Your Password is not same, Please try again!"),
            );
          });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.person, size: 300.0),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Change Photo")),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ProfileTextInput(
                                          textEditingController:
                                              _firstNameController,
                                          hintTextString: 'Enter First Name',
                                          maxLength: 0,
                                          labelText: 'First Name',
                                          obscure: false,
                                          readonly: false),
                                    ),
                                    Expanded(
                                      child: ProfileTextInput(
                                          textEditingController:
                                              _lastNameController,
                                          hintTextString: 'Enter Last Name',
                                          maxLength: 0,
                                          labelText: 'Last Name',
                                          obscure: false,
                                          readonly: false),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    // height: 50,
                                    child: ProfileTextInput(
                                        hintTextString: 'Email',
                                        labelText: 'Email',
                                        obscure: false,
                                        readonly: false,
                                        maxLength: 10,
                                        textEditingController:
                                            _emailNameController),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    // height: 50,
                                    child: ProfileTextInput(
                                        hintTextString: 'Date of Birth',
                                        labelText: 'Date of Birth',
                                        obscure: false,
                                        readonly: false,
                                        maxLength: 10,
                                        textEditingController:
                                            _dobNameController),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    // height: 50,
                                    child: ProfileTextInput(
                                        hintTextString: 'Phone Number',
                                        labelText: 'Phone Number',
                                        obscure: false,
                                        readonly: false,
                                        maxLength: 10,
                                        textEditingController:
                                            _phoneNumberController),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField2(
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                        dropdownMaxHeight: 250,
                                        value: selectedValue,

                                        buttonDecoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        decoration: InputDecoration(
                                          //Add isDense true and zero Padding.
                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                          isDense: true,

                                          label: const Text("Client Type"),

                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select Client Type',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black45,
                                        ),
                                        iconSize: 30,
                                        buttonHeight: 50,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        items: listOfValue
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please Client Type.';
                                          }
                                        },
                                        onChanged:
                                            // authoRoles['canWriteAll'] != false
                                            // ?
                                            (value) {
                                          setState(() {
                                            selectedValue = value.toString();
                                          });
                                        },
                                        // : null,

                                        onSaved: (value) {
                                          selectedValue = value.toString();
                                        },
                                        searchController: searchDropClientType,
                                        searchInnerWidget: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            controller: searchDropClientType,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search for an item...',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return (item.value
                                              .toString()
                                              .contains(searchValue));
                                        },
                                        //This to clear the search value when you close the menu
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            searchDropClientType.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField2(
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(0, 0),
                                        dropdownMaxHeight: 250,
                                        value: selectedValueRoles,

                                        buttonDecoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        decoration: InputDecoration(
                                          //Add isDense true and zero Padding.
                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                          isDense: true,

                                          label: const Text("Roles Type"),

                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select Roles Type',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black45,
                                        ),
                                        iconSize: 30,
                                        buttonHeight: 50,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        items: listOfValueRoles
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please Client Type.';
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValueRoles =
                                                value.toString();
                                          });
                                        },

                                        onSaved: (value) {
                                          selectedValueRoles = value.toString();
                                        },
                                        searchController: searchDropRoles,
                                        searchInnerWidget: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            controller: searchDropRoles,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search for an item...',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return (item.value
                                              .toString()
                                              .contains(searchValue));
                                        },
                                        //This to clear the search value when you close the menu
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            searchDropRoles.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    child: ProfileTextInput(
                                        hintTextString: 'Password',
                                        labelText: 'Password',
                                        obscure: false,
                                        readonly: false,
                                        maxLength: 10,
                                        textEditingController:
                                            _passwordController),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxHeight: 55, maxWidth: 400),
                                    child: ProfileTextInput(
                                        hintTextString: 'Confirm Password',
                                        labelText: 'Confirm Password',
                                        obscure: false,
                                        readonly: false,
                                        maxLength: 10,
                                        textEditingController:
                                            _confirmPasswordController),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      signUp();
                                    }
                                  }),
                                  style: ElevatedButton.styleFrom(),
                                  child: Text('Add'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailNameController.dispose();
    _dobNameController.dispose();
    _phoneNumberController.dispose();
    searchDropRoles.dispose();
    searchDropClientType.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
