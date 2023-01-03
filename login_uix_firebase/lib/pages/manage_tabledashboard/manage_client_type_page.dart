// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/clientType_data.dart';
import '../../helper/database_service.dart';

class ManageClients extends StatefulWidget {
  static const routeName = '/ManageClientsTypePage';
  const ManageClients({super.key});

  @override
  State<ManageClients> createState() => _ManageClientsState();
}

class _ManageClientsState extends State<ManageClients> {
  DataService service = DataService();
  Future<List<ClientData>>? ClientList;
  Map<String, dynamic>? currentClientData;
  List<ClientData>? retrievedClientList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  ClientData? dataU;

  final _clientTypeController = TextEditingController();

  String? userId;
  String? clientTypeName;

  String? selectedValueClient;
  String? selectedValue;
  int _currentSortColumn = 0;
  bool _isAscending = true;

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
    // listofColumn = (await service.retrieveClientType()).cast<Map<String, dynamic>>();
    ClientList = service.retrieveClientType();
    retrievedClientList = await service.retrieveClientType();
    selected =
        List<bool>.generate(retrievedClientList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedClientList = await service.retrieveClientType();

    setState(() {
      ClientList = service.retrieveClientType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerDashBoard(),
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
            future: ClientList,
            builder: (context, AsyncSnapshot<List<ClientData>> snapshot) {
              // retrievedClientList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        columns: [
                          DataColumn(
                              label: Text('Client Type Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Edit Type',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Delete Type',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedClientList!.length,
                            (index) => _buildTableUser(
                                context,
                                retrievedClientList![index],
                                retrievedClientList,
                                index)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          dialogAddNewClientType(context);
                        },
                        tooltip: "Add new client type",
                        child: Icon(Icons.add),
                        // backgroundColor: Colors.green,
                      )
                    ]);
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedClientList!.isEmpty) {
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

  DataRow _buildTableUser(BuildContext context, ClientData snapshot,
      List<ClientData>? user, int indexs) {
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
        DataCell(Text(snapshot.ctName as String)),
        // DataCell(
        //   Container(
        //       child: Checkbox(
        //     value: snapshot.canWrite,
        //     checkColor: Colors.white,
        //     onChanged: (value) {},
        //   )),
        // ),
        // DataCell(
        //   Container(
        //       child: Checkbox(
        //     value: snapshot.canRead,
        //     checkColor: Colors.white,
        //     onChanged: (value) {},
        //   )),
        // ),
        // DataCell(
        //   Container(
        //       child: Checkbox(
        //     value: snapshot.canDelete,
        //     checkColor: Colors.white,
        //     onChanged: (value) {},
        //   )),
        // ),
        DataCell(ElevatedButton(
            onPressed: () {
              dialogEditClientType(context);
              setState(() {
                userId = snapshot.id;
                clientTypeName = snapshot.ctName;
              });
            },
            child: const Text('Edit'))),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              await service.deleteClientType(context, snapshot.id.toString());
              _pullRefresh();
            },
            child: const Text('Delete'))),
      ],
    );
  }

  Future<dynamic> dialogEditClientType(BuildContext context) {
    List<bool> listOfValue = [true, false];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Client Type"),
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
                          controller: _clientTypeController,
                          decoration: InputDecoration(
                            labelText: "Client Type",
                          ),
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
                              ClientData clientData = ClientData(
                                id: userId,
                                ctName: _clientTypeController.text,
                              );
                              await service.updateClientType(clientData);
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

  Future<dynamic> dialogAddNewClientType(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new client type"),
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
                          controller: _clientTypeController,
                          decoration: InputDecoration(
                            labelText: "Enter client type name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct client type name";
                            } else {
                              return null;
                            }
                          },
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
                              ClientData clientData = ClientData(
                                  id: userId,
                                  ctName: _clientTypeController.text);
                              await service.addClientType(clientData);
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
