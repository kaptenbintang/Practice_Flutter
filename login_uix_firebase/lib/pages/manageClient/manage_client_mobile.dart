// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, sort_child_properties_last, unnecessary_this, body_might_complete_normally_nullable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../model/user_data.dart';

class ManageClientMobile extends StatefulWidget {
  const ManageClientMobile({super.key});

  @override
  State<ManageClientMobile> createState() => _ManageClientMobileState();
}

class _ManageClientMobileState extends State<ManageClientMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<UserData>>? userList;
  Map<String, dynamic>? currentUserData;
  // String? currentUserData;
  List<UserData>? retrievedUserList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  UserData? dataU;

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
  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  String? userId;

  String? selectedValueRoles;
  String? selectedValue;
  late String selectedValue2;
  late String initialDropDownVal;
  var newPassword = "";

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
  List<String> dropDownItemValue2 = ['Action', 'Edit', 'Remove'];

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
    // selectedValue = listOfValue[0]

    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    userList = service.retrieveClientNotDeleted();
    retrievedUserList = await service.retrieveClientNotDeleted();
    selected =
        List<bool>.generate(retrievedUserList!.length, (int index) => false);
    valuesList = List<String>.generate(
        retrievedUserList!.length, (int index) => 'Action');
    currentUserData = await service.currentUsers(currentUser!.uid);
    print(currentUserData!["roles"]);
  }

  Future<void> _pullRefresh() async {
    retrievedUserList = await service.retrieveClientNotDeleted();

    setState(() {
      userList = service.retrieveClientNotDeleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
              Dimensions.height08 * 2,
              Dimensions.width16,
              Dimensions.height08 * 2),
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
              borderRadius: BorderRadius.circular(Dimensions.font16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title and subtitle
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(Dimensions.width16,
                      Dimensions.height08 * 2, 0, Dimensions.height08 * 2),
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
                            0, Dimensions.height08 / 2, 0, 0),
                        child: Text(
                          'Your project status is appearing here.',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                //Content
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
                      borderRadius: BorderRadius.circular(Dimensions.font16),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).lineColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0,
                          Dimensions.height08 * 2, 0, Dimensions.height24 / 2),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Title
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  Dimensions.width16, 0, 0, 0),
                              child: Text(
                                'Client',
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                            ),
                            //Search Row
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Search textfield
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.width10,
                                      Dimensions.height05,
                                      0,
                                      Dimensions.height05),
                                  child: Container(
                                    width: Dimensions.width100 +
                                        Dimensions.width10 * 5,
                                    child: TextFormField(
                                      controller: textController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 3),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
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
                                        focusedErrorBorder: OutlineInputBorder(
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
                                            lineHeight: 1.01,
                                          ),
                                    ),
                                  ),
                                ),
                                //Search iconbutton
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.width10 / 2, 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: Dimensions.radius30,
                                    borderWidth: 1,
                                    buttonSize: Dimensions.font20 * 2,
                                    icon: Icon(
                                      Icons.search,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: Dimensions.font20,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            //Sub Title of each column
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  Dimensions.width24 / 2,
                                  Dimensions.height24 / 2,
                                  Dimensions.width24 / 2,
                                  0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //CT Code Column
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width10, 0, 0, 0),
                                    child: Text(
                                      'CT Code',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                    ),
                                  ),
                                  //ACtion Column
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
                            //Data ListVIew
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, Dimensions.height08 * 2, 0, 0),
                              child: FutureBuilder(
                                  future: userList,
                                  builder: (context,
                                      AsyncSnapshot<List<UserData>> snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: retrievedUserList!.length,
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
                                                  AlignmentDirectional.center,
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
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height10 / 5),
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
              Dimensions.width24 / 2,
              Dimensions.height24 / 2,
              Dimensions.width24 / 2,
              Dimensions.height24 / 2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                              snapshot.emailUser as String,
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
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
                          print(value);
                          // if value doesnt contain just close the dropDown
                          if (value == null) {
                            dropDownFocus.unfocus();
                          } else {
                            switch (value) {
                              case "Remove":
                                break;
                              case "Edit":
                                dialogEdit(context);
                                setState(() {
                                  _emailController.text =
                                      snapshot.emailUser.toString();
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
                                });
                                break;
                              case "Change Password":
                                dialogChangePassword(context);

                                break;
                              default:
                            }
                          }
                        },
                        // items: List.generate(
                        //     dropDownItemValue2.length,
                        //     (index) => DropdownMenuItem(
                        //           value: dropDownItemValue2[index],
                        //           child: Text(dropDownItemValue2[index]),
                        //         )),
                        items: [
                          DropdownMenuItem(
                            child: Text('Action'),
                            value: "Action",
                          ),
                          DropdownMenuItem(
                            child: Text('Edit'),
                            value: "Edit",
                          ),
                          if (currentUser?.uid.toString != snapshot.id.toString)
                            DropdownMenuItem(
                              child: Text('Remove'),
                              value: "Remove",
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogEdit(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
            title: Text("Edit User Data"),
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
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width08,
                              right: Dimensions.width08,
                              bottom: Dimensions.height08),
                          child: TextFormField(
                            enabled: currentUserData?["roles"] == 'Developer'
                                ? true
                                : false,
                            controller: _clientCodeController,
                            decoration: InputDecoration(
                                labelText: "Client Code",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
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
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                labelText: "Age",
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
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
                        // Padding(
                        //   padding: EdgeInsets.all(Dimensions.height08),
                        //   child: TextFormField(
                        //     controller: _rolesController,
                        //     decoration: InputDecoration(
                        //         labelText: "Roles",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(Dimensions.radius12)),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(Dimensions.radius12)),
                        //         fillColor: Colors.grey[200],
                        //         filled: true),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.all(8),
                        //   child: TextFormField(
                        //     controller: _clientTypeController,
                        //     decoration: InputDecoration(
                        //         labelText: "Client Type",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(Dimensions.radius12)),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(Dimensions.radius12)),
                        //         fillColor: Colors.grey[200],
                        //         filled: true),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: Dimensions.height100 +
                                  Dimensions.height10 * 5,
                              value: currentUserData?['roles'] == "Developer"
                                  ? selectedValue!.isNotEmpty
                                      ? selectedValue
                                      : selectedValue == ""
                                  : null,
                              buttonDecoration: BoxDecoration(
                                color: currentUserData?['roles'] == "Developer"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius:
                                    BorderRadius.circular(Dimensions.font14),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                // labelText: 'Client Type',
                                label: Text("Client Type"),

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
                              onChanged:
                                  currentUserData?['roles'] == "Developer"
                                      ? (value) {
                                          selectedValue = value.toString();

                                          //Do something when changing the item if you want.
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
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: Dimensions.height100 +
                                  Dimensions.height10 * 5,
                              value: currentUserData?['roles'] == "Developer"
                                  ? selectedValueRoles!.isNotEmpty
                                      ? selectedValueRoles
                                      : selectedValueRoles == ""
                                  : null,
                              buttonDecoration: BoxDecoration(
                                color: currentUserData?['roles'] == "Developer"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius:
                                    BorderRadius.circular(Dimensions.font14),
                              ),
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                // labelText: 'Client Type',
                                label: Text("Roles Type"),

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
                              onChanged:
                                  currentUserData?['roles'] == "Developer"
                                      ? (value) {
                                          selectedValueRoles = value.toString();

                                          //Do something when changing the item if you want.
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedValueRoles == "";
                                      selectedValue == "";
                                    });
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
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
                                        doBirth: _ageController.text,
                                        phoneNumber: _phoneController.text,
                                        clientType: selectedValue as String,
                                      );
                                      await service.updateUser(userData);
                                    }
                                  }),
                                  child: Text('Confirm'),
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

  Future<dynamic> dialogChangePassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
            title: Text("Create new pasword for this user"),
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
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        FlutterPwValidator(
                            width: 350,
                            height: 110,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            onSuccess: () {
                              print("submitted");
                            },
                            controller: newPasswordController),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: newConfirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height08),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        newPassword =
                                            newPasswordController.text;
                                      });
                                      changePassword();
                                    }
                                  },
                                  child: Text('Confirm'),
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

  changePassword() async {
    if (passwordConfirmed()) {
      try {
        await this.currentUser!.updatePassword(selectedValue2);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Change Password Successfully"),
              );
            });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.black26,
        //   content: Text("Your password has been changed & login again!"),
        // ));
      } catch (error) {}
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
    // TODO: implement dispose
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
}
