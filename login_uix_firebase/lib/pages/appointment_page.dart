import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import '../helper/database_service.dart';
import '../route.dart';
import 'main_page.dart';
import 'package:intl/intl.dart';

class appointmentPage extends StatefulWidget {
  static const routeName = '/appointmentPage';
  const appointmentPage({Key? key}) : super(key: key);

  @override
  _appointmentPageState createState() => _appointmentPageState();
}

class _appointmentPageState extends State<appointmentPage> {
  String? _selectedDate;
  // String? userId;
  String? dropDownServices;
  String? dropDownLocation;
  String? dropDownNameorCode;
  TextEditingController? pnameController;
  TextEditingController? dateandtimeController;
  TextEditingController? searchController;
  TextEditingController? emailController;
  TextEditingController? phNumbController;
  TextEditingController? commentController;
  DataService service = DataService();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _myBox = Hive.box('myBox');
  final now = DateTime.now();
  late BookingService mockBookingService;
  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>>? currentUserData;
  Map<String, dynamic>? retrievedUserData;

  var uid;
  var fName, lName, uEmail, phNumb, clientCode;

  Future<void> _initRetrieval() async {
    currentUserData = service.currentUsers(user.uid);
    retrievedUserData = await service.currentUsers(user.uid);
    // print(retrievedUserData!['id']);
    fName = retrievedUserData!["firstName"];
    lName = retrievedUserData!["lastName"];
    phNumb = retrievedUserData!["phoneNumber"];
    clientCode = retrievedUserData!["clientcode"];
    uEmail = retrievedUserData!["email"];
  }

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    setState(() {
      pnameController?.text = _myBox.get('name');
      // userId = _myBox.get('id');
    });
    searchController = TextEditingController();
    dateandtimeController = TextEditingController();
    emailController = TextEditingController();
    commentController = TextEditingController();
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 9, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    setState(() {
      dateandtimeController?.text = DateFormat('yyyy-MM-dd – kk:mm:a')
          .format(newBooking.bookingStart)
          .toString();
    });
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  void dispose() {
    searchController?.dispose();
    pnameController?.dispose();
    dateandtimeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);
    final Stream<QuerySnapshot> _locationStream = FirebaseFirestore.instance
        .collection('location')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 40, 0, 100),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.MainPagesPage);
                                            },
                                            child: Text(
                                              'Home',
                                              textAlign: TextAlign.justify,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.viewProfilePage);
                                          },
                                          child: Text(
                                            'Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: Text(
                                          'Contact us',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: searchController,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search Something here..',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 100, 100),
                              child: Image.network(
                                'lib/images/Logo-Slogan-BL-H400-W1080.png',
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1.5,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 1.5,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 60, 20, 20),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1.5,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Form(
                                            key: formKey,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
                                                    child: Text(
                                                      'Make an appointment!',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Practioner Name: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: TextFormField(
                                                            controller:
                                                                pnameController,
                                                            autofocus: true,
                                                            obscureText: false,
                                                            readOnly: true,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: _myBox
                                                                  .get('name'),
                                                              // enabled: false,
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Services: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(123,
                                                                    20, 20, 20),
                                                        child: StreamBuilder<
                                                                QuerySnapshot>(
                                                            stream:
                                                                _categoryStream,
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              // if (snapshot
                                                              //         .connectionState ==
                                                              //     ConnectionState
                                                              //         .waiting) {
                                                              //   return Text(
                                                              //       'Loading');
                                                              // }
                                                              if (snapshot
                                                                      .hasData &&
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .isNotEmpty) {
                                                                return FlutterFlowDropDown(
                                                                  options: snapshot
                                                                      .data!
                                                                      .docs
                                                                      .map((DocumentSnapshot
                                                                          document) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            document.data()!
                                                                                as Map<String, dynamic>;
                                                                        return data[
                                                                            "categoryName"];
                                                                      })
                                                                      .toList()
                                                                      .cast<
                                                                          String>(),
                                                                  onChanged: (val) =>
                                                                      setState(() =>
                                                                          dropDownServices =
                                                                              val),
                                                                  initialOption:
                                                                      dropDownServices,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.06,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle1,
                                                                  hintText:
                                                                      'Please select..',
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineColor,
                                                                  elevation: 0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  borderWidth:
                                                                      1,
                                                                  borderRadius:
                                                                      8,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          4,
                                                                          12,
                                                                          4),
                                                                  hidesUnderline:
                                                                      true,
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Date: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      165,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: TextFormField(
                                                            controller:
                                                                dateandtimeController,
                                                            autofocus: true,
                                                            obscureText: false,
                                                            readOnly: true,
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      // actions: <
                                                                      //     Widget>[
                                                                      //   Container(
                                                                      //     height:
                                                                      //         30,
                                                                      //     child:
                                                                      //         MaterialButton(
                                                                      //       color:
                                                                      //           Colors.green,
                                                                      //       child:
                                                                      //           Text(
                                                                      //         'Set',
                                                                      //         style: TextStyle(color: Colors.white),
                                                                      //       ),
                                                                      //       onPressed:
                                                                      //           () {
                                                                      //         setState(() {
                                                                      //           // date_of_birth = date_controller.text;
                                                                      //         });

                                                                      //         Navigator.of(context).pop();
                                                                      //       },
                                                                      //     ),
                                                                      //   ),
                                                                      //   TextButton(
                                                                      //     child:
                                                                      //         Text('Cancel'),
                                                                      //     onPressed:
                                                                      //         () {
                                                                      //       setState(() {
                                                                      //         // date_controller.text = date_of_birth;
                                                                      //       });

                                                                      //       Navigator.of(context).pop();
                                                                      //     },
                                                                      //   ),
                                                                      // ],
                                                                      content:
                                                                          Container(
                                                                        height:
                                                                            600,
                                                                        width:
                                                                            600,
                                                                        child:
                                                                            BookingCalendar(
                                                                          bookingService:
                                                                              mockBookingService,
                                                                          convertStreamResultToDateTimeRanges:
                                                                              convertStreamResultMock,
                                                                          getBookingStream:
                                                                              getBookingStreamMock,
                                                                          uploadBooking:
                                                                              uploadBookingMock,
                                                                          pauseSlots:
                                                                              generatePauseSlots(),
                                                                          pauseSlotText:
                                                                              'LUNCH',
                                                                          hideBreakTime:
                                                                              false,
                                                                          loadingWidget: Align(
                                                                              alignment: Alignment.center,
                                                                              child: const Text('Fetching data...')),
                                                                          uploadingWidget: Align(
                                                                              alignment: Alignment.center,
                                                                              child: const Text('Submitting data...')),
                                                                          locale:
                                                                              'en_EN',
                                                                          startingDayOfWeek:
                                                                              StartingDayOfWeek.monday,
                                                                          disabledDays: const [
                                                                            6,
                                                                            7
                                                                          ],
                                                                        ),
                                                                        //     SfDateRangePicker(
                                                                        //   initialSelectedDate:
                                                                        //       DateTime.now(),
                                                                        //   onSelectionChanged:
                                                                        //       _onSelectionChanged,
                                                                        //   selectionMode:
                                                                        //       DateRangePickerSelectionMode.single,
                                                                        //   view:
                                                                        //       DateRangePickerView.month,
                                                                        //   monthViewSettings:
                                                                        //       DateRangePickerMonthViewSettings(blackoutDates: [
                                                                        //     DateTime(
                                                                        //         2022,
                                                                        //         12,
                                                                        //         14)
                                                                        //   ], weekendDays: [
                                                                        //     7,
                                                                        //     6
                                                                        //   ], specialDates: [
                                                                        //     DateTime(
                                                                        //         2022,
                                                                        //         12,
                                                                        //         26),
                                                                        //     DateTime(
                                                                        //         2022,
                                                                        //         12,
                                                                        //         27),
                                                                        //     DateTime(
                                                                        //         2022,
                                                                        //         12,
                                                                        //         28)
                                                                        //   ], showTrailingAndLeadingDates: true),
                                                                        //   monthCellStyle:
                                                                        //       DateRangePickerMonthCellStyle(
                                                                        //     blackoutDatesDecoration: BoxDecoration(
                                                                        //         color: Colors.red,
                                                                        //         border: Border.all(color: const Color(0xFFF44436), width: 1),
                                                                        //         shape: BoxShape.circle),
                                                                        //     weekendDatesDecoration: BoxDecoration(
                                                                        //         color: const Color(0xFFDFDFDF),
                                                                        //         border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                                                                        //         shape: BoxShape.circle),
                                                                        //     specialDatesDecoration: BoxDecoration(
                                                                        //         color: Colors.green,
                                                                        //         border: Border.all(color: const Color(0xFF2B732F), width: 1),
                                                                        //         shape: BoxShape.circle),
                                                                        //     blackoutDateTextStyle:
                                                                        //         TextStyle(color: Colors.white, decoration: TextDecoration.lineThrough),
                                                                        //     specialDatesTextStyle:
                                                                        //         const TextStyle(color: Colors.white),
                                                                        //   ),
                                                                        // ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Select date/time",
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .title1,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .datetime,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Location: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      115,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: StreamBuilder<
                                                                  QuerySnapshot>(
                                                              stream:
                                                                  _locationStream,
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          QuerySnapshot>
                                                                      snapshot) {
                                                                // if (snapshot
                                                                //         .connectionState ==
                                                                //     ConnectionState
                                                                //         .waiting) {
                                                                //   return Text(
                                                                //       'Loading');
                                                                // }
                                                                if (snapshot
                                                                        .hasData &&
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .isNotEmpty) {
                                                                  return FlutterFlowDropDown(
                                                                    options: snapshot
                                                                        .data!
                                                                        .docs
                                                                        .map((DocumentSnapshot
                                                                            document) {
                                                                          Map<String, dynamic>
                                                                              data =
                                                                              document.data()! as Map<String, dynamic>;
                                                                          return data[
                                                                              "type"];
                                                                        })
                                                                        .toList()
                                                                        .cast<
                                                                            String>(),
                                                                    onChanged: (val) =>
                                                                        setState(() =>
                                                                            dropDownLocation =
                                                                                val),
                                                                    initialOption:
                                                                        dropDownLocation,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.2,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.06,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle1,
                                                                    hintText:
                                                                        'Please select..',
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .lineColor,
                                                                    elevation:
                                                                        0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    borderWidth:
                                                                        1,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            4,
                                                                            12,
                                                                            4),
                                                                    hidesUnderline:
                                                                        true,
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 20, 20, 20),
                                                    child: Text(
                                                      'Your Details',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Code/Name: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      70,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: FutureBuilder(
                                                              future:
                                                                  currentUserData,
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          Map<String,
                                                                              dynamic>>
                                                                      snapshot) {
                                                                // if (snapshot
                                                                //         .connectionState ==
                                                                //     ConnectionState
                                                                //         .waiting) {
                                                                //   return Text(
                                                                //       'Loading');
                                                                // }
                                                                if (snapshot
                                                                        .hasData &&
                                                                    snapshot
                                                                        .data!
                                                                        .isNotEmpty) {
                                                                  return FlutterFlowDropDown(
                                                                    options: [
                                                                      fName.toString() +
                                                                          " " +
                                                                          lName
                                                                              .toString(),
                                                                      clientCode
                                                                          .toString()
                                                                    ],
                                                                    onChanged: (val) =>
                                                                        setState(() =>
                                                                            dropDownNameorCode =
                                                                                val),
                                                                    initialOption:
                                                                        dropDownNameorCode,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.2,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.06,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle1,
                                                                    hintText:
                                                                        'Please select..',
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .lineColor,
                                                                    elevation:
                                                                        0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    borderWidth:
                                                                        1,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            4,
                                                                            12,
                                                                            4),
                                                                    hidesUnderline:
                                                                        true,
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Email: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      150,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: FutureBuilder(
                                                              future:
                                                                  currentUserData,
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          Map<String,
                                                                              dynamic>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                        .hasData &&
                                                                    snapshot
                                                                        .data!
                                                                        .isNotEmpty) {
                                                                  return TextFormField(
                                                                    controller:
                                                                        emailController,
                                                                    autofocus:
                                                                        true,
                                                                    obscureText:
                                                                        false,
                                                                    readOnly:
                                                                        true,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          uEmail
                                                                              .toString(),
                                                                      // enabled: false,
                                                                      hintStyle:
                                                                          FlutterFlowTheme.of(context)
                                                                              .subtitle2,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle1,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .emailAddress,
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Phone Number: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      40,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: FutureBuilder(
                                                              future:
                                                                  currentUserData,
                                                              builder: (context,
                                                                  AsyncSnapshot<
                                                                          Map<String,
                                                                              dynamic>>
                                                                      snapshot) {
                                                                if (snapshot
                                                                        .hasData &&
                                                                    snapshot
                                                                        .data!
                                                                        .isNotEmpty) {
                                                                  return TextFormField(
                                                                    controller:
                                                                        phNumbController,
                                                                    autofocus:
                                                                        true,
                                                                    obscureText:
                                                                        false,
                                                                    readOnly:
                                                                        true,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          phNumb
                                                                              .toString(),
                                                                      // enabled: false,
                                                                      hintStyle:
                                                                          FlutterFlowTheme.of(context)
                                                                              .subtitle2,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle1,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .phone,
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Comment: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      100,
                                                                      20,
                                                                      20,
                                                                      20),
                                                          child: TextFormField(
                                                            controller:
                                                                commentController,
                                                            autofocus: true,
                                                            obscureText: false,
                                                            // readOnly: true,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "What would you like to gain from this session?",
                                                              // enabled: false,
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x00000000),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        // setState(() {
                                                        //   pnameController
                                                        //           ?.text =
                                                        //       _myBox
                                                        //           .get('name');
                                                        //   userId =
                                                        //       _myBox.get('id');
                                                        // });
                                                        AppointmentData appointmentData = AppointmentData(
                                                            id: user.uid,
                                                            practionerName: _myBox
                                                                .get('name'),
                                                            services:
                                                                dropDownServices,
                                                            dateandtime:
                                                                dateandtimeController
                                                                    ?.text,
                                                            location:
                                                                dropDownLocation,
                                                            clientNameorCode:
                                                                dropDownNameorCode,
                                                            clientEmail: uEmail
                                                                .toString(),
                                                            clientphNumber:
                                                                phNumb
                                                                    .toString(),
                                                            clientComment:
                                                                commentController
                                                                    ?.text,
                                                            statusAppointment:
                                                                "ongoing");
                                                        await service
                                                            .addAppointment(
                                                                appointmentData);
                                                      }
                                                      print(_myBox.get('name'));
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Submit',
                                                    options: FFButtonOptions(
                                                      width: 130,
                                                      height: 40,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 8,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
      } else if (args.value is DateTime) {
        dateandtimeController?.text =
            DateFormat('dd/MM/yyyy').format(args.value).toString();
        ;
      } else if (args.value is List<DateTime>) {
      } else {}
    });
  }

// https://www.syncfusion.com/kb/11467/how-to-add-a-date-range-picker-sfdaterangepicker-in-the-flutter-dialog-window
  // Widget getDateRangePicker() {
  //   return Container(
  //       height: 250,
  //       child: Card(
  //           child: SfDateRangePicker(
  //         view: DateRangePickerView.month,
  //         selectionMode: DateRangePickerSelectionMode.single,
  //         onSelectionChanged: selectionChanged,
  //       )));
  // }
}
