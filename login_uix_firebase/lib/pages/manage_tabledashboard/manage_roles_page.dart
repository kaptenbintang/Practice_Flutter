// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/roles_data.dart';
import '../../helper/database_service.dart';
import '../../widgets/drawer_dashboard.dart';

class ManageRoles extends StatefulWidget {
  static const routeName = '/manageRolesPage';
  const ManageRoles({super.key});

  @override
  State<ManageRoles> createState() => _ManageRolesState();
}

class _ManageRolesState extends State<ManageRoles> {
  DataService service = DataService();
  Future<List<RolesData>>? RolesList;
  Map<String, dynamic>? currentRolesData;
  List<RolesData>? retrievedRolesList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  RolesData? dataU;

  final _rolesNameController = TextEditingController();

  String? userId;
  String? _isRoles;

  String? selectedValueRoles;
  String? selectedValue;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  bool? _isWrite;
  bool? _isWriteAll;
  bool? _isRead;
  bool? _isDelete;

  List<bool>? selected;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveRoles()).cast<Map<String, dynamic>>();
    RolesList = service.retrieveRoles();
    retrievedRolesList = await service.retrieveRoles();
    selected =
        List<bool>.generate(retrievedRolesList!.length, (int index) => false);
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
                              label: Text('Can Write All',
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
                          DataColumn(
                              label: Text('Edit Roles',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Delete Roles',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedRolesList!.length,
                            (index) => _buildTableUser(
                                context,
                                retrievedRolesList![index],
                                retrievedRolesList,
                                index)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          dialogAddNewRoles(context);
                        },
                        tooltip: "Add new roles",
                        child: Icon(Icons.add),
                        // backgroundColor: Colors.green,
                      )
                    ]);
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
    );
  }

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
      cells: [
        DataCell(Text(snapshot.rolesName as String)),
        DataCell(
          Container(
              child: Checkbox(
            value: snapshot.canWrite,
            checkColor: Colors.white,
            onChanged: (value) {},
          )),
        ),
        DataCell(
          Container(
              child: Checkbox(
            value: snapshot.canWriteAll,
            checkColor: Colors.white,
            onChanged: (value) {},
          )),
        ),
        DataCell(
          Container(
              child: Checkbox(
            value: snapshot.canRead,
            checkColor: Colors.white,
            onChanged: (value) {},
          )),
        ),
        DataCell(
          Container(
              child: Checkbox(
            value: snapshot.canDelete,
            checkColor: Colors.white,
            onChanged: (value) {},
          )),
        ),
        DataCell(ElevatedButton(
            onPressed: () {
              dialogEditRoles(context);
              setState(() {
                userId = snapshot.id;
                _isRoles = snapshot.rolesName;
                _isWrite = snapshot.canWrite;
                _isWriteAll = snapshot.canWriteAll;
                _isRead = snapshot.canRead;
                _isDelete = snapshot.canDelete;
              });
            },
            child: const Text('Edit'))),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              await service.deleteRoles(context, snapshot.id.toString());
              _pullRefresh();
            },
            child: const Text('Delete'))),
      ],
    );
  }

  Future<dynamic> dialogEditRoles(BuildContext context) {
    List<bool> listOfValue = [true, false];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Roles Data"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -80.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWrite,
                            decoration: InputDecoration(
                              labelText: "Can Write?",
                            ),
                            // hint: Text(
                            //   'Can Write?',
                            // ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _isWrite = value!;
                              });
                            },
                            // onSaved: (value) {},
                            items: listOfValue.map((bool val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWriteAll,
                            decoration: InputDecoration(
                              labelText: "Can Write All?",
                            ),
                            // hint: Text(
                            //   'Can Write?',
                            // ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _isWriteAll = value!;
                              });
                            },
                            // onSaved: (value) {},
                            items: listOfValue.map((bool val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _isRead,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.manage_search,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isRead = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _isDelete,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isDelete = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              RolesData rolesData = RolesData(
                                  id: userId,
                                  rolesName: _isRoles,
                                  canWrite: _isWrite,
                                  canWriteAll: _isWriteAll,
                                  canRead: _isRead,
                                  canDelete: _isDelete);
                              await service.updateRoles(rolesData);
                              Navigator.pop(context);
                              _pullRefresh();
                            }

                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogAddNewRoles(BuildContext context) {
    bool? _selectedValue;
    List<bool> listOfValue = [true, false];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new roles"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -80.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _rolesNameController,
                          decoration: InputDecoration(
                            labelText: "Enter roles name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct roles name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Write?",
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isWrite = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Write All?",
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isWriteAll = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Read?",
                          ),
                          icon: Icon(
                            Icons.manage_search,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isRead = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isDelete = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              RolesData rolesData = RolesData(
                                  id: userId,
                                  rolesName: _rolesNameController.text,
                                  canWrite: _isWrite,
                                  canWriteAll: _isWriteAll,
                                  canRead: _isRead,
                                  canDelete: _isDelete);
                              await service.addRoles(rolesData);
                              Navigator.pop(context);
                              _pullRefresh();
                            }

                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
