import 'dart:html' as html;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:login_uix_firebase/pages/login_page.dart';
import 'package:login_uix_firebase/pages/manage_roles_page.dart';
import 'package:login_uix_firebase/widgets/alert_confirm.dart';
import 'package:login_uix_firebase/widgets/drawer_dashboard.dart';

import '../helper/database_service.dart';
import '../main.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashBoardPage';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DataService service = DataService();
  Future<List<UserData>>? userList;
  // Map<String, dynamic>? currentUserData;
  // Future<Map<String, dynamic>>? futureUserData;
  // String? currentUserData;
  List<UserData>? retrievedUserList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  UserData? dataU;

  final _emailController = TextEditingController();
  final _clientTypeController = TextEditingController();
  final _rolesController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _clientCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final searchDropClientType = TextEditingController();
  final searchDropRoles = TextEditingController();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  String? userId;

  String? selectedValueRoles;
  String? selectedValue;
  late String selectedValue2;
  late String initialDropDownVal;
  var newPassword = "";
  var rolesType;
  var marDeleted, createAt;

  int _currentSortColumn = 0;
  bool _isAscending = true;

  List<String> listOfValueRoles = ['Developer', 'user', 'admin', 'superadmin'];

  List<String> listOfValue = [
    'satu',
    'dua',
    'tiga',
    'enam',
    'sembilan',
    'none',
    'unassigned',
  ];
  List<String> dropDownItemValue2 = ['Action', 'Edit', 'Remove'];

  List<bool>? selected;
  List<String>? valuesList;
  final FocusNode dropDownFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    selectedValue2 = dropDownItemValue2[0];

    _scaffoldKey = GlobalKey();

    rolesType = "superadmin";

    _initRetrieval();
    super.initState();
  }

  Future<void> _initRetrieval() async {
    // futureUserData = service.currentUsers(currentUser.uid);
    // currentUserData = await service.currentUsers(currentUser.uid);
    // rolesType = currentUserData!['roles'];
    // final docRef = db.collection("users").doc(currentUser!.uid);
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     setState(() {
    //       rolesType = data['roles'];
    //     });
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    userList = service.retrieveAllUsers(rolesType);
    retrievedUserList = await service.retrieveAllUsers(rolesType);
    // currentUserData = await service.currentUsers(currentUser!.uid);
    selected =
        List<bool>.generate(retrievedUserList!.length, (int index) => false);
    valuesList = List<String>.generate(
        retrievedUserList!.length, (int index) => 'Action');

    // print(currentUserData!["roles"]);
  }

  Future<void> _pullRefresh() async {
    retrievedUserList = await service.retrieveAllUsers(rolesType);

    setState(() {
      userList = service.retrieveAllUsers(rolesType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerDashBoard(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dashboard Home"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _pullRefresh,
                child: Icon(
                  Icons.refresh_outlined,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                child: Icon(Icons.logout),
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              // html.window.location.reload;
              _pullRefresh();
              _scaffoldKey!.currentState!.showBottomSheet(
                (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      color: Colors.orange,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [const Text('Done')],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: userList,
            builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
              // retrievedUserList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        columns: [
                          DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  // _currentSortColumn = columnIndex;
                                  if (_isAscending == true) {
                                    _isAscending = false;
                                    // sort the product list in Ascending, order by Price
                                    retrievedUserList!.sort(
                                        (productA, productB) =>
                                            productB.clientCode!.compareTo(
                                                productA.clientCode as String));
                                  } else {
                                    _isAscending = true;
                                    // sort the product list in Descending, order by Price
                                    retrievedUserList!.sort(
                                        (productA, productB) =>
                                            productA.clientCode!.compareTo(
                                                productB.clientCode as String));
                                  }
                                });
                              },
                              label: Text('CT Code',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('First Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Last Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Email',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Birth Date',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Phone Number',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Client Type',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          // currentUserData!.containsKey("roles")
                          // currentUserData?["roles"] == 'Developer'
                          // ?
                          DataColumn(
                              label: Text('Roles',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          // : DataColumn(
                          //     label: Text('',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Created Date',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          if (rolesType! == "superadmin")
                            DataColumn(
                                label: Text('Marked Deleted',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),

                          DataColumn(
                              label: Text('Action',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedUserList!.length,
                            (index) => _buildTableUser(
                                context, retrievedUserList![index], index)),

                        //   listofColumn!
                        //       .map(
                        //         ((element) => DataRow(
                        //               cells: <DataCell>[
                        //                 DataCell(Text(element["firstName"])),
                        //                 DataCell(Text(element["lastName"])),
                        //                 DataCell(Text(element["age"])),
                        //                 DataCell(Text(element["email"])),
                        //               ],
                        //             )),
                        //       )
                        //       .toList(),
                      ),
                    ]);

                //     ListView.builder(
                //   itemCount: retrievedUserList!.length,
                //   itemBuilder: (context, index) {
                //     return _buildListUser(context, retrievedUserList![index]);
                //   },
                // );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedUserList!.isEmpty) {
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
          ),
        ),
      ),
      //     ElevatedButton(
      //       child: Text("Log out"),
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //       },
      //     )
      //   ],
      // ),
    );
  }

  // List<DataRow> _buildList(BuildContext context, snapshot) {
  //   return snapshot.map((data) => _buildTableUser(context, data)).toList();
  // }

  // DataRow _buildTableUser(BuildContext context, DocumentSnapshot snapshot) {
  //   final record = UserData.fromDocumentSnapshot();

  //   return DataRow(
  //     cells: [
  //       DataCell(Text(snapshot.firstName)),
  //       DataCell(Text(snapshot.lastName)),
  //       DataCell(Text(snapshot.emailUser)),
  //     ],
  //   );
  // }

  DataRow _buildTableUser(BuildContext context, UserData snapshot, int indexs) {
    // int idx = int.parse(dropDownItemValue2[indexs]);
    if (rolesType! != "superadmin") {
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // All rows will have the same selected color.
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          // Even rows will have a grey color.
          if (indexs.isEven) {
            return Colors.grey.withOpacity(0.3);
          }
          return null; // Use default value for other states and odd rows.
        }),
        selected: selected![indexs],
        onSelectChanged: (bool? value) {
          setState(() {
            selected![indexs] = value!;
          });
        },
        cells: [
          DataCell(
            Text(snapshot.clientCode as String),
            showEditIcon: true,
          ),
          DataCell(Text(snapshot.firstName)),
          DataCell(Text(snapshot.lastName)),
          DataCell(Text(snapshot.emailUser)),
          DataCell(Text(snapshot.doBirth)),
          DataCell(Text(snapshot.phoneNumber)),
          DataCell(Text(snapshot.clientType as String)),
          DataCell(Text(snapshot.roles as String)),
          DataCell(Text(snapshot.createdAt as String)),
          DataCell(
            DropdownButton<String>(
              hint: valuesList![indexs] == null
                  ? Text("Dropdown")
                  : Text(
                      valuesList![indexs],
                      style: TextStyle(color: Colors.blue),
                    ),
              focusNode: dropDownFocus,
              isExpanded: true,
              elevation: 8,
              onChanged: (value) {
                print(value);
                // if value doesnt contain just close the dropDown
                if (value == null) {
                  dropDownFocus.unfocus();
                } else {
                  switch (value) {
                    case "Remove":
                      break;
                    case "Edit":
                      dialogEdit(context);
                      setState(() {
                        _emailController.text = snapshot.emailUser;
                        _clientTypeController.text =
                            snapshot.clientType as String;
                        _rolesController.text = snapshot.roles as String;
                        _firstNameController.text = snapshot.firstName;
                        _lastNameController.text = snapshot.lastName;
                        _ageController.text = snapshot.doBirth;
                        _clientCodeController.text =
                            snapshot.clientCode as String;
                        _phoneController.text = snapshot.phoneNumber;
                        userId = snapshot.id;

                        selectedValue = snapshot.clientType;
                        selectedValueRoles = snapshot.roles;
                        createAt = snapshot.createdAt;
                        marDeleted = snapshot.markDeleted;
                      });
                      break;
                    case "Change Password":
                      dialogChangePassword(context);

                      break;
                    default:
                  }
                }
              },
              // items: List.generate(
              //     dropDownItemValue2.length,
              //     (index) => DropdownMenuItem(
              //           value: dropDownItemValue2[index],
              //           child: Text(dropDownItemValue2[index]),
              //         )),
              items: [
                DropdownMenuItem(
                  child: Text('Action'),
                  value: "Action",
                ),
                DropdownMenuItem(
                  child: Text('Edit'),
                  value: "Edit",
                ),
                if (currentUser?.uid.toString != snapshot.id.toString)
                  DropdownMenuItem(
                    child: Text('Remove'),
                    value: "Remove",
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // All rows will have the same selected color.
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          // Even rows will have a grey color.
          if (indexs.isEven) {
            return Colors.grey.withOpacity(0.3);
          }
          return null; // Use default value for other states and odd rows.
        }),
        selected: selected![indexs],
        onSelectChanged: (bool? value) {
          setState(() {
            selected![indexs] = value!;
          });
        },
        cells: [
          DataCell(
            Text(snapshot.clientCode as String),
            showEditIcon: true,
          ),
          DataCell(Text(snapshot.firstName)),
          DataCell(Text(snapshot.lastName)),
          DataCell(Text(snapshot.emailUser)),
          DataCell(Text(snapshot.doBirth)),
          DataCell(Text(snapshot.phoneNumber)),
          DataCell(Text(snapshot.clientType as String)),
          DataCell(Text(snapshot.roles as String)),
          DataCell(Text(snapshot.createdAt as String)),
          DataCell(Text(snapshot.markDeleted.toString())),

          // DataCell(Text(snapshot.markDeleted.toString())),
          DataCell(
            DropdownButton<String>(
              hint: valuesList![indexs] == null
                  ? Text("Dropdown")
                  : Text(
                      valuesList![indexs],
                      style: TextStyle(color: Colors.blue),
                    ),
              focusNode: dropDownFocus,
              isExpanded: true,
              elevation: 8,
              onChanged: (value) {
                print(value);
                // if value doesnt contain just close the dropDown
                if (value == null) {
                  dropDownFocus.unfocus();
                } else {
                  switch (value) {
                    case "Remove":
                      // service.markdeleteUser(context, snapshot.id as String);
                      _dialogBuilder(context, snapshot.id.toString());
                      break;
                    case "Edit":
                      dialogEdit(context);
                      setState(() {
                        _emailController.text = snapshot.emailUser;
                        _clientTypeController.text =
                            snapshot.clientType as String;
                        _rolesController.text = snapshot.roles as String;
                        _firstNameController.text = snapshot.firstName;
                        _lastNameController.text = snapshot.lastName;
                        _ageController.text = snapshot.doBirth;
                        _clientCodeController.text =
                            snapshot.clientCode as String;
                        _phoneController.text = snapshot.phoneNumber;
                        userId = snapshot.id;

                        selectedValue = snapshot.clientType;
                        selectedValueRoles = snapshot.roles;
                        createAt = snapshot.createdAt;
                        marDeleted = snapshot.markDeleted;
                      });
                      break;
                    case "Change Password":
                      dialogChangePassword(context);

                      break;
                    case "Restore":
                      service.markdeleteRestoreUser(
                          context, snapshot.id as String);
                      break;
                    default:
                  }
                }
              },
              // items: List.generate(
              //     dropDownItemValue2.length,
              //     (index) => DropdownMenuItem(
              //           value: dropDownItemValue2[index],
              //           child: Text(dropDownItemValue2[index]),
              //         )),
              items: [
                DropdownMenuItem(
                  child: Text('Action'),
                  value: "Action",
                ),
                DropdownMenuItem(
                  child: Text('Edit'),
                  value: "Edit",
                ),
                if (currentUser.uid.toString != snapshot.id.toString &&
                    snapshot.markDeleted == false)
                  DropdownMenuItem(
                    child: Text('Remove'),
                    value: "Remove",
                  ),
                if (currentUser.uid.toString != snapshot.id.toString &&
                    snapshot.markDeleted == true)
                  DropdownMenuItem(
                    child: Text('Restore'),
                    value: "Restore",
                  ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Future _dialogBuilder(BuildContext context, String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure want to delete this account?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm'),
              onPressed: () {
                service.markdeleteUser(context, id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> dialogEdit(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text("Edit User Data"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  // height: 500,
                  width: 400,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: TextFormField(
                            enabled: rolesType == 'superadmin' ? true : false,
                            controller: _clientCodeController,
                            decoration: InputDecoration(
                                labelText: "Client Code",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                      labelText: "First Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                      labelText: "Last Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                labelText: "Age",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextFormField(
                        //     controller: _rolesController,
                        //     decoration: InputDecoration(
                        //         labelText: "Roles",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(12)),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(12)),
                        //         fillColor: Colors.grey[200],
                        //         filled: true),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8),
                        //   child: TextFormField(
                        //     controller: _clientTypeController,
                        //     decoration: InputDecoration(
                        //         labelText: "Client Type",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(12)),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(12)),
                        //         fillColor: Colors.grey[200],
                        //         filled: true),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: 250,
                              value:
                                  // rolesType == "Developer"
                                  selectedValue!.isNotEmpty
                                      ? selectedValue
                                      : selectedValue = "",
                              // : null,
                              buttonDecoration: BoxDecoration(
                                color: rolesType == "superadmin"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(14),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                // labelText: 'Client Type',
                                label: const Text("Client Type"),

                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: listOfValue
                                  .map((item) => DropdownMenuItem<String>(
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
                                  // rolesType == "Developer"
                                  // ?
                                  (value) {
                                setState(() {
                                  selectedValue = value.toString();
                                });

                                //Do something when changing the item if you want.
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
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: 250,
                              value:
                                  // rolesType == "Developer"
                                  selectedValueRoles!.isNotEmpty
                                      ? selectedValueRoles
                                      : selectedValueRoles = "",
                              // : null,
                              buttonDecoration: BoxDecoration(
                                color: rolesType == "superadmin"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(14),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                // labelText: 'Client Type',
                                label: const Text("Roles Type"),

                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: listOfValueRoles
                                  .map((item) => DropdownMenuItem<String>(
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
                                  // rolesType == "Developer"
                                  (value) {
                                setState(() {
                                  selectedValueRoles = value.toString();
                                });

                                //Do something when changing the item if you want.
                              },
                              // : null,
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
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedValueRoles == "";
                                      selectedValue == "";
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      // _formKey.currentState!.save();

                                      UserData userData = UserData(
                                        id: userId,
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        emailUser: _emailController.text,
                                        clientCode: _clientCodeController.text,
                                        roles: selectedValueRoles as String,
                                        // imgUrl: '',
                                        createdAt: createAt,
                                        markDeleted: marDeleted,
                                        doBirth: _ageController.text,
                                        phoneNumber: _phoneController.text,
                                        clientType: selectedValue as String,
                                      );
                                      await service.updateUser(userData);
                                    }
                                  }),
                                  child: const Text('Confirm'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
        });
  }

  Future<dynamic> dialogChangePassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text("Create new pasword for this user"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  // height: 500,
                  width: 400,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(12)),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        FlutterPwValidator(
                            width: 350,
                            height: 110,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            onSuccess: () {
                              print("submitted");
                            },
                            controller: newPasswordController),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: newConfirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(12)),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        newPassword =
                                            newPasswordController.text;
                                      });
                                      changePassword();
                                    }
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
        });
  }

  changePassword() async {
    if (passwordConfirmed()) {
      try {
        await this.currentUser!.updatePassword(selectedValue2);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Change Password Successfully"),
              );
            });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.black26,
        //   content: Text("Your password has been changed & login again!"),
        // ));
      } catch (error) {}
    }
  }

  bool passwordConfirmed() {
    if (newPasswordController.text.trim() ==
        newConfirmPasswordController.text.trim()) {
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
  void dispose() {
    // TODO: implement dispose
    searchDropRoles.dispose();
    searchDropClientType.dispose();
    _ageController.dispose();
    _clientCodeController.dispose();
    _clientTypeController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _rolesController.dispose();
    newPasswordController.dispose();
    newConfirmPasswordController.dispose();
    _scaffoldKey?.currentState?.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
