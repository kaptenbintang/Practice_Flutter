// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/user_privilege.dart';
import '../../model/roles_data.dart';
import '../../model/user_data.dart';
import '../../widgets/alert_confirm.dart';

class ManageStaffDesktop extends StatefulWidget {
  const ManageStaffDesktop({super.key});

  @override
  State<ManageStaffDesktop> createState() => _ManageStaffDesktopState();
}

class _ManageStaffDesktopState extends State<ManageStaffDesktop> {
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

  // bool _sortAscending = true;
  // int? _sortColumnIndex;

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

  final controllerSearch = TextEditingController();

  @override
  void initState() {
    // selectedValue2 = dropDownItemValue2[0];

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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
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
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Your project status is appearing here.',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(4, 0, 4, 24),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).lineColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 16, 0, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Text(
                                            'My Staff',
                                            style: FlutterFlowTheme.of(context)
                                                .title3,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 5),
                                                child: Container(
                                                  width: 200,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerSearch,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText: 'Search...',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 50,
                                              icon: Icon(
                                                Icons.search,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                                controllerSearch.text.isNotEmpty
                                                    ? search()
                                                    : _pullRefresh();
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Visibility(
                                                  visible:
                                                      selectedUser.isNotEmpty
                                                          ? true
                                                          : false,
                                                  child: Text(
                                                    'Selected ${selectedUser.length} Users out of ${retrievedUserList?.length}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              //Deleteiconbutton
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                borderWidth: 1,
                                                buttonSize: 50,
                                                icon: Icon(
                                                  Icons.delete_sweep,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                  showDialog(
                                                    context: context,
                                                    builder: (contextm) {
                                                      return AlertDialogConfirm(
                                                          type: 'Remove',
                                                          ids: selectedUser
                                                              .map((e) => e.id!)
                                                              .toList(),
                                                          contexts: context,
                                                          textDesc:
                                                              'Are you sure?');
                                                    },
                                                  ).whenComplete(
                                                    () => Future.delayed(
                                                      Duration(seconds: 2),
                                                      () {
                                                        controllerSearch
                                                                .text.isNotEmpty
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
                                            ]),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                //select all button
                                                Checkbox(
                                                  splashRadius: 30,
                                                  value: selectedUser.isNotEmpty
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        selectedUser = value!
                                                            ? retrievedUserList!
                                                            : []);

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    1500),
                                                        width: 300.0,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        content: Text(
                                                          'All user selected: $value',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 0),
                                                    child: Text(
                                                      'CT Code',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Email',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                          ))
                                            Expanded(
                                              child: Text(
                                                'Phone Number',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Expanded(
                                              child: Text(
                                                'Roles',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                          Expanded(
                                            child: Text(
                                              'Action',
                                              textAlign: TextAlign.end,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
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
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        retrievedUserList!
                                                            .length,
                                                    itemBuilder:
                                                        (context, indexs) {
                                                      return _buildTableUser(
                                                          context,
                                                          retrievedUserList![
                                                              indexs],
                                                          indexs);
                                                    },
                                                  );
                                                } else if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done &&
                                                    retrievedUserList!
                                                        .isEmpty) {
                                                  return Center();
                                                } else {
                                                  return ColoredBox(
                                                      color: Colors.black);
                                                }
                                              }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, UserData snapshot, int indexs) {
    // int idx = int.parse(dropDownItemValue2[indexs]);
    if (rolesType! != "superadmin") {
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
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
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
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
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
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      flex: 2,
                      child: Text(
                        snapshot.emailUser,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                  ))
                    Expanded(
                      child: Text(
                        snapshot.phoneNumber,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      child: Text(
                        snapshot.roles!,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              dialogEdit(context);
                              setState(() {
                                _emailController.text = snapshot.emailUser;
                                _clientTypeController.text =
                                    snapshot.clientType as String;
                                _rolesController.text =
                                    snapshot.roles as String;
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
                            },
                            text: 'Edit',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              dialogResetPassword(context);
                              setState(() {
                                _emailController.text = snapshot.emailUser;
                              });
                            },
                            text: 'ResetPassword',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                      ],
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
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
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
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
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
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      flex: 2,
                      child: Text(
                        snapshot.emailUser,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                  ))
                    Expanded(
                      child: Text(
                        snapshot.phoneNumber,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      child: Text(
                        snapshot.roles!,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              dialogEdit(context);
                              setState(() {
                                _emailController.text = snapshot.emailUser;
                                _clientTypeController.text =
                                    snapshot.clientType as String;
                                _rolesController.text =
                                    snapshot.roles as String;
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
                            },
                            text: 'Edit',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              showDialog(
                                context: context,
                                builder: (contextm) {
                                  return AlertDialogConfirm(
                                      type: "Delete",
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
                            },
                            text: 'Delete',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              dialogResetPassword(context);
                              setState(() {
                                _emailController.text = snapshot.emailUser;
                              });
                            },
                            text: 'Reset Password',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
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
                            },
                            text: 'Restore',
                            options: FFButtonOptions(
                                width: 75,
                                height: 35,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontSize: 15,
                                    ),
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.5,
                                ),
                                borderRadius: 8),
                          ),
                        ),
                      ],
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
                        //client code
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
                            //firstname
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
                            //lastname
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
                        //email
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
                        //dateofbirth
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                labelText: "Date of Birth",
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
                        //phonenumber
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
                        //clienttype
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: 250,
                              value: selectedValue!.isNotEmpty
                                  ? selectedValue
                                  : selectedValue = "",
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
                        //roles type
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
                            //cancel button
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
                            //comfirm button
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

//pop up reset password
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
