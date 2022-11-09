import 'dart:html' as html;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/user_data.dart';

import '../helper/database_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DataService service = DataService();
  Future<List<UserData>>? userList;
  List<UserData>? retrievedUserList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  UserData? dataU;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  late String selectedValue;
  late String selectedValue2;
  late String initialDropDownVal;

  List<String> dropDownItemValue2 = ['Action', 'Delete', 'Edit'];

  List<bool>? selected;
  List<String>? valuesList;
  final FocusNode dropDownFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedValue = dropDownItemValue[0];
    selectedValue2 = dropDownItemValue2[0];

    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveUsers()).cast<Map<String, dynamic>>();
    userList = service.retrieveUsers();
    retrievedUserList = await service.retrieveUsers();
    selected =
        List<bool>.generate(retrievedUserList!.length, (int index) => false);
    valuesList = List<String>.generate(
        retrievedUserList!.length, (int index) => 'Action');
  }

  Future<void> _pullRefresh() async {
    retrievedUserList = await service.retrieveUsers();

    setState(() {
      userList = service.retrieveUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Dashboard Home'),
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
                    // scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: 1,
                        sortAscending: true,
                        columns: const [
                          DataColumn(
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
                          // DataColumn(
                          //     label: Text('Email',
                          //         style: TextStyle(
                          //             fontSize: 18, fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Age',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Roles',
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
                                context,
                                retrievedUserList![index],
                                retrievedUserList,
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

  Widget _buildListUser(BuildContext context, UserData snapshot) {
    return Material(
      child: Center(
        child: ListTile(
          onTap: () {
            // Navigator.pushNamed(context, ArticlesDetailPage.routeName,
            //     arguments: article);
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Text(snapshot.emailUser),
          subtitle: Text(snapshot.firstName),
        ),
      ),
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

  DataRow _buildTableUser(BuildContext context, UserData snapshot,
      List<UserData>? user, int indexs) {
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
      selected: selected![indexs],
      onSelectChanged: (bool? value) {
        setState(() {
          selected![indexs] = value!;
        });
      },
      cells: [
        DataCell(
          Text(snapshot.clientCode),
          showEditIcon: true,
        ),
        DataCell(Text(snapshot.firstName)),
        DataCell(Text(snapshot.lastName)),
        // DataCell(Text(snapshot.emailUser)),
        DataCell(Text(snapshot.ageUser.toString())),
        DataCell(Text(snapshot.roles)),

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
                  case "Delete":
                    break;
                  case "Edit":
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Edit User Data"),
                            content: SingleChildScrollView(
                                child: ListBody(
                              children: [
                                Form(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              labelText: "Client Code",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              // hintText: 'Last Name',
                                              fillColor: Colors.grey[200],
                                              filled: true),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    _firstNameController,
                                                decoration: InputDecoration(
                                                    labelText: "First Name",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .blue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    // hintText: 'Last Name',
                                                    fillColor: Colors.grey[200],
                                                    filled: true),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    _firstNameController,
                                                decoration: InputDecoration(
                                                    labelText: "Last Name",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .blue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    // hintText: 'Last Name',
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
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              labelText: "Age",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              // hintText: 'Last Name',
                                              fillColor: Colors.grey[200],
                                              filled: true),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              labelText: "Phone Number",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              // hintText: 'Last Name',
                                              fillColor: Colors.grey[200],
                                              filled: true),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              labelText: "Roles",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              // hintText: 'Last Name',
                                              fillColor: Colors.grey[200],
                                              filled: true),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              labelText: "Client Type",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              // hintText: 'Last Name',
                                              fillColor: Colors.grey[200],
                                              filled: true),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          );
                        });
                    break;
                  default:
                }

                setState(() {
                  valuesList![indexs] = value;
                });
              }
            },
            items: List.generate(
                dropDownItemValue2.length,
                (index) => DropdownMenuItem(
                      child: Text(dropDownItemValue2[index]),
                      value: dropDownItemValue2[index],
                    )),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     service.deleteUser(context, snapshot.id.toString());
          //   },
          //   child: const Text('Hard Delete'),
          // ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }
}
