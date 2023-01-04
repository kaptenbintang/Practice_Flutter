// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/serviceCategory_data.dart';

class ManageServiceCategoryDesktop extends StatefulWidget {
  const ManageServiceCategoryDesktop({super.key});

  @override
  State<ManageServiceCategoryDesktop> createState() =>
      _ManageServiceCategoryDesktopState();
}

class _ManageServiceCategoryDesktopState
    extends State<ManageServiceCategoryDesktop> {
  TextEditingController? textController;
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
                  //Title and subtitle
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
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                      //Add Button and Title
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
                                                print('IconButton pressed ...');
                                                dialogAddNewCategory(context);
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
                                              'Services Category',
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
                                      //Search textfield and icon
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
                                                    'Services Category',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize:
                                                                screenWidth /
                                                                    (width /
                                                                        14)),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                        future: sCategoryList,
                                        builder: (context,
                                            AsyncSnapshot<
                                                    List<serviceCategoryClass>>
                                                snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!.isNotEmpty) {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: retrievedsCategoryList!
                                                  .length,
                                              itemBuilder: (context, indexs) {
                                                return _buildTableCategory(
                                                    context,
                                                    retrievedsCategoryList![
                                                        indexs],
                                                    retrievedsCategoryList,
                                                    indexs);
                                              },
                                            );
                                          } else if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              retrievedsCategoryList!.isEmpty) {
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

  _buildTableCategory(BuildContext context, serviceCategoryClass snapshot,
      List<serviceCategoryClass>? user, int indexs) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
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
              //Services Category name
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AutoSizeText(
                      snapshot.categoryName!,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 16),
                          ),
                    ),
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
                          dialogEditCategoryName(context);
                          setState(() {
                            userId = snapshot.id;
                            categoryNameID = snapshot.categoryName;
                          });
                        },
                        text: 'Edit',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 80),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: screenWidth / (width / 16)),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: screenWidth / (width / 2.5),
                            ),
                            borderRadius: screenWidth / (width / 8)),
                      ),
                    ),
                    //Delete Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 5), 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          print('Button pressed ...');
                          await service.deleteServicesCategory(
                              context, snapshot.id.toString());
                          _pullRefresh();
                        },
                        text: 'Delete',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 80),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: screenWidth / (width / 16),
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: screenWidth / (width / 2.5),
                            ),
                            borderRadius: screenWidth / (width / 8)),
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

  Future<dynamic> dialogEditCategoryName(BuildContext context) {
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
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit category"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(screenWidth / (width / 40)),
                  top: -screenWidth / (width / 80),
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
                          controller: _categoryNameController,
                          decoration: InputDecoration(
                            labelText: "category",
                          ),
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
                              serviceCategoryClass
                                  serviceCategoryClassCategory =
                                  serviceCategoryClass(
                                id: userId,
                                categoryName: _categoryNameController.text,
                              );
                              await service.updateServicesCategory(
                                  serviceCategoryClassCategory);
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
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add category"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(screenWidth / (width / 40)),
                  top: -screenWidth / (width / 80),
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
                        height: screenWidth / (width / 40),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              serviceCategoryClass
                                  serviceCategoryClassCategory =
                                  serviceCategoryClass(
                                      id: userId,
                                      categoryName:
                                          _categoryNameController.text);
                              await service.addServicesCategory(
                                  serviceCategoryClassCategory);
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
