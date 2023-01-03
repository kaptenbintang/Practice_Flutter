import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/provider/appointment_page/location_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';

import '../flutter_flow/flutter_flow.dart';

class AppointmentPageRiverpod extends ConsumerWidget {
  static const routeName = '/appointmentPageRiverpod';
  final Practioner practioner;

  const AppointmentPageRiverpod({super.key, required this.practioner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();

    final pnameController = TextEditingController();
    final dateandtimeController = TextEditingController();
    final searchController = TextEditingController();
    final emailController = TextEditingController();
    final phNumbController = TextEditingController();
    final commentController = TextEditingController();
    final now = DateTime.now();
    List<DateTimeRange> converted = [];
    late BookingService mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 9, 0));

    Stream<dynamic>? getBookingStreamMock(
        {required DateTime end, required DateTime start}) {
      return Stream.value([]);
    }

    Future<dynamic> uploadBookingMock(
        {required BookingService newBooking}) async {
      await Future.delayed(const Duration(seconds: 1));
      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));

      dateandtimeController.text = DateFormat('EEE, yyyy-MM-dd, kk:mm:a')
          .format(newBooking.bookingStart)
          .toString();

      print('${newBooking.toJson()} has been uploaded');
    }

    List<DateTimeRange> convertStreamResultMock(
        {required dynamic streamResult}) {
      ///here you can parse the streamresult and convert to [List<DateTimeRange>]
      ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
      ///disabledDays will properly work with real data
      DateTime first = now;
      DateTime second = now.add(const Duration(minutes: 55));
      DateTime third = now.subtract(const Duration(minutes: 240));
      DateTime fourth = now.subtract(const Duration(minutes: 500));
      converted.add(DateTimeRange(
          start: first, end: now.add(const Duration(minutes: 30))));
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
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
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.MainPagesPage);
                                          },
                                          child: Text(
                                            'Home',
                                            textAlign: TextAlign.justify,
                                            style: FlutterFlowTheme.of(context)
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
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.historyBookingRiverpod);
                                        },
                                        child: Text(
                                          'Booking History',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 40, 100, 100),
                            child: Image.network(
                              'lib/images/Logo-Slogan-BL-H400-W1080.png',
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.height * 0.06,
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
                              height: MediaQuery.of(context).size.height * 1.5,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                                  child: Text(
                                                    'Make an appointment!',
                                                    style: FlutterFlowTheme.of(
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
                                                                .fromSTEB(20,
                                                                    20, 20, 20),
                                                        child: TextFormField(
                                                          controller:
                                                              pnameController,
                                                          autofocus: true,
                                                          obscureText: false,
                                                          readOnly: true,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                '${practioner.firstName} ${practioner.lastName}',
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
                                                              .fromSTEB(123, 20,
                                                                  20, 20),
                                                      child: Consumer(
                                                        builder: (context, ref,
                                                            child) {
                                                          final services =
                                                              ref.watch(
                                                                  servicesProvider);
                                                          String?
                                                              dropDownServices;
                                                          return services.when(
                                                            data: (data) {
                                                              List<String>
                                                                  pets = [];
                                                              for (var i = 0;
                                                                  i ==
                                                                      data.length;
                                                                  i++) {
                                                                pets.add(data
                                                                    .elementAt(
                                                                        i)
                                                                    .servicesName);
                                                                print(data
                                                                    .length);
                                                              }
                                                              return FlutterFlowDropDown(
                                                                options: pets,
                                                                onChanged: (val) =>
                                                                    dropDownServices =
                                                                        val,
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
                                                                borderWidth: 1,
                                                                borderRadius: 8,
                                                                margin:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            4,
                                                                            12,
                                                                            4),
                                                                hidesUnderline:
                                                                    true,
                                                              );
                                                            },
                                                            error: (error,
                                                                stackTrace) {
                                                              return const SmallErrorAnimationView();
                                                            },
                                                            loading: () {
                                                              return const LoadingAnimationView();
                                                            },
                                                          );
                                                        },
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
                                                                .fromSTEB(165,
                                                                    20, 20, 20),
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
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: const Text('Fetching data...')),
                                                                        uploadingWidget: Align(
                                                                            alignment:
                                                                                Alignment.center,
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
                                                                .fromSTEB(115,
                                                                    20, 20, 20),
                                                        child: Consumer(
                                                          builder: (BuildContext
                                                                  context,
                                                              WidgetRef ref,
                                                              Widget? child) {
                                                            final location =
                                                                ref.watch(
                                                                    locationProvider);
                                                            return location
                                                                .when(
                                                              data: (data) {
                                                                String?
                                                                    dropDownLocation;
                                                                return FlutterFlowDropDown(
                                                                  options: data
                                                                      .map(
                                                                          (document) {
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            document
                                                                                as Map<String, dynamic>;
                                                                        return data[
                                                                            "type"];
                                                                      })
                                                                      .toList()
                                                                      .cast<
                                                                          String>(),
                                                                  onChanged: (val) =>
                                                                      dropDownLocation =
                                                                          val,
                                                                  initialOption:
                                                                      dropDownLocation,
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
                                                              },
                                                              error: (error,
                                                                  stackTrace) {
                                                                return const ErrorAnimationView();
                                                              },
                                                              loading: () {
                                                                return const LoadingAnimationView();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: Text(
                                                    'Your Details',
                                                    style: FlutterFlowTheme.of(
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
                                                                .fromSTEB(70,
                                                                    20, 20, 20),
                                                        child: Consumer(
                                                          builder: (context,
                                                              ref, child) {
                                                            var dropDownNameorCode =
                                                                TextEditingController();
                                                            final userUid =
                                                                ref.watch(
                                                                    userIdProvider)!;
                                                            final userInfoModel =
                                                                ref.watch(
                                                              userInfoModelProvider(
                                                                  userUid),
                                                            );

                                                            return userInfoModel
                                                                .when(
                                                              data: (data) {
                                                                return FlutterFlowDropDown(
                                                                  options: [
                                                                    data.firstName +
                                                                        ' ' +
                                                                        data.lastName,
                                                                    data.clientcode
                                                                  ],
                                                                  onChanged: (val) =>
                                                                      dropDownNameorCode
                                                                              .text =
                                                                          val.toString(),
                                                                  initialOption:
                                                                      dropDownNameorCode
                                                                          .text,
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
                                                              },
                                                              error: (error,
                                                                  stackTrace) {
                                                                return const ErrorAnimationView();
                                                              },
                                                              loading: () {
                                                                return const LoadingAnimationView();
                                                              },
                                                            );
                                                          },
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
                                                                .fromSTEB(150,
                                                                    20, 20, 20),
                                                        child: Consumer(
                                                          builder: (context,
                                                              ref, child) {
                                                            final userUid =
                                                                ref.watch(
                                                                    userIdProvider)!;
                                                            final userInfoModel =
                                                                ref.watch(
                                                              userInfoModelProvider(
                                                                  userUid),
                                                            );
                                                            return userInfoModel
                                                                .when(
                                                              data: (data) {
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
                                                                    hintText: data
                                                                        .email,
                                                                    // enabled: false,
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2,
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle1,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .emailAddress,
                                                                );
                                                              },
                                                              error: (error,
                                                                  stackTrace) {
                                                                return const ErrorAnimationView();
                                                              },
                                                              loading: () {
                                                                return const LoadingAnimationView();
                                                              },
                                                            );
                                                          },
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
                                                                .fromSTEB(40,
                                                                    20, 20, 20),
                                                        child: Consumer(
                                                          builder: (context,
                                                              ref, child) {
                                                            final userUid =
                                                                ref.watch(
                                                                    userIdProvider)!;
                                                            final userInfoModel =
                                                                ref.watch(
                                                              userInfoModelProvider(
                                                                  userUid),
                                                            );
                                                            return userInfoModel
                                                                .when(
                                                              data: (data) {
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
                                                                    hintText: data
                                                                        .phoneNumber
                                                                        .toString(),
                                                                    // enabled: false,
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2,
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle1,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                );
                                                              },
                                                              error: (error,
                                                                  stackTrace) {
                                                                return const ErrorAnimationView();
                                                              },
                                                              loading: () {
                                                                return const LoadingAnimationView();
                                                              },
                                                            );
                                                          },
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
                                                                .fromSTEB(100,
                                                                    20, 20, 20),
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
                                                    AlignmentDirectional(0, 0),
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
                                                      // AppointmentData appointmentData = AppointmentData(
                                                      //     id: user.uid,
                                                      //     practionerName: _myBox
                                                      //         .get('name'),
                                                      //     services:
                                                      //         dropDownServices,
                                                      //     dateandtime:
                                                      //         dateandtimeController
                                                      //             ?.text,
                                                      //     location:
                                                      //         dropDownLocation,
                                                      //     clientNameorCode:
                                                      //         dropDownNameorCode,
                                                      //     clientEmail:
                                                      //         uEmail.toString(),
                                                      //     clientphNumber:
                                                      //         phNumb.toString(),
                                                      //     clientComment:
                                                      //         commentController
                                                      //             ?.text,
                                                      //     statusAppointment:
                                                      //         "ongoing",
                                                      //     createdAt:
                                                      //         DateTime.now()
                                                      //             .toString());
                                                      // await service
                                                      //     .addAppointment(
                                                      //         appointmentData);
                                                    }
                                                    // print(_myBox.get('name'));
                                                    // print('Button pressed ...');
                                                  },
                                                  text: 'Submit',
                                                  options: FFButtonOptions(
                                                    width: 130,
                                                    height: 40,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
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
    );
  }
}
