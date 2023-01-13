// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/controllers/navigation_controller.dart';
import 'package:recase/recase.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/user_data.dart';
import '../../routing/routes.dart';
import '../../widgets/alert_confirm.dart';

class ManageClientDesktop extends StatefulWidget {
  const ManageClientDesktop({super.key});

  @override
  State<ManageClientDesktop> createState() => _ManageClientDesktopState();
}

class _ManageClientDesktopState extends State<ManageClientDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<UserData>>? userList;
  Map<String, dynamic>? currentUserData;
  // String? currentUserData;
  List<UserData>? retrievedUserList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  UserData? dataU;
  final controllerSearch = TextEditingController();
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

  int _currentSortColumn = 0;
  bool _isAscending = true;

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

  Future search() async {
    retrievedUserList =
        await service.searchUser(controllerSearch.text.sentenceCase);
    setState(() {
      userList = service.searchUser(controllerSearch.text.sentenceCase);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                screenWidth / (width / 16),
                screenWidth / (width / 16),
                screenWidth / (width / 16),
                screenWidth / (width / 16)),
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
                borderRadius: BorderRadius.circular(screenWidth / (width / 16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        screenWidth / (width / 16),
                        screenWidth / (width / 16),
                        0,
                        screenWidth / (width / 16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dashboard',
                          style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              fontSize: screenWidth / (width / 20)),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, screenWidth / (width / 4), 0, 0),
                          child: Text(
                            'Your project status is appearing here.',
                            style: FlutterFlowTheme.of(context)
                                .bodyText2
                                .override(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth / (width / 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        screenWidth / (width / 12),
                        0,
                        screenWidth / (width / 12),
                        0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              screenWidth / (width / 4),
                              0,
                              screenWidth / (width / 4),
                              screenWidth / (width / 24)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(
                                  screenWidth / (width / 16)),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).lineColor,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  screenWidth / (width / 16),
                                  0,
                                  screenWidth / (width / 12)),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //Add button with container Title
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 5),
                                                    0,
                                                    0,
                                                    0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius:
                                                  screenWidth / (width / 30),
                                              borderWidth: 1,
                                              buttonSize:
                                                  screenWidth / (width / 50),
                                              icon: Icon(
                                                Icons.playlist_add_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                size:
                                                    screenWidth / (width / 25),
                                              ),
                                              onPressed: () {
                                                NavigationController.instance
                                                    .navigateTo(
                                                        AddNewUserRoute);
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 16),
                                                    0,
                                                    0,
                                                    0),
                                            child: Text(
                                              'Client',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title3
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: screenWidth /
                                                            (width / 20),
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: screenWidth / (width / 200),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0,
                                                      screenWidth / (width / 5),
                                                      0,
                                                      screenWidth /
                                                          (width / 5)),
                                              child: Container(
                                                width:
                                                    screenWidth / (width / 200),
                                                child: TextFormField(
                                                  controller: textController,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Search...',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                screenWidth /
                                                                    (width /
                                                                        12)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth /
                                                                  (width / 10)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth /
                                                                  (width / 10)),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth /
                                                                  (width / 10)),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth /
                                                                  (width / 10)),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius:
                                                screenWidth / (width / 30),
                                            borderWidth: 1,
                                            buttonSize:
                                                screenWidth / (width / 50),
                                            icon: Icon(
                                              Icons.search,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: screenWidth / (width / 25),
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //Column Title
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 12),
                                        screenWidth / (width / 12),
                                        screenWidth / (width / 12),
                                        0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          screenWidth /
                                                              (width / 8),
                                                          0,
                                                          0,
                                                          0),
                                                  child: Text(
                                                    'CT Code',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                screenWidth /
                                                                    (width /
                                                                        12)),
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
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 12)),
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
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 12)),
                                            ),
                                          ),
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Expanded(
                                            child: Text(
                                              'Client Type',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 12)),
                                            ),
                                          ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Action',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 12)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Data Row
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, screenWidth / (width / 16), 0, 0),
                                    child: FutureBuilder(
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
                                                    child: Text(
                                                        'No Data Availble'),
                                                  )
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
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
    );
  }

  _buildTableUser(BuildContext context, UserData snapshot, int indexs) {
    // int idx = int.parse(dropDownItemValue2[indexs]);
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return Padding(
      padding:
          EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenWidth / (width / 2)),
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
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          snapshot.clientCode as String,
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth / (width / 16),
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
                    snapshot.emailUser as String,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                Expanded(
                  child: Text(
                    snapshot.phoneNumber,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  child: Text(
                    snapshot.clientType!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              // ButtonRow
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Edit Button
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 0, screenWidth / (width / 5), 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                            dialogEdit(context);
                            setState(() {
                              _emailController.text =
                                  snapshot.emailUser.toString();
                              _clientTypeController.text =
                                  snapshot.clientType as String;
                              _rolesController.text = snapshot.roles as String;
                              _firstNameController.text = snapshot.firstName;
                              _lastNameController.text = snapshot.lastName;
                              _ageController.text = snapshot.doBirth;
                              _clientCodeController.text =
                                  snapshot.clientCode as String;
                              _phoneController.text = snapshot.phoneNumber;
                              userId = snapshot.id;

                              selectedValue = snapshot.clientType;
                              selectedValueRoles = snapshot.roles;
                            });
                          },
                          text: 'Edit',
                          options: FFButtonOptions(
                            width: screenWidth / (width / 60),
                            height: screenWidth / (width / 30),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: GoogleFonts.getFont(
                              'Roboto',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth / (width / 12),
                            ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: 2.5,
                            ),
                            borderRadius: screenWidth / (width / 8),
                          ),
                        ),
                      ),
                    ),
                    //Delete Button
                    if (currentUser?.uid.toString != snapshot.id.toString &&
                        snapshot.markDeleted == false)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              screenWidth / (width / 5), 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              showDialog(
                                context: context,
                                builder: (contextm) {
                                  return AlertDialogConfirm(
                                      type: "Remove",
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
                              width: screenWidth / (width / 63),
                              height: screenWidth / (width / 30),
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: FlutterFlowTheme.of(context).alternate,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth / (width / 12),
                              ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.5,
                              ),
                              borderRadius: screenWidth / (width / 8),
                            ),
                          ),
                        ),
                      ),
                    // if (currentUser?.uid.toString != snapshot.id.toString &&
                    //     snapshot.markDeleted == true)
                    //   Padding(
                    //     padding: EdgeInsetsDirectional.fromSTEB(
                    //         screenWidth / (width / 5), 0, 0, 0),
                    //     child: FFButtonWidget(
                    //       onPressed: () {
                    //         print('Button pressed ...');
                    //         service
                    //             .markdeleteRestoreUser(
                    //                 context, snapshot.id as String)
                    //             .whenComplete(
                    //               () => Future.delayed(
                    //                 Duration(seconds: 2),
                    //                 () {
                    //                   controllerSearch.text.isNotEmpty
                    //                       ? search()
                    //                       : _pullRefresh();
                    //                 },
                    //               ),
                    //             );
                    //       },
                    //       text: 'Restore',
                    //       options: FFButtonOptions(
                    //           width: screenWidth / (width / 75),
                    //           height: screenWidth / (width / 35),
                    //           color: FlutterFlowTheme.of(context)
                    //               .secondaryBackground,
                    //           textStyle: FlutterFlowTheme.of(context)
                    //               .subtitle2
                    //               .override(
                    //                 fontFamily: 'Poppins',
                    //                 color:
                    //                     FlutterFlowTheme.of(context).alternate,
                    //                 fontSize: screenWidth / (width / 15),
                    //               ),
                    //           borderSide: BorderSide(
                    //             color: FlutterFlowTheme.of(context).alternate,
                    //             width: 2.5,
                    //           ),
                    //           borderRadius: screenWidth / (width / 8)),
                    //     ),
                    //   ),
                    //Change Password
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 5), 0, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                            dialogChangePassword(context);
                          },
                          text: 'Change Password',
                          options: FFButtonOptions(
                            width: screenWidth / (width / 63),
                            height: screenWidth / (width / 30),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: GoogleFonts.getFont(
                              'Roboto',
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth / (width / 12),
                            ),
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              width: 2.5,
                            ),
                            borderRadius: screenWidth / (width / 8),
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
    );
  }

  Future<dynamic> dialogEdit(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(screenWidth / (width / 20))),
            title: Text("Edit User Data"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  // height: 500,
                  width: screenWidth / (width / 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth / (width / 8),
                              right: screenWidth / (width / 8),
                              bottom: screenWidth / (width / 8)),
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
                                        screenWidth / (width / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
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
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                      labelText: "First Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth / (width / 12))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth / (width / 12))),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                      labelText: "Last Name",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth / (width / 12))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth / (width / 12))),
                                      fillColor: Colors.grey[200],
                                      filled: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                                labelText: "Age",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 12))),
                                fillColor: Colors.grey[200],
                                filled: true),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(screenWidth / (width / 8)),
                        //   child: TextFormField(
                        //     controller: _rolesController,
                        //     decoration: InputDecoration(
                        //         labelText: "Roles",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(screenWidth / (width / 12))),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(screenWidth / (width / 12))),
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
                        //             borderRadius: BorderRadius.circular(screenWidth / (width / 12))),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(screenWidth / (width / 12))),
                        //         fillColor: Colors.grey[200],
                        //         filled: true),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: screenWidth / (width / 250),
                              value: currentUserData?['roles'] == "Developer"
                                  ? selectedValue!.isNotEmpty
                                      ? selectedValue
                                      : selectedValue == ""
                                  : null,
                              buttonDecoration: BoxDecoration(
                                color: currentUserData?['roles'] == "Developer"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 14)),
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
                                      screenWidth / (width / 15)),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Client Type',
                                style: TextStyle(
                                    fontSize: screenWidth / (width / 14)),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: screenWidth / (width / 30),
                              buttonHeight: screenWidth / (width / 50),
                              buttonPadding: EdgeInsets.only(
                                  left: screenWidth / (width / 20),
                                  right: screenWidth / (width / 10)),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 15)),
                              ),
                              items: listOfValue
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize:
                                                screenWidth / (width / 14),
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
                                  top: screenWidth / (width / 8),
                                  bottom: screenWidth / (width / 4),
                                  right: screenWidth / (width / 8),
                                  left: screenWidth / (width / 8),
                                ),
                                child: TextFormField(
                                  controller: searchDropClientType,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth / (width / 10),
                                      vertical: screenWidth / (width / 8),
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 8)),
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
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                              dropdownMaxHeight: screenWidth / (width / 250),
                              value: currentUserData?['roles'] == "Developer"
                                  ? selectedValueRoles!.isNotEmpty
                                      ? selectedValueRoles
                                      : selectedValueRoles == ""
                                  : null,
                              buttonDecoration: BoxDecoration(
                                color: currentUserData?['roles'] == "Developer"
                                    ? Colors.grey[200]
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 14)),
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
                                      screenWidth / (width / 15)),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Roles Type',
                                style: TextStyle(
                                    fontSize: screenWidth / (width / 14)),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: screenWidth / (width / 30),
                              buttonHeight: screenWidth / (width / 50),
                              buttonPadding: EdgeInsets.only(
                                  left: screenWidth / (width / 20),
                                  right: screenWidth / (width / 10)),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 15)),
                              ),
                              items: listOfValueRoles
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize:
                                                screenWidth / (width / 14),
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
                                  top: screenWidth / (width / 8),
                                  bottom: screenWidth / (width / 4),
                                  right: screenWidth / (width / 8),
                                  left: screenWidth / (width / 8),
                                ),
                                child: TextFormField(
                                  controller: searchDropRoles,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth / (width / 10),
                                      vertical: screenWidth / (width / 8),
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 8)),
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
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
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
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(screenWidth / (width / 20))),
            title: Text("Create new pasword for this user"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                SizedBox(
                  // height: 500,
                  width: screenWidth / (width / 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 12))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 12))),
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
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: newConfirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 12))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 12))),
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
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
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
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
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
