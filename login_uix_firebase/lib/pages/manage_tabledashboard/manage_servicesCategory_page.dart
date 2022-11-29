// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/database_service.dart';
import '../../model/serviceCategory_data.dart';
import '../../widgets/drawer_dashboard.dart';

class ManageServiceCategory extends StatefulWidget {
  static const routeName = '/ManageServiceCategoryPage';
  const ManageServiceCategory({super.key});

  @override
  State<ManageServiceCategory> createState() => _ManageServiceCategoryState();
}

class _ManageServiceCategoryState extends State<ManageServiceCategory> {
  DataService service = DataService();
  Future<List<serviceCategoryClass>>? sCategoryList;
  Map<String, dynamic>? currentserviceCategoryClass;
  List<serviceCategoryClass>? retrievedsCategoryList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  serviceCategoryClass? dataU;

  final _categoryNameController = TextEditingController();

  String? userId;
  String? categoryNameID;

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
    // listofColumn = (await service.retrieveServiceCategory()).cast<Map<String, dynamic>>();
    sCategoryList = service.retrieveServiceCategory();
    retrievedsCategoryList = await service.retrieveServiceCategory();
    selected = List<bool>.generate(
        retrievedsCategoryList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedsCategoryList = await service.retrieveServiceCategory();

    setState(() {
      sCategoryList = service.retrieveServiceCategory();
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
            future: sCategoryList,
            builder:
                (context, AsyncSnapshot<List<serviceCategoryClass>> snapshot) {
              // retrievedsCategoryList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      DataTable(
                        sortColumnIndex: _currentSortColumn,
                        sortAscending: _isAscending,
                        columns: [
                          DataColumn(
                              label: Text('Services Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Edit category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Delete category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(
                            retrievedsCategoryList!.length,
                            (index) => _buildTableUser(
                                context,
                                retrievedsCategoryList![index],
                                retrievedsCategoryList,
                                index)),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          dialogAddNewCategory(context);
                        },
                        tooltip: "Add New category",
                        child: Icon(Icons.add),
                        // backgroundColor: Colors.green,
                      )
                    ]);
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedsCategoryList!.isEmpty) {
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

  DataRow _buildTableUser(BuildContext context, serviceCategoryClass snapshot,
      List<serviceCategoryClass>? user, int indexs) {
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
        DataCell(Text(snapshot.categoryName as String)),
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
              dialogEditCategoryName(context);
              setState(() {
                userId = snapshot.id;
                categoryNameID = snapshot.categoryName;
              });
            },
            child: const Text('Edit'))),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              await service.deleteServicesCategory(
                  context, snapshot.id.toString());
              _pullRefresh();
            },
            child: const Text('Delete'))),
      ],
    );
  }

  Future<dynamic> dialogEditCategoryName(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit category"),
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
                          controller: _categoryNameController,
                          decoration: InputDecoration(
                            labelText: "category",
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
                              serviceCategoryClass servicesDataCategory =
                                  serviceCategoryClass(
                                id: userId,
                                categoryName: _categoryNameController.text,
                              );
                              await service
                                  .updateServicesCategory(servicesDataCategory);
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

  Future<dynamic> dialogAddNewCategory(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add category"),
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
                          controller: _categoryNameController,
                          decoration: InputDecoration(
                            labelText: "Enter category name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct category name";
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
                              serviceCategoryClass servicesDataCategory =
                                  serviceCategoryClass(
                                      id: userId,
                                      categoryName:
                                          _categoryNameController.text);
                              await service
                                  .addServicesCategory(servicesDataCategory);
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

//test
