// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';
import 'package:login_uix_firebase/model/services_data.dart';
import 'package:login_uix_firebase/pages/appointment_page.dart';
import 'package:login_uix_firebase/pages/schedule_calendar_page.dart';
import '../../flutter_flow/flutter_flow.dart';
import '../../helper/database_service.dart';
import '../../main.dart';
import '../../widgets/drawer_dashboard.dart';

class ManagePractioners extends StatefulWidget {
  static const routeName = '/ManagePractionersPage';
  const ManagePractioners({super.key});

  @override
  State<ManagePractioners> createState() => _ManagePractionersState();
}

class _ManagePractionersState extends State<ManagePractioners> {
  DataService service = DataService();
  Future<List<PractionerData>>? PractionerList;
  Map<String, dynamic>? currentPractionerData;
  List<PractionerData>? retrievedPractionerList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  PractionerData? dataU;

  final _firstNamePractioner = TextEditingController();
  final _lastNamePractioner = TextEditingController();
  final _myApproachPractioner = TextEditingController();
  final _myBackgroundPractioner = TextEditingController();
  final _myQualificationsPractioner = TextEditingController();
  final _mySpecialtyPractioner = TextEditingController();
  final _myRolesPractioner = TextEditingController();
  final _languagesPractioner = TextEditingController();
  final _titleMainPractioner = TextEditingController();
  final _schedulePractioner = TextEditingController();

  String? userId;
  String? firstNameID;
  String? lastNameID;
  String? myApproachID;
  String? myBackgroundID;
  String? myQualificationsID;
  String? mySpecialtyID;
  String? myRolesID;
  String? languagesID;
  String? titleMainID;
  String? schedulePractionerID;
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
    PractionerList = service.retrievePractionerAll();
    retrievedPractionerList = await service.retrievePractionerAll();
    selected = List<bool>.generate(
        retrievedPractionerList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedPractionerList = await service.retrievePractionerAll();

    setState(() {
      PractionerList = service.retrievePractionerAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerDashBoard(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Practioner Dashboard"),
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
            future: PractionerList,
            builder: (context, AsyncSnapshot<List<PractionerData>> snapshot) {
              // retrievedPractionerList = toMap(snapshot.data);
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable2(
                    sortColumnIndex: _currentSortColumn,
                    sortAscending: _isAscending,
                    columns: [
                      DataColumn(
                          label: Text('First Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Last Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('My Approach',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('My Backgrounds',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('My Qualifications',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('My Specialty',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('My Roles',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Languages',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('titleMain',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Schedule',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Add Practioners',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Edit Practioners',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Delete Service',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: List.generate(
                        retrievedPractionerList!.length,
                        (index) => _buildTableUser(
                            context,
                            retrievedPractionerList![index],
                            retrievedPractionerList,
                            index)),
                  ),
                );

                //  FloatingActionButton(
                //     onPressed: () {
                //       dialogaddPractioner(context);
                //     },
                //     tooltip: "Add new Practioners",
                //     child: Icon(Icons.add),
                //     // backgroundColor: Colors.green,
                //   )

              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedPractionerList!.isEmpty) {
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

  DataRow _buildTableUser(BuildContext context, PractionerData snapshot,
      List<PractionerData>? user, int indexs) {
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
        DataCell(Text(snapshot.firstName as String)),
        DataCell(Text(snapshot.lastName as String)),
        DataCell(Text(snapshot.myApproach as String)),
        DataCell(Text(snapshot.myBackground as String)),
        DataCell(Text(snapshot.myQualifications as String)),
        DataCell(Text(snapshot.mySpecialty as String)),
        DataCell(Text(snapshot.myRoles as String)),
        DataCell(Text(snapshot.languages as String)),
        DataCell(Text(snapshot.titleMain as String)),
        DataCell(Text(snapshot.practionerSchedule as String)),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () {
              dialogaddPractioner(context);
              _pullRefresh();
            },
            child: const Text('Add'))),
        DataCell(ElevatedButton(
            onPressed: () {
              dialogEditPractioner(context);
              setState(() {
                userId = snapshot.id;
                firstNameID = snapshot.firstName;
                lastNameID = snapshot.lastName;
                myApproachID = snapshot.myApproach;
                myBackgroundID = snapshot.myBackground;
                myQualificationsID = snapshot.myQualifications;
                mySpecialtyID = snapshot.mySpecialty;
                myRolesID = snapshot.myRoles;
                languagesID = snapshot.languages;
                titleMainID = snapshot.titleMain;
                schedulePractionerID = snapshot.practionerSchedule;
              });
            },
            child: const Text('Edit'))),
        DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              await service.deletePractioners(context, snapshot.id.toString());
              _pullRefresh();
            },
            child: const Text('Delete'))),
      ],
    );
  }

  Future<dynamic> dialogEditPractioner(BuildContext context) {
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
                          controller: _firstNamePractioner,
                          decoration: InputDecoration(
                            labelText: "First Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _lastNamePractioner,
                          decoration: InputDecoration(
                            labelText: "Last Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myApproachPractioner,
                          decoration: InputDecoration(
                            labelText: "My Approach",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myBackgroundPractioner,
                          decoration: InputDecoration(
                            labelText: "My Backgrounds",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myQualificationsPractioner,
                          decoration: InputDecoration(
                            labelText: "My Qualifications",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _mySpecialtyPractioner,
                          decoration: InputDecoration(
                            labelText: "My Specialty",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myRolesPractioner,
                          decoration: InputDecoration(
                            labelText: "My Roles",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _languagesPractioner,
                          decoration: InputDecoration(
                            labelText: "Languages",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _titleMainPractioner,
                          decoration: InputDecoration(
                            labelText: "Title Main",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2022), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2023));

                            var time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            // DateTimeRange? pickedRange =
                            //     await showDateRangePicker(
                            //   context: context,
                            //   firstDate: DateTime.now(),
                            //   lastDate: DateTime(2023),
                            //   // initialDateRange: dateRange.value
                            // );

                            if (pickedDate != null &&
                                // pickedRange != null &&
                                time != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement
                              setState(() {
                                _schedulePractioner.text = formattedDate +
                                    " " +
                                    "${time.hour}:${time.minute}";

                                //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          controller: _schedulePractioner,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Schedule",
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
                              PractionerData practionerData = PractionerData(
                                  id: userId,
                                  firstName: _firstNamePractioner.text,
                                  lastName: _lastNamePractioner.text,
                                  myApproach: _myApproachPractioner.text,
                                  myBackground: _myBackgroundPractioner.text,
                                  myQualifications:
                                      _myQualificationsPractioner.text,
                                  mySpecialty: _mySpecialtyPractioner.text,
                                  myRoles: _myRolesPractioner.text,
                                  languages: _languagesPractioner.text,
                                  titleMain: _titleMainPractioner.text,
                                  practionerSchedule: _schedulePractioner.text);
                              await service.updatePractioners(practionerData);
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

  Future<dynamic> dialogaddPractioner(BuildContext context) {
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
                          controller: _firstNamePractioner,
                          decoration: InputDecoration(
                            labelText: "Enter First Name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _lastNamePractioner,
                          decoration: InputDecoration(
                            labelText: "Enter last name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myApproachPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my approach",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter approach";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myBackgroundPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my background",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter background";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myQualificationsPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my qualifications",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter qualifications";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _mySpecialtyPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my specialty",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter specialty";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myRolesPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my roles",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter roles";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _languagesPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter my languges",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter languages";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _titleMainPractioner,
                          decoration: InputDecoration(
                            labelText: "Enter title main",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter title main";
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
                              PractionerData practionerData = PractionerData(
                                id: userId,
                                firstName: _firstNamePractioner.text,
                                lastName: _lastNamePractioner.text,
                                myApproach: _myApproachPractioner.text,
                                myBackground: _myBackgroundPractioner.text,
                                myQualifications:
                                    _myQualificationsPractioner.text,
                                mySpecialty: _mySpecialtyPractioner.text,
                                myRoles: _myRolesPractioner.text,
                                languages: _languagesPractioner.text,
                                titleMain: _titleMainPractioner.text,
                              );
                              await service.addPractioners(practionerData);
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
