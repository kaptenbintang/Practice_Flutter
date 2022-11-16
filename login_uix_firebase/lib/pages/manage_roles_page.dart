// ignore_for_file: prefer_const_constructors

import 'dart:html' as html;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/model/roles_data.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:login_uix_firebase/pages/manage_roles_page.dart';

import '../helper/database_service.dart';
import '../main.dart';
import '../widgets/drawer_dashboard.dart';

class ManageRoles extends StatefulWidget {
  static const routeName = '/manageRolesPage';
  const ManageRoles({super.key});

  @override
  State<ManageRoles> createState() => _ManageRolesState();
}

class _ManageRolesState extends State<ManageRoles> {
  DataService service = DataService();
  Future<List<RolesData>>? RolesList;
  List<RolesData>? retrievedRolesList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  RolesData? dataU;

  // final _emailController = TextEditingController();
  // final _clientTypeController = TextEditingController();
  // final _rolesController = TextEditingController();
  // final _firstNameController = TextEditingController();
  // final _lastNameController = TextEditingController();
  // final _ageController = TextEditingController();
  // final _clientCodeController = TextEditingController();
  // final _phoneController = TextEditingController();
  // final searchDropClientType = TextEditingController();
  // final searchDropRoles = TextEditingController();
  // final newPasswordController = TextEditingController();
  // final newConfirmPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  String? userId;

  String? selectedValueRoles;
  String? selectedValue;
  late String selectedValue2;
  late String initialDropDownVal;
  var newPassword = "";

  int _currentSortColumn = 0;
  bool _isAscending = true;
  bool _isWrite = false;
  bool _isRead = false;
  bool _isDelete = false;

  List<String> listOfValueRoles = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'Developer',
    'user',
    'admin'
  ];

  List<String> listOfValue = [
    'satu',
    'dua',
    'tiga',
    'enam',
    'sembilan',
    'none'
  ];
  List<String> dropDownItemValue2 = ['Action', 'Delete', 'Edit'];

  List<bool>? selected;
  List<String>? valuesList;
  final FocusNode dropDownFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedValue = dropDownItemValue[0];
    selectedValue2 = dropDownItemValue2[0];
    // selectedValue = listOfValue[0];

    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveRoles()).cast<Map<String, dynamic>>();
    RolesList = service.retrieveRoles();
    retrievedRolesList = await service.retrieveRoles();
    selected =
        List<bool>.generate(retrievedRolesList!.length, (int index) => false);
    valuesList = List<String>.generate(
        retrievedRolesList!.length, (int index) => 'Action');
  }

  Future<void> _pullRefresh() async {
    retrievedRolesList = await service.retrieveRoles();

    setState(() {
      RolesList = service.retrieveRoles();
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
                onTap: () {},
                child: Icon(
                  Icons.manage_accounts,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
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
            future: RolesList,
            builder: (context, AsyncSnapshot<List<RolesData>> snapshot) {
              // retrievedRolesList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        columns: [
                          // DataColumn(
                          //     onSort: (columnIndex, ascending) {
                          //       setState(() {
                          //         _currentSortColumn = columnIndex;
                          //         // _currentSortColumn = columnIndex;
                          //         if (_isAscending == true) {
                          //           _isAscending = false;
                          //           // sort the product list in Ascending, order by Price
                          //           retrievedRolesList!.sort(
                          //               (productA, productB) =>
                          //                   productB.clientCode!.compareTo(
                          //                       productA.clientCode as String));
                          //         } else {
                          //           _isAscending = true;
                          //           // sort the product list in Descending, order by Price
                          //           retrievedRolesList!.sort(
                          //               (productA, productB) =>
                          //                   productA.clientCode!.compareTo(
                          //                       productB.clientCode as String));
                          //         }
                          //       });
                          //     },
                          //     label: Text('CT Code',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                          // DataColumn(
                          //     label: Text('Id',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Roles Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),

                          DataColumn(
                              label: Text('Can Write',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Can Read',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),

                          DataColumn(
                              label: Text('Can Delete',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),

                          // DataColumn(
                          //     label: Text('Last Name',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                          // DataColumn(
                          //     label: Text('Email',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                          // DataColumn(
                          //     label: Text('Edit Mode',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedRolesList!.length,
                            (index) => _buildTableUser(
                                context,
                                retrievedRolesList![index],
                                retrievedRolesList,
                                index)),

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
                //   itemCount: retrievedRolesList!.length,
                //   itemBuilder: (context, index) {
                //     return _buildListUser(context, retrievedRolesList![index]);
                //   },
                // );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedRolesList!.isEmpty) {
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

  // Widget _buildListUser(BuildContext context, RolesData snapshot) {
  //   return Material(
  //     child: Center(
  //       child: ListTile(
  //         onTap: () {
  //           // Navigator.pushNamed(context, ArticlesDetailPage.routeName,
  //           //     arguments: article);
  //         },
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //         title: Text(snapshot.emailUser),
  //         subtitle: Text(snapshot.firstName),
  //       ),
  //     ),
  //   );
  // }

  // List<DataRow> _buildList(BuildContext context, snapshot) {
  //   return snapshot.map((data) => _buildTableUser(context, data)).toList();
  // }

  // DataRow _buildTableUser(BuildContext context, DocumentSnapshot snapshot) {
  //   final record = RolesData.fromDocumentSnapshot();

  //   return DataRow(
  //     cells: [
  //       DataCell(Text(snapshot.firstName)),
  //       DataCell(Text(snapshot.lastName)),
  //       DataCell(Text(snapshot.emailUser)),
  //     ],
  //   );
  // }

  DataRow _buildTableUser(BuildContext context, RolesData snapshot,
      List<RolesData>? user, int indexs) {
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
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
      // selected: selected![indexs],
      // onSelectChanged: (bool? value) {
      //   setState(() {
      //     selected![indexs] = value!;
      //   });
      // },
      cells: [
        // DataCell(
        //   Text(snapshot.clientCode as String),
        //   // showEditIcon: true,
        // ),
        // DataCell(Text(snapshot.id as String)),
        DataCell(Text(snapshot.rolesName as String)),
        DataCell(
          Container(
              child: Checkbox(
            value: _isWrite,
            checkColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _isWrite = value!;
              });
            },
          )),
        ),
        DataCell(
          Container(
              child: Checkbox(
            value: _isRead,
            checkColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _isRead = value!;
              });
            },
          )),
        ),

        DataCell(
          Container(
              child: Checkbox(
            value: _isDelete,
            checkColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _isDelete = value!;
              });
            },
          )),
        ),
        // DataCell(ElevatedButton(onPressed: () {}, child: const Text('Submit')))
      ],
    );
  }
}
