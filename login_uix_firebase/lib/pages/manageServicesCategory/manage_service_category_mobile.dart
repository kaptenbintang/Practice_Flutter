// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../model/serviceCategory_data.dart';

class ManageServiceCategoryMobile extends StatefulWidget {
  const ManageServiceCategoryMobile({super.key});

  @override
  State<ManageServiceCategoryMobile> createState() =>
      _ManageServiceCategoryMobileState();
}

class _ManageServiceCategoryMobileState
    extends State<ManageServiceCategoryMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<serviceCategoryClass>>? sCategoryList;
  Map<String, dynamic>? currentserviceCategoryClass;
  List<serviceCategoryClass>? retrievedsCategoryList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  serviceCategoryClass? dataU;
  final FocusNode dropDownFocus = FocusNode();

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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                ),
              ),
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
                    //Title and Subtitle
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
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Container title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          'Services Category',
                                          style: FlutterFlowTheme.of(context)
                                              .title3,
                                        ),
                                      ),
                                      //Search textfield icon, add button
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 5, 0, 5),
                                                  child: Container(
                                                    width: 150,
                                                    child: TextFormField(
                                                      controller:
                                                          textController,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Search...',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            lineHeight: 1.01,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 30,
                                                    borderWidth: 1,
                                                    buttonSize: 40,
                                                    icon: Icon(
                                                      Icons.search,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            icon: Icon(
                                              Icons.playlist_add,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ],
                                      ),
                                      //Column title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Text(
                                                    'Services Category',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ),
                                              ],
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
                                      //Data row
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                        child: FutureBuilder(
                                            future: sCategoryList,
                                            builder: (context,
                                                AsyncSnapshot<
                                                        List<
                                                            serviceCategoryClass>>
                                                    snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data!.isNotEmpty) {
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      retrievedsCategoryList!
                                                          .length,
                                                  itemBuilder:
                                                      (context, indexs) {
                                                    return _buildTableUser(
                                                        context,
                                                        retrievedsCategoryList![
                                                            indexs],
                                                        retrievedsCategoryList,
                                                        indexs);
                                                  },
                                                );
                                              } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done &&
                                                  retrievedsCategoryList!
                                                      .isEmpty) {
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

  _buildTableUser(BuildContext context, serviceCategoryClass snapshot,
      List<serviceCategoryClass>? user, int indexs) {
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
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
              //service catg name
              AutoSizeText(
                snapshot.categoryName!,
                style: FlutterFlowTheme.of(context).subtitle1,
              ),
              //dropdown
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      focusNode: dropDownFocus,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(30),
                      iconSize: 40,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      onChanged: (value) {
                        print(value);
                        // if value doesnt contain just close the dropDown
                        if (value == null) {
                          dropDownFocus.unfocus();
                        } else {
                          switch (value) {
                            case "Remove":
                              print('Button pressed ...');
                              service.deleteServicesCategory(
                                  context, snapshot.id.toString());
                              _pullRefresh();
                              break;
                            case "Edit":
                              print('Button pressed ...');
                              dialogEditCategoryName(context);
                              setState(() {
                                userId = snapshot.id;
                                categoryNameID = snapshot.categoryName;
                              });
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
                        DropdownMenuItem(
                          child: Text('Remove'),
                          value: "Remove",
                        ),
                      ],
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
