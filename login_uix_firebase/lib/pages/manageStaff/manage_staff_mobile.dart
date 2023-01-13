// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:recase/recase.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../helper/user_privilege.dart';
import '../../model/roles_data.dart';
import '../../model/user_data.dart';
import '../../widgets/alert_confirm.dart';

class ManageStaffMobile extends StatefulWidget {
  const ManageStaffMobile({super.key});

  @override
  State<ManageStaffMobile> createState() => _ManageStaffMobileState();
}

class _ManageStaffMobileState extends State<ManageStaffMobile> {
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

  List<UserData> selectedUser = [];

  String? selectedValueRoles;
  String? selectedValue;
  late String selectedValue2;
  late String initialDropDownVal;
  var newPassword = "";
  var rolesType;
  var marDeleted, createAt;
  var authoRoles;

  int? _currentSortColumn;
  bool _isAscending = false;

  List<String> listOfValueRoles = [];

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

  final controllerSearch = TextEditingController();

  @override
  void initState() {
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
        List<bool>.generate(retrievedUserList!.length, (int indexs) => false);
    valuesList = List<String>.generate(
        retrievedUserList!.length, (int indexs) => 'Action');
    rolesList = await service.retrieveRoles();
    rolesList?.forEach((element) {
      listOfValueRoles.add(element.rolesName.toString());
    });
  }

  Future<void> _pullRefresh() async {
    retrievedUserList = await service.retrieveAllStaff(rolesType);

    setState(() {
      userList = service.retrieveAllStaff(rolesType);
    });
  }

  Future search() async {
    retrievedUserList =
        await service.searchUser(controllerSearch.text.sentenceCase);
    setState(() {
      userList = service.searchUser(controllerSearch.text.sentenceCase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
                    height: Dimensions.height10 * 5,
                    color: Colors.orange,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [Text('Done')],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              Dimensions.width16,
              Dimensions.height15 + Dimensions.height10 / 10,
              Dimensions.width16,
              Dimensions.height15 + Dimensions.height10 / 10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(
                  Dimensions.radius15 + Dimensions.radius10 / 10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      Dimensions.width16,
                      Dimensions.height15 + Dimensions.height10 / 10,
                      0,
                      Dimensions.height15 + Dimensions.height10 / 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            Dimensions.height05 - Dimensions.height10 / 10,
                            0,
                            0),
                        child: Text(
                          'Your project status is appearing here.',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                //COntent
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      Dimensions.width24 - Dimensions.width10,
                      0,
                      Dimensions.width24 - Dimensions.width10,
                      Dimensions.height24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(
                          Dimensions.radius15 + Dimensions.radius10 / 10),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).lineColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          Dimensions.width24 / 2,
                          Dimensions.height15 + Dimensions.height10 / 10,
                          0,
                          Dimensions.height24 / 2),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //My Staff
                            Text(
                              'My Staff',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                            //Search delete row
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Search
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    //searchbox
                                    SizedBox(
                                      width: Dimensions.width100 * 1.3,
                                      height: Dimensions.height10 * 5,
                                      child: TextFormField(
                                        controller: controllerSearch,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15 / 3),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    //searchicon
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width30 / 10, 0, 0, 0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: Dimensions.radius30,
                                        borderWidth: 1,
                                        buttonSize: Dimensions.font10 * 3,
                                        icon: Icon(
                                          Icons.search,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: Dimensions.font18,
                                        ),
                                        onPressed: () {
                                          controllerSearch.text.isNotEmpty
                                              ? search()
                                              : _pullRefresh();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                //Delete
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Visibility(
                                        visible: selectedUser.isNotEmpty
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            'Selected ${selectedUser.length} Users out of ${retrievedUserList?.length}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      Dimensions.font15 / 2,
                                                ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    //Deleteiconbutton
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: Dimensions.width10 / 2,
                                      ),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: Dimensions.radius30,
                                        borderWidth: 1,
                                        buttonSize: Dimensions.font10 * 3,
                                        icon: Icon(
                                          Icons.delete_sweep,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          size: Dimensions.font18,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (contextm) {
                                              return AlertDialogConfirm(
                                                  type: 'Remove',
                                                  ids: selectedUser
                                                      .map((e) => e.id!)
                                                      .toList(),
                                                  contexts: context,
                                                  textDesc: 'Are you sure?');
                                            },
                                          ).whenComplete(
                                            () => Future.delayed(
                                              Duration(seconds: 2),
                                              () {
                                                controllerSearch.text.isNotEmpty
                                                    ? search()
                                                    : _pullRefresh();
                                                setState(() {
                                                  selectedUser = [];
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //Checkbox and TitleRow
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  Dimensions.height24 / 2,
                                  Dimensions.width24 / 2,
                                  0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      //select all button
                                      Checkbox(
                                        splashRadius: Dimensions.radius30,
                                        value: selectedUser.isNotEmpty
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() => selectedUser =
                                              value! ? retrievedUserList! : []);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              width: Dimensions.width100 * 3,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width08,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius10),
                                              ),
                                              content: Text(
                                                'All user selected: $value',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.width10, 0, 0, 0),
                                        child: Text(
                                          'CT Code',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Action',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //ListView
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, Dimensions.height08 * 2, 0, 0),
                              child: //staff data row
                                  FutureBuilder(
                                      future: userList,
                                      builder: (context,
                                          AsyncSnapshot<List<UserData>>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data!.isNotEmpty) {
                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                retrievedUserList!.length,
                                            itemBuilder: (context, indexs) {
                                              return _buildTableUser(
                                                  context,
                                                  retrievedUserList![indexs],
                                                  indexs);
                                            },
                                          );
                                        } else if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            retrievedUserList!.isEmpty) {
                                          return Center(
                                            child: ListView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              children: const <Widget>[
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  child:
                                                      Text('No Data Availble'),
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, UserData snapshot, int indexs) {
    if (rolesType != "superadmin") {
      return InkWell(
        onTap: () {
          if (!selectedUser.contains(indexs)) {
            setState(() {
              selectedUser.add(retrievedUserList![indexs]);
            });
          } else {
            setState(() {
              selectedUser.removeWhere((val) => val == indexs);
            });
          }
        },
        child: Padding(
          padding:
              EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height10 / 5),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  color: FlutterFlowTheme.of(context).lineColor,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0,
                  Dimensions.height24 / 2,
                  Dimensions.width24 / 2,
                  Dimensions.height24 / 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 4,
                    //box,name
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Checkbox(
                          value: selectedUser.contains(snapshot),
                          onChanged: (isSelected) {
                            setState(() {
                              final isAdding = isSelected != null && isSelected;

                              isAdding
                                  ? selectedUser.add(snapshot)
                                  : selectedUser.remove(snapshot);
                            });
                          },
                          splashRadius: Dimensions.radius30,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name
                            AutoSizeText(
                              snapshot.clientCode as String,
                              style: FlutterFlowTheme.of(context).subtitle1,
                            ),
                            if (responsiveVisibility(
                              context: context,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              //email
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, Dimensions.height10 / 5, 0, 0),
                                child: Text(
                                  snapshot.emailUser!,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //dropdown
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusNode: dropDownFocus,
                        isExpanded: true,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        iconSize: Dimensions.font20 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: Dimensions.font20,
                        ),
                        onChanged: (value) {
                          if (value == null) {
                            dropDownFocus.unfocus();
                          } else {
                            switch (value) {
                              case "Edit":
                                dialogEdit(context);
                                setState(() {
                                  _emailController.text = snapshot.emailUser!;
                                  _clientTypeController.text =
                                      snapshot.clientType as String;
                                  _rolesController.text =
                                      snapshot.roles as String;
                                  _firstNameController.text =
                                      snapshot.firstName;
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
                                  _emailController.text = snapshot.emailUser!;
                                });
                                break;
                              default:
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Action',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            value: "Action",
                          ),
                          if (authoRoles['canWrite'] != false)
                            DropdownMenuItem(
                              child: Text(
                                'Edit',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                              value: "Edit",
                            ),
                          DropdownMenuItem(
                            child: Text(
                              'Change Password',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            value: "ResetPassword",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          if (!selectedUser.contains(indexs)) {
            setState(() {
              selectedUser.add(retrievedUserList![indexs]);
            });
          } else {
            setState(() {
              selectedUser.removeWhere((val) => val == indexs);
            });
          }
        },
        child: Padding(
          padding:
              EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height10 / 5),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  color: FlutterFlowTheme.of(context).lineColor,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0,
                  Dimensions.height24 / 2,
                  Dimensions.width24 / 2,
                  Dimensions.height24 / 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 4,
                    //box,name
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, Dimensions.width08, 0),
                          child: Checkbox(
                            value: selectedUser.contains(snapshot),
                            onChanged: (isSelected) {
                              setState(() {
                                final isAdding =
                                    isSelected != null && isSelected;

                                isAdding
                                    ? selectedUser.add(snapshot)
                                    : selectedUser.remove(snapshot);
                              });
                            },
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              snapshot.clientCode as String,
                              style: FlutterFlowTheme.of(context).subtitle1,
                            ),
                            if (responsiveVisibility(
                              context: context,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, Dimensions.height10 / 5, 0, 0),
                                child: Text(
                                  snapshot.emailUser!,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //dropdown
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusNode: dropDownFocus,
                        isExpanded: true,
                        elevation: 8,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        iconSize: Dimensions.font20 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: Dimensions.font20,
                        ),
                        onChanged: (value) {
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
                                      controllerSearch.text.isNotEmpty
                                          ? search()
                                          : _pullRefresh();
                                    },
                                  ),
                                );

                                break;
                              case "Edit":
                                dialogEdit(context);
                                setState(() {
                                  _emailController.text = snapshot.emailUser!;
                                  _clientTypeController.text =
                                      snapshot.clientType as String;
                                  _rolesController.text =
                                      snapshot.roles as String;
                                  _firstNameController.text =
                                      snapshot.firstName;
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
                                  _emailController.text = snapshot.emailUser!;
                                });
                                break;
                              case "Restore":
                                service
                                    .markdeleteRestoreUser(
                                        context, snapshot.id as String)
                                    .whenComplete(
                                      () => Future.delayed(
                                        Duration(seconds: 2),
                                        () {
                                          controllerSearch.text.isNotEmpty
                                              ? search()
                                              : _pullRefresh();
                                        },
                                      ),
                                    );

                                break;
                              default:
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Action',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            value: "Action",
                          ),
                          if (authoRoles['canWrite'] != false)
                            DropdownMenuItem(
                              child: Text(
                                'Edit',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                              value: "Edit",
                            ),
                          DropdownMenuItem(
                            child: Text(
                              'Change Password',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            value: "ResetPassword",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

//pop up edit dialog
  Future<dynamic> dialogEdit(BuildContext context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
            title: const Text("Edit User Data"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  // height: 500,
                  width: Dimensions.width100 * 4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //client code
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width08,
                              right: Dimensions.width08,
                              bottom: Dimensions.height08),
                          child: TextFormField(
                            enabled: authoRoles['canWriteAll'] != false
                                ? true
                                : false,
                            controller: _clientCodeController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                labelText: "Client Code",
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
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
                            //firstname
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                      labelText: "First Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius12)),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                            //lastname
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                      labelText: "Last Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius12)),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //email
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        //dateofbirth
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                labelText: "Date of Birth",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        //phonenumber
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius12)),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        //clienttype
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: Dimensions.height500 / 2,
                              value: selectedValue!.isNotEmpty
                                  ? selectedValue
                                  : selectedValue = "",
                              buttonDecoration: BoxDecoration(
                                color: authoRoles['canWriteAll'] != false
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius15 -
                                        Dimensions.radius10 / 10),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,

                                label: const Text("Client Type"),

                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Client Type',
                                style: TextStyle(fontSize: Dimensions.font14),
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: Dimensions.font10 * 3,
                              buttonHeight: Dimensions.height10 * 5,
                              buttonPadding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              items: listOfValue
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: Dimensions.font14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Client Type.';
                                }
                              },
                              onChanged: authoRoles['canWriteAll'] != false
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
                                padding: EdgeInsets.only(
                                  top: Dimensions.height08,
                                  bottom: Dimensions.height08 / 2,
                                  right: Dimensions.width08,
                                  left: Dimensions.width08,
                                ),
                                child: TextFormField(
                                  controller: searchDropClientType,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height08,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle:
                                        TextStyle(fontSize: Dimensions.font12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.font16 / 2),
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
                        //roles type
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: Dimensions.height500 / 2,
                              value: selectedValueRoles!.isNotEmpty
                                  ? selectedValueRoles
                                  : selectedValueRoles = "",

                              buttonDecoration: BoxDecoration(
                                color: rolesType == "superadmin"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius15 -
                                        Dimensions.radius10 / 10),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                // labelText: 'Client Type',
                                label: const Text("Roles Type"),

                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Roles Type',
                                style: TextStyle(fontSize: Dimensions.font14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: Dimensions.font10 * 3,
                              buttonHeight: Dimensions.height10 * 5,
                              buttonPadding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                              ),
                              items: listOfValueRoles
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: Dimensions.font14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Client Type.';
                                }
                              },
                              onChanged: authoRoles['canWriteAll'] != false
                                  ? (value) {
                                      setState(() {
                                        selectedValueRoles = value.toString();
                                      });
                                    }
                                  : null,

                              onSaved: (value) {
                                selectedValueRoles = value.toString();
                              },
                              searchController: searchDropRoles,
                              searchInnerWidget: Padding(
                                padding: EdgeInsets.only(
                                  top: Dimensions.height08,
                                  bottom: Dimensions.height08 / 2,
                                  right: Dimensions.width08,
                                  left: Dimensions.width08,
                                ),
                                child: TextFormField(
                                  controller: searchDropRoles,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10,
                                      vertical: Dimensions.height08,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle:
                                        TextStyle(fontSize: Dimensions.font12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.font16 / 2),
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
                            //cancel button
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
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
                            //comfirm button
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
                                child: ElevatedButton(
                                  onPressed: (() async {
                                    if (_formKey.currentState!.validate()) {
                                      UserData userData = UserData(
                                        id: userId,
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        emailUser: _emailController.text,
                                        clientCode: _clientCodeController.text,
                                        roles: selectedValueRoles as String,
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

//pop up reset password
  Future<dynamic> dialogResetPassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
            title: const Text("Send a link reset password"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  width: Dimensions.width100 * 4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Dimensions.font16 / 2),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Enter your email address",
                              hintStyle: TextStyle(color: Color(0xFF6f6f6f)),
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
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
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
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
                                padding: EdgeInsets.all(Dimensions.font16 / 2),
                                child: ElevatedButton(
                                  onPressed: () {
                                    passwordReset(context);
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

  Future passwordReset(context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Please check email!'),
            );
          });
    } on FirebaseAuthException catch (e) {
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

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      retrievedUserList!.sort((user1, user2) =>
          compareString(ascending, user1.clientCode, user2.clientCode));
    } else if (columnIndex == 1) {
      retrievedUserList!.sort((user1, user2) =>
          compareString(ascending, user1.firstName, user2.firstName));
    } else if (columnIndex == 3) {
      retrievedUserList!.sort((user1, user2) =>
          compareString(ascending, user1.emailUser, user2.emailUser));
    } else if (columnIndex == 8) {
      retrievedUserList!.sort((user1, user2) =>
          compareString(ascending, '${user1.createdAt}', '${user2.createdAt}'));
    } else if (columnIndex == 9) {
      retrievedUserList!.sort((user1, user2) => compareString(
          ascending, '${user1.markDeleted}', '${user2.markDeleted}'));
    }

    setState(() {
      _currentSortColumn = columnIndex;
      _isAscending = ascending;
    });
  }

  int compareString(bool ascending, String? clientCode, String? clientCode2) =>
      ascending
          ? clientCode!.compareTo(clientCode2!)
          : clientCode2!.compareTo(clientCode!);
}
