// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';

class ManageAppointmentDesktop extends StatefulWidget {
  const ManageAppointmentDesktop({super.key});

  @override
  State<ManageAppointmentDesktop> createState() =>
      _ManageAppointmentDesktopState();
}

class _ManageAppointmentDesktopState extends State<ManageAppointmentDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<AppointmentData>>? AppointmentList;
  Map<String, dynamic>? currentAppointmentData;
  List<AppointmentData>? retrievedAppointmentList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  AppointmentData? dataU;
  final _practionername = TextEditingController();
  final _location = TextEditingController();
  final _services = TextEditingController();
  final _date = TextEditingController();
  final _clientcodeorname = TextEditingController();
  final _clientphnumber = TextEditingController();
  final _clientemail = TextEditingController();
  final _clientcomment = TextEditingController();
  final _statusAppointment = TextEditingController();
  final _createdAt = TextEditingController();
  final _time = TextEditingController();

  String? appointmentId;
  String? userId;
  String? practionerId;
  String? locationID;
  String? servicesID;
  String? dateandtimeID;
  String? clientCodeorNameID;
  String? clientphNumberID;
  String? clientEmail;
  String? clientcommentID;
  String? statusAppointmentID;
  String? createdAtID;
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
    // listofColumn = (await service.retrieveClientType()).cast<Map<String, dynamic>>();
    AppointmentList = service.retrieveApppointmentAll();
    retrievedAppointmentList = await service.retrieveApppointmentAll();
    selected = List<bool>.generate(
        retrievedAppointmentList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedAppointmentList = await service.retrieveApppointmentAll();

    setState(() {
      // CircularProgressIndicator();
      AppointmentList = service.retrieveApppointmentAll();
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
      child: Padding(
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
                blurRadius: screenWidth / (width / 4),
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
                            fontSize: screenWidth / (width / 20),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, screenWidth / (width / 4), 0, 0),
                      child: Text(
                        'Your project status is appearing here.',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 14)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    screenWidth / (width / 16),
                    0,
                    screenWidth / (width / 16),
                    24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius:
                        BorderRadius.circular(screenWidth / (width / 16)),
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
                        //Add button, Title, Search textfield and icon
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Add Button and Title
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      screenWidth / (width / 5), 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: screenWidth / (width / 30),
                                    borderWidth: 1,
                                    buttonSize: screenWidth / (width / 50),
                                    icon: Icon(
                                      Icons.refresh,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: screenWidth / (width / 25),
                                    ),
                                    onPressed: () {
                                      // print(
                                      //     'IconButton pressed ...');
                                      // dialogaddPractioner(context);
                                      _pullRefresh();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      screenWidth / (width / 5), 0, 0, 0),
                                  child: Text(
                                    'Appointment',
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 20),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            //Search textfield and icon
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 200,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, screenWidth / (width / 5), 0, 5),
                                    child: Container(
                                      width: 200,
                                      child: TextFormField(
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: screenWidth /
                                                          (width / 14)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  screenWidth / (width / 14),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: screenWidth / (width / 30),
                                  borderWidth: 1,
                                  buttonSize: screenWidth / (width / 50),
                                  icon: Icon(
                                    Icons.search,
                                    color: FlutterFlowTheme.of(context)
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
                                flex: 2,
                                child: Text(
                                  'Appointment ID',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 14)),
                                ),
                              ),
                              Expanded(
                                // flex: 2,
                                child: Text(
                                  'Client Name/Code',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
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
                                    'Client Phone Number',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                              ))
                                Expanded(
                                  child: Text(
                                    'Client E-mail',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                              ))
                                Expanded(
                                  child: Text(
                                    'Booking Date',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  'Status',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 14)),
                                ),
                              ),
                              // Expanded(
                              //   child: Text(
                              //     'Created at',
                              //     style:
                              //         FlutterFlowTheme.of(context)
                              //             .bodyText2.override(
                              // fontFamily: 'Poppins',
                              // fontSize: screenWidth / (width / 14)),
                              //   ),
                              // ),
                              Expanded(
                                child: Text(
                                  'Action',
                                  textAlign: TextAlign.end,
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
                        //Data Row
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, screenWidth / (width / 16), 0, 0),
                          child: FutureBuilder(
                              future: AppointmentList,
                              builder: (context,
                                  AsyncSnapshot<List<AppointmentData>>
                                      snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: retrievedAppointmentList!.length,
                                    itemBuilder: (context, indexs) {
                                      return _buildTableUser(
                                          context,
                                          retrievedAppointmentList![indexs],
                                          retrievedAppointmentList,
                                          indexs);
                                    },
                                  );
                                } else if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    retrievedAppointmentList!.isEmpty) {
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
            ],
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, AppointmentData snapshot,
      List<AppointmentData>? user, int indexs) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;

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
          padding: EdgeInsetsDirectional.fromSTEB(
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Client ID
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  snapshot.clientId!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              // ClientName/Code
              Expanded(
                // flex: 1,
                child: AutoSizeText(
                  snapshot.clientNameorCode!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              //phonenumber
              Expanded(
                // flex: 2,
                child: Text(
                  snapshot.clientphNumber!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              //email
              Expanded(
                child: Text(
                  snapshot.clientEmail!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              //date
              Expanded(
                child: Text(
                  snapshot.date!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              //status
              Expanded(
                child: Text(
                  snapshot.statusAppointment!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14),
                      ),
                ),
              ),
              // Expanded(
              //   child: Text(
              //     snapshot.createdAt!,
              //     style: FlutterFlowTheme.of(context).bodyText1.override(
              //   fontFamily: 'Poppins',
              //   fontSize: screenWidth / (width / 14),
              // ),
              //   ),
              // ),
              //Action Button
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Edit button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, screenWidth / (width / 5), 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          dialogEditAppointment(context);
                          setState(() {
                            practionerId = snapshot.practionerId;
                            appointmentId = snapshot.id;
                            userId = snapshot.clientId;
                            _time.text = snapshot.time!;
                            _practionername.text =
                                snapshot.practionerName.toString();
                            _services.text = snapshot.services.toString();
                            _location.text = snapshot.location.toString();
                            _date.text = snapshot.date.toString();
                            _clientcodeorname.text =
                                snapshot.clientNameorCode.toString();
                            _clientphnumber.text =
                                snapshot.clientphNumber.toString();
                            _clientemail.text = snapshot.clientEmail.toString();
                            _clientcomment.text =
                                snapshot.clientComment.toString();
                            _statusAppointment.text =
                                snapshot.statusAppointment.toString();
                            _createdAt.text = snapshot.createdAt.toString();
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
                              width: screenWidth / (width / 2.5),
                            ),
                            borderRadius: 8),
                      ),
                    ),
                    //Delete Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 5), 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await service.deleteAppointment(
                              context, snapshot.id!);
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
                              width: screenWidth / (width / 2.5),
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
    );
  }

  Future<dynamic> dialogEditAppointment(BuildContext context) {
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
            title: const Text("Edit Appointment"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: screenWidth / (width / -40),
                  top: screenWidth / (width / -80),
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
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _practionername,
                          decoration: InputDecoration(
                            labelText: "Practioner Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _services,
                          decoration: InputDecoration(
                            labelText: "Services",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _location,
                          decoration: InputDecoration(
                            labelText: "Location",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _date,
                          decoration: InputDecoration(
                            labelText: "Date",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _time,
                          decoration: InputDecoration(
                            labelText: "Time",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _clientcodeorname,
                          decoration: InputDecoration(
                            labelText: "Code or Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _clientphnumber,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _clientemail,
                          decoration: InputDecoration(
                            labelText: "Client Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _clientcomment,
                          decoration: InputDecoration(
                            labelText: "Comment",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: _statusAppointment.text,
                          decoration: InputDecoration(
                            labelText: "Status",
                          ),
                          // icon: Icon(
                          //   Icons.edit,
                          //   color: Colors.blue,
                          // ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _statusAppointment.text = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: <String>['ongoing', 'Complete', 'Cancel']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _createdAt,
                          decoration: InputDecoration(
                            labelText: "CreatedAt",
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
                              AppointmentData appointmentData = AppointmentData(
                                  id: appointmentId,
                                  clientId: userId,
                                  practionerName: _practionername.text,
                                  practionerId: practionerId,
                                  services: _services.text,
                                  location: _location.text,
                                  date: _date.text,
                                  time: _time.text,
                                  clientNameorCode: _clientcodeorname.text,
                                  clientphNumber: _clientphnumber.text,
                                  clientEmail: _clientemail.text,
                                  clientComment: _clientcomment.text,
                                  statusAppointment: _statusAppointment.text,
                                  createdAt: _createdAt.text);
                              await service.updateAppointment(appointmentData);
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
