// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/roles_data.dart';

class ManageRolesDesktop extends StatefulWidget {
  const ManageRolesDesktop({super.key});

  @override
  State<ManageRolesDesktop> createState() => _ManageRolesDesktopState();
}

class _ManageRolesDesktopState extends State<ManageRolesDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<RolesData>>? rolesList;
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
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    rolesList = service.retrieveRoles();
    retrievedRolesList = await service.retrieveRoles();
    selected =
        List<bool>.generate(retrievedRolesList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedRolesList = await service.retrieveRoles();

    setState(() {
      rolesList = service.retrieveRoles();
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
                  //Title and Subtitle
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
                                    fontSize: screenWidth / (width / 14)),
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
                                  //Add button, Container title, Search textfield and search icon
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          //Add Button
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
                                                dialogAddNewRoles(context);
                                              },
                                            ),
                                          ),
                                          //Container Title
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 16),
                                                    0,
                                                    0,
                                                    0),
                                            child: Text(
                                              'Roles Accessibility',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title3
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 20)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //Search textfield and search icon
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
                                                                        14)),
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
                                                      .bodyText1,
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
                                            onPressed: () {},
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
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 12),
                                                    0,
                                                    0,
                                                    0),
                                            child: Text(
                                              'Roles',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        ),
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Expanded(
                                            child: Text(
                                              'Can Read',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                        ))
                                          Expanded(
                                            child: Text(
                                              'Can Edit',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Expanded(
                                            child: Text(
                                              'Can Edit All',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        Expanded(
                                          child: Text(
                                            'Can Delete',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 14)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Action',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 14)),
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
                                        future: rolesList,
                                        builder: (context,
                                            AsyncSnapshot<List<RolesData>>
                                                snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!.isNotEmpty) {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  retrievedRolesList!.length,
                                              itemBuilder: (context, indexs) {
                                                return _buildTableUser(
                                                    context,
                                                    retrievedRolesList![indexs],
                                                    retrievedRolesList,
                                                    indexs);
                                              },
                                            );
                                          } else if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              retrievedRolesList!.isEmpty) {
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

  _buildTableUser(BuildContext context, RolesData snapshot,
      List<RolesData>? user, int indexs) {
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
              //Roles Type Name
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          snapshot.rolesName as String,
                          style:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth / (width / 18),
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Can Read Checkbox
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: snapshot.canRead,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return FlutterFlowTheme.of(context).primaryColor;
                        }
                        return FlutterFlowTheme.of(context).primaryColor;
                      }),
                      checkColor: Colors.white,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              //Can Edit Checkbox
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: snapshot.canWrite,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return FlutterFlowTheme.of(context).primaryColor;
                        }
                        return FlutterFlowTheme.of(context).primaryColor;
                      }),
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              //Can Edit All Checkbox
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: snapshot.canWriteAll,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return FlutterFlowTheme.of(context).primaryColor;
                        }
                        return FlutterFlowTheme.of(context).primaryColor;
                      }),
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              //Can Delete Checkbox
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: snapshot.canDelete,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return FlutterFlowTheme.of(context).primaryColor;
                        }
                        return FlutterFlowTheme.of(context).primaryColor;
                      }),
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              //Action Button
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Edit Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, screenWidth / (width / 5), 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
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
                        text: 'Edit',
                        options: FFButtonOptions(
                          width: screenWidth / (width / 58),
                          height: screenWidth / (width / 35),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                fontSize: screenWidth / (width / 16),
                              ),
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2.5,
                          ),
                          borderRadius: screenWidth / (width / 8),
                        ),
                      ),
                    ),
                    //Delete Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 5), 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                          service.deleteRoles(context, snapshot.id.toString());
                          _pullRefresh();
                        },
                        text: 'Delete',
                        options: FFButtonOptions(
                          width: screenWidth / (width / 76),
                          height: screenWidth / (width / 35),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: screenWidth / (width / 16)),
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.5,
                          ),
                          borderRadius: screenWidth / (width / 8),
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

  Future<dynamic> dialogEditRoles(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
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
                  right: -(screenWidth / (width / 40)),
                  top: -(screenWidth / (width / 80)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWrite,
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWriteAll,
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: DropdownButtonFormField(
                          value: _isRead,
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        height: screenWidth / (width / 40),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
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
                  right: -(screenWidth / (width / 40)),
                  top: -(screenWidth / (width / 80)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        height: screenWidth / (width / 40),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
