// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/services_data.dart';
import '../../helper/database_service.dart';
import '../../widgets/drawer_dashboard.dart';

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

  final _categoryNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _serviceNameController = TextEditingController();
  final _priceController = TextEditingController();

  String? userId;
  String? servicesNameID;
  String? categoryNameID;
  String? durationID;
  String? priceID;
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
                          dialogAddNewServices(context);
                        },
                        tooltip: "Add new services",
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
              dialogEditServices(context);
              setState(() {
                userId = snapshot.id;
                servicesNameID = snapshot.servicesName;
                durationID = snapshot.duration;
                categoryNameID = snapshot.categoryName;
                priceID = snapshot.price;
              });
            },
            child: const Text('Edit'))),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              await service.deleteServices(context, snapshot.id.toString());
              _pullRefresh();
            },
            child: const Text('Delete'))),
      ],
    );
  }

  Future<dynamic> dialogEditServices(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Services"),
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
                          controller: _serviceNameController,
                          decoration: InputDecoration(
                            labelText: "Service Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText: "Duration",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _categoryStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Container(
                                child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                disabledItemFn: (String s) => s.startsWith('I'),
                              ),
                              items: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return data["categoryName"];
                                  })
                                  .toList()
                                  .cast<String>(),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Select Category",
                                  hintText: "list of category",
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  categoryNameID = value!;
                                });
                              },
                              selectedItem: categoryNameID,
                            ));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
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
                                servicesName: _serviceNameController.text,
                                duration: _durationController.text,
                                categoryName: categoryNameID,
                                price: _priceController.text,
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

  Future<dynamic> dialogAddNewServices(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new services"),
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
                          controller: _serviceNameController,
                          decoration: InputDecoration(
                            labelText: "Enter Service Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct service name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText: "Enter duration services",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct duration";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _categoryStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return Container(
                                child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                disabledItemFn: (String s) => s.startsWith('I'),
                              ),
                              items: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return data["categoryName"];
                                  })
                                  .toList()
                                  .cast<String>(),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Select Category",
                                  hintText: "list of category",
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  categoryNameID = value!;
                                });
                              },
                              // selectedItem: categoryNameID,
                            ));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Enter price service",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter price";
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
                                  servicesName: _serviceNameController.text,
                                  duration: _durationController.text,
                                  categoryName: categoryNameID,
                                  price: _priceController.text);
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
