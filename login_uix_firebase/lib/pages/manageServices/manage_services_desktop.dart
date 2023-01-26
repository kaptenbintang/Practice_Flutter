// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/services_data.dart';

class ManageServicesDesktop extends StatefulWidget {
  const ManageServicesDesktop({super.key});

  @override
  State<ManageServicesDesktop> createState() => _ManageServicesDesktopState();
}

class _ManageServicesDesktopState extends State<ManageServicesDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<ServicesData>>? servicesList;
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
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    servicesList = service.retrieveServices();
    retrievedServicesList = await service.retrieveServices();
    selected = List<bool>.generate(
        retrievedServicesList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedServicesList = await service.retrieveServices();

    setState(() {
      servicesList = service.retrieveServices();
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
                                  //Add button, Container Title, Search textfield and search icon
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
                                                dialogAddNewServices(context);
                                              },
                                            ),
                                          ),
                                          //Container Title
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 5),
                                                    0,
                                                    0,
                                                    0),
                                            child: Text(
                                              'Services',
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          //Search textfield
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
                                          //Search icon button
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
                                        12, 12, 12, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Text(
                                                    'Services',
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
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Expanded(
                                            child: Text(
                                              'Duration',
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
                                              'Category ',
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
                                              'Price',
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
                                        future: servicesList,
                                        builder: (context,
                                            AsyncSnapshot<List<ServicesData>>
                                                snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!.isNotEmpty) {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  retrievedServicesList!.length,
                                              itemBuilder: (context, indexs) {
                                                return _buildTableUser(
                                                    context,
                                                    retrievedServicesList![
                                                        indexs],
                                                    retrievedServicesList,
                                                    indexs);
                                              },
                                            );
                                          } else if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              retrievedServicesList!.isEmpty) {
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

  _buildTableUser(BuildContext context, ServicesData snapshot,
      List<ServicesData>? user, int indexs) {
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
              //Services name
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
                          snapshot.servicesName as String,
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
                //Duration
                Expanded(
                  child: Text(
                    snapshot.duration as String,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                //Category
                Expanded(
                  child: Text(
                    snapshot.categoryName as String,
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
                //Price
                Expanded(
                  child: Text(
                    snapshot.price as String,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
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
                          dialogEditServices(context);
                          setState(() {
                            userId = snapshot.id;
                            servicesNameID = snapshot.servicesName;
                            durationID = snapshot.duration;
                            categoryNameID = snapshot.categoryName;
                            priceID = snapshot.price;
                          });
                        },
                        text: 'Edit',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 75),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: screenWidth / (width / 15),
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: 2.5,
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
                          await service.deleteServices(
                              context, snapshot.id.toString());
                          _pullRefresh();
                        },
                        text: 'Delete',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 75),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: screenWidth / (width / 15),
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2.5,
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

  Future<dynamic> dialogEditServices(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
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
                  right: -(screenWidth / (width / 40)),
                  top: -screenWidth / (width / 80),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
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
                          controller: _serviceNameController,
                          decoration: InputDecoration(
                            labelText: "Service Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText: "Duration",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: TextFormField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
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
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
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
                  right: -(screenWidth / (width / 40)),
                  top: -screenWidth / (width / 80),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                            ));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        height: screenWidth / (width / 40),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
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
