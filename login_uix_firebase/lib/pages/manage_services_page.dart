// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/services_data.dart';
import '../helper/database_service.dart';
import '../widgets/drawer_dashboard.dart';

class ManageServices extends StatefulWidget {
  static const routeName = '/ManageServicesPage';
  const ManageServices({super.key});

  @override
  State<ManageServices> createState() => _ManageServicesState();
}

class _ManageServicesState extends State<ManageServices> {
  DataService service = DataService();
  Future<List<ServicesData>>? ServicesList;
  Map<String, dynamic>? currentServicesData;
  List<ServicesData>? retrievedServicesList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  ServicesData? dataU;

  final _clientTypeController = TextEditingController();

  String? userId;
  String? servicesName;

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
    ServicesList = service.retrieveServices();
    retrievedServicesList = await service.retrieveServices();
    selected = List<bool>.generate(
        retrievedServicesList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedServicesList = await service.retrieveServices();

    setState(() {
      ServicesList = service.retrieveServices();
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
            future: ServicesList,
            builder: (context, AsyncSnapshot<List<ServicesData>> snapshot) {
              // retrievedServicesList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        columns: [
                          DataColumn(
                              label: Text('Services Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Duration',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Category Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Price',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Edit Service',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Delete Service',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedServicesList!.length,
                            (index) => _buildTableUser(
                                context,
                                retrievedServicesList![index],
                                retrievedServicesList,
                                index)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          dialogAddNewClientType(context);
                        },
                        tooltip: "Add New Client Type",
                        child: Icon(Icons.add),
                        // backgroundColor: Colors.green,
                      )
                    ]);
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedServicesList!.isEmpty) {
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

  DataRow _buildTableUser(BuildContext context, ServicesData snapshot,
      List<ServicesData>? user, int indexs) {
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
        DataCell(Text(snapshot.servicesName as String)),
        DataCell(Text(snapshot.duration as String)),
        DataCell(Text(snapshot.categoryName as String)),
        DataCell(Text(snapshot.price as String)),
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
                servicesName = snapshot.servicesName;
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
                              ServicesData servicesData = ServicesData(
                                id: userId,
                                servicesName: _clientTypeController.text,
                              );
                              await service.updateServices(servicesData);
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
                              ServicesData servicesData = ServicesData(
                                  id: userId,
                                  servicesName: _clientTypeController.text);
                              await service.addServices(servicesData);
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
