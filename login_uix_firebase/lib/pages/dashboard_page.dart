// ignore_for_file: prefer_const_constructors

import 'dart:html' as html;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/model/roles_data.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:login_uix_firebase/pages/login_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_roles_page.dart';
import 'package:login_uix_firebase/widgets/alert_confirm.dart';
import 'package:login_uix_firebase/widgets/drawer_dashboard.dart';

import '../helper/database_service.dart';
import '../helper/user_privilege.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashBoardPage';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PowerChecker rolePriv = PowerChecker();
  DataService service = DataService();
  Future<List<UserData>>? userList;
  List<UserData>? retrievedUserList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  UserData? dataU;

  List<RolesData>? rolesList;

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
  var authoRoles;

  int _currentSortColumn = 0;
  bool _isAscending = true;

  List<String> listOfValueRoles = [];
  // ['Developer', 'user', 'admin', 'superadmin'];

  List<String> listOfValue = [
    'satu',
    'dua',
    'tiga',
    'enam',
    'sembilan',
    'none',
    'unassigned',
  ];
  List<String> dropDownItemValue2 = [
    'Action',
    'Edit',
    'Remove',
    'ResetPassword'
  ];

  List<bool>? selected;
  List<String>? valuesList;
  final FocusNode dropDownFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedValue2 = dropDownItemValue2[0];

    _scaffoldKey = GlobalKey();

    _initRetrieval();
    super.initState();
  }

  Future _initRetrieval() async {
    Map<String, dynamic> currentUserData =
        await service.currentUsers(currentUser.uid);

    setState(() {
      rolesType = currentUserData['roles'];
    });
    Map<String, dynamic> rolesPriv = await rolePriv.getRoles(rolesType);
    setState(() {
      authoRoles = rolesPriv;
    });
    userList = service.retrieveAllStaff(rolesType);
    retrievedUserList = await service.retrieveAllStaff(rolesType);
    selected =
        List<bool>.generate(retrievedUserList!.length, (int index) => false);
    valuesList = List<String>.generate(
        retrievedUserList!.length, (int index) => 'Action');
    rolesList = await service.retrieveRoles();
    rolesList?.forEach((element) {
      listOfValueRoles.add(element.rolesName.toString());
    });

    print(listOfValueRoles);
    print(rolesPriv);
  }

  Future<void> _pullRefresh() async {
    retrievedUserList = await service.retrieveAllStaff(rolesType);

    setState(() {
      userList = service.retrieveAllStaff(rolesType);
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
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushReplacementNamed(
                          context, ControllerPage.routeName));
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
                          children: [Text('Done')],
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
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
                              retrievedUserList!.sort((productA, productB) =>
                                  productB.clientCode!.compareTo(
                                      productA.clientCode as String));
                            } else {
                              _isAscending = true;
                              // sort the product list in Descending, order by Price
                              retrievedUserList!.sort((productA, productB) =>
                                  productA.clientCode!.compareTo(
                                      productB.clientCode as String));
                            }
                          });
                        },
                        label: Text(
                          'CT Code',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                          label: Text('First Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Last Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Email',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Birth Date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Phone Number',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Client Type',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Roles',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Created Date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      if (authoRoles['canDelete'] != false)
                        DataColumn(
                            label: Text('Marked Deleted',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Action',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
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
                );

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
    );
  }

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
                    case "ResetPassword":
                      dialogResetPassword(context);
                      setState(() {
                        _emailController.text = snapshot.emailUser;
                      });
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
                if (authoRoles['canWrite'] != false)
                  DropdownMenuItem(
                    child: Text('Edit'),
                    value: "Edit",
                  ),
                // if (currentUser.uid.toString != snapshot.id.toString &&
                //     authoRoles!['canDelete'] != false)
                //   DropdownMenuItem(
                //     child: Text('Remove'),
                //     value: "Remove",
                //   ),
                DropdownMenuItem(
                  child: Text('Change Password'),
                  value: "ResetPassword",
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
                      showDialog(
                        context: context,
                        builder: (contextm) {
                          return AlertDialogConfirm(
                              type: value,
                              id: snapshot.id as String,
                              contexts: context,
                              textDesc: 'Are you sure?');
                        },
                      ).whenComplete(
                        () => Future.delayed(
                          Duration(seconds: 2),
                          () {
                            _pullRefresh();
                          },
                        ),
                      );

                      // _dialogBuilder(_scaffoldKey!.currentState!.context,
                      //     snapshot.id.toString());
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
                    case "ResetPassword":
                      dialogResetPassword(context);
                      setState(() {
                        _emailController.text = snapshot.emailUser;
                      });
                      break;
                    case "Restore":
                      service
                          .markdeleteRestoreUser(context, snapshot.id as String)
                          .whenComplete(
                            () => Future.delayed(
                              Duration(seconds: 2),
                              () {
                                _pullRefresh();
                              },
                            ),
                          );

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
                DropdownMenuItem(
                  child: Text('Reset Password'),
                  value: "ResetPassword",
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

  Future<dynamic> dialogEdit(BuildContext context) async {
    return await showDialog(
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
                            enabled: authoRoles['canWriteAll'] != false
                                ? true
                                : false,
                            controller: _clientCodeController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                labelText: "Client Code",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: authoRoles['canWriteAll'] != false
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: 250,
                              value:
                                  // authoRoles['canWriteAll'] != false
                                  selectedValue!.isNotEmpty
                                      ? selectedValue
                                      : selectedValue = "",
                              // : null,
                              buttonDecoration: BoxDecoration(
                                color: authoRoles['canWriteAll'] != false
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
                                  //   (value) {
                                  authoRoles['canWriteAll'] != false
                                      ? (value) {
                                          setState(() {
                                            selectedValue = value.toString();
                                          });
                                        }
                                      : null,

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

                                  authoRoles['canWriteAll'] != false
                                      ? (value) {
                                          setState(() {
                                            selectedValueRoles =
                                                value.toString();
                                          });
                                        }
                                      : null,

                              //Do something when changing the item if you want.

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

  Future<dynamic> dialogResetPassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text("Send a link reset password"),
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
                            controller: _emailController,
                            // maxLines: 1,
                            // maxLength: 6,
                            decoration: InputDecoration(
                              hintText: "Enter your email address",
                              hintStyle: TextStyle(color: Color(0xFF6f6f6f)),
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFf3f5f6),
                                  width: 2.0,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            readOnly: true,
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
                                  onPressed: passwordReset,
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

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.pop(context);
      // Util.routeToWidget(context, CheckEmailView());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Please check email!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
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
