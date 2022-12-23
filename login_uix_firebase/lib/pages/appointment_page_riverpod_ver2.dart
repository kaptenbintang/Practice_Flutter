import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_drop_down.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/provider/appointment_page/location_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_loading_animation_view.dart';

class AppointmentPageRiverpodVersion2 extends StatefulHookConsumerWidget {
  static const routeName = '/appointmentPageRiverpod2';

  final Practioner practioner;

  const AppointmentPageRiverpodVersion2({
    super.key,
    required this.practioner,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppointmentPageRiverpodVersion2State();
}

class _AppointmentPageRiverpodVersion2State
    extends ConsumerState<AppointmentPageRiverpodVersion2> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final locations = ref.watch(locationProvider);

    final pNameController = useTextEditingController();
    final dateandtimeController = useTextEditingController();
    final emailController = useTextEditingController();
    final phNumbController = useTextEditingController();
    final commentController = useTextEditingController();

    late BookingService mockBookingService;

    final isAppointmentButtonEnable = useState(false);

    final now = DateTime.now();

    List<DateTimeRange> converted = [];

    @override
    void initState() {
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
        dateandtimeController?.text = DateFormat('EEE, yyyy-MM-dd, kk:mm:a')
            .format(newBooking.bookingStart)
            .toString();
      });
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

    useEffect(
      () {
        void listener() {
          isAppointmentButtonEnable.value = pNameController.text.isNotEmpty &&
              dateandtimeController.text.isNotEmpty &&
              emailController.text.isNotEmpty &&
              phNumbController.text.isNotEmpty &&
              commentController.text.isNotEmpty;
        }

        pNameController.addListener(listener);
        dateandtimeController.addListener(listener);
        emailController.addListener(listener);
        phNumbController.addListener(listener);
        commentController.addListener(listener);

        return () {
          pNameController.removeListener(listener);
          dateandtimeController.removeListener(listener);
          emailController.removeListener(listener);
          phNumbController.removeListener(listener);
          commentController.removeListener(listener);
        };
      },
      [
        pNameController,
        dateandtimeController,
        emailController,
        phNumbController,
        commentController,
      ],
    );

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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(100, 40, 0, 100),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
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
                                        Navigator.pushNamed(
                                            context, RouteName.MainPagesPage);
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
                                      Navigator.pushNamed(
                                          context, RouteName.viewProfilePage);
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
                                      Navigator.pushNamed(
                                          context, RouteName.HistoryBooking);
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
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search Something here..',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).lineColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Form(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Text(
                                        'Make an appointment!',
                                        style:
                                            FlutterFlowTheme.of(context).title1,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Practioner Name: ',
                                          style: FlutterFlowTheme.of(context)
                                              .title1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 20, 20, 20),
                                            child: TextFormField(
                                              controller: pNameController,
                                              autofocus: true,
                                              obscureText: false,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: widget
                                                        .practioner.firstName +
                                                    ' ' +
                                                    widget.practioner.lastName,
                                                enabled: false,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                              keyboardType: TextInputType.name,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 20, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Services: ',
                                          style: FlutterFlowTheme.of(context)
                                              .title1,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: Consumer(
                                            builder: (BuildContext context,
                                                WidgetRef ref, Widget? child) {
                                              final services =
                                                  ref.watch(servicesProvider);
                                              String initService = ref
                                                  .watch(
                                                      selectedServiceProvider)
                                                  .service;
                                              // print(initService);

                                              return services.when(
                                                data: (data) {
                                                  return FlutterFlowDropDown(
                                                    options: List.generate(
                                                        data.length,
                                                        (index) => data
                                                            .elementAt(index)
                                                            .servicesName),
                                                    onChanged: (val) {
                                                      ref
                                                          .read(
                                                              selectedServiceProvider
                                                                  .notifier)
                                                          .changeServices(
                                                            val.toString(),
                                                          );
                                                      // print(initService);
                                                    },
                                                    initialOption: initService,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .subtitle1,
                                                    hintText: 'Please select..',
                                                    fillColor:
                                                        FlutterFlowTheme.of(
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
                                                                12, 4, 12, 4),
                                                    hidesUnderline: true,
                                                  );
                                                },
                                                error: (error, stackTrace) {
                                                  return const SmallErrorAnimationView();
                                                },
                                                loading: () {
                                                  return const SmallLoadingAnimationView();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Date: ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .title1,
                                              ),
                                              TextFormField(
                                                controller:
                                                    dateandtimeController,
                                                autofocus: true,
                                                obscureText: false,
                                                readOnly: true,
                                                onTap: () {
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (context) {
                                                  //       return AlertDialog(
                                                  //         backgroundColor:
                                                  //             Colors.white,
                                                  //         // actions: <
                                                  //         //     Widget>[
                                                  //         //   Container(
                                                  //         //     height:
                                                  //         //         30,
                                                  //         //     child:
                                                  //         //         MaterialButton(
                                                  //         //       color:
                                                  //         //           Colors.green,
                                                  //         //       child:
                                                  //         //           Text(
                                                  //         //         'Set',
                                                  //         //         style: TextStyle(color: Colors.white),
                                                  //         //       ),
                                                  //         //       onPressed:
                                                  //         //           () {
                                                  //         //         setState(() {
                                                  //         //           // date_of_birth = date_controller.text;
                                                  //         //         });

                                                  //         //         Navigator.of(context).pop();
                                                  //         //       },
                                                  //         //     ),
                                                  //         //   ),
                                                  //         //   TextButton(
                                                  //         //     child:
                                                  //         //         Text('Cancel'),
                                                  //         //     onPressed:
                                                  //         //         () {
                                                  //         //       setState(() {
                                                  //         //         // date_controller.text = date_of_birth;
                                                  //         //       });

                                                  //         //       Navigator.of(context).pop();
                                                  //         //     },
                                                  //         //   ),
                                                  //         // ],
                                                  //         content: Container(
                                                  //           height: 600,
                                                  //           width: 600,
                                                  //           child:
                                                  //               BookingCalendar(
                                                  //             bookingService:
                                                  //                 mockBookingService,
                                                  //             convertStreamResultToDateTimeRanges:
                                                  //                 convertStreamResultMock,
                                                  //             getBookingStream:
                                                  //                 getBookingStreamMock,
                                                  //             uploadBooking:
                                                  //                 uploadBookingMock,
                                                  //             pauseSlots:
                                                  //                 generatePauseSlots(),
                                                  //             pauseSlotText:
                                                  //                 'LUNCH',
                                                  //             hideBreakTime:
                                                  //                 false,
                                                  //             loadingWidget: Align(
                                                  //                 alignment:
                                                  //                     Alignment
                                                  //                         .center,
                                                  //                 child: const Text(
                                                  //                     'Fetching data...')),
                                                  //             uploadingWidget: Align(
                                                  //                 alignment:
                                                  //                     Alignment
                                                  //                         .center,
                                                  //                 child: const Text(
                                                  //                     'Submitting data...')),
                                                  //             locale: 'en_EN',
                                                  //             startingDayOfWeek:
                                                  //                 StartingDayOfWeek
                                                  //                     .monday,
                                                  //             disabledDays: const [
                                                  //               6,
                                                  //               7
                                                  //             ],
                                                  //           ),
                                                  //           //     SfDateRangePicker(
                                                  //           //   initialSelectedDate:
                                                  //           //       DateTime.now(),
                                                  //           //   onSelectionChanged:
                                                  //           //       _onSelectionChanged,
                                                  //           //   selectionMode:
                                                  //           //       DateRangePickerSelectionMode.single,
                                                  //           //   view:
                                                  //           //       DateRangePickerView.month,
                                                  //           //   monthViewSettings:
                                                  //           //       DateRangePickerMonthViewSettings(blackoutDates: [
                                                  //           //     DateTime(
                                                  //           //         2022,
                                                  //           //         12,
                                                  //           //         14)
                                                  //           //   ], weekendDays: [
                                                  //           //     7,
                                                  //           //     6
                                                  //           //   ], specialDates: [
                                                  //           //     DateTime(
                                                  //           //         2022,
                                                  //           //         12,
                                                  //           //         26),
                                                  //           //     DateTime(
                                                  //           //         2022,
                                                  //           //         12,
                                                  //           //         27),
                                                  //           //     DateTime(
                                                  //           //         2022,
                                                  //           //         12,
                                                  //           //         28)
                                                  //           //   ], showTrailingAndLeadingDates: true),
                                                  //           //   monthCellStyle:
                                                  //           //       DateRangePickerMonthCellStyle(
                                                  //           //     blackoutDatesDecoration: BoxDecoration(
                                                  //           //         color: Colors.red,
                                                  //           //         border: Border.all(color: const Color(0xFFF44436), width: 1),
                                                  //           //         shape: BoxShape.circle),
                                                  //           //     weekendDatesDecoration: BoxDecoration(
                                                  //           //         color: const Color(0xFFDFDFDF),
                                                  //           //         border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                                                  //           //         shape: BoxShape.circle),
                                                  //           //     specialDatesDecoration: BoxDecoration(
                                                  //           //         color: Colors.green,
                                                  //           //         border: Border.all(color: const Color(0xFF2B732F), width: 1),
                                                  //           //         shape: BoxShape.circle),
                                                  //           //     blackoutDateTextStyle:
                                                  //           //         TextStyle(color: Colors.white, decoration: TextDecoration.lineThrough),
                                                  //           //     specialDatesTextStyle:
                                                  //           //         const TextStyle(color: Colors.white),
                                                  //           //   ),
                                                  //           // ),
                                                  //         ),
                                                  //       );
                                                  //     });
                                                },
                                                // decoration: InputDecoration(
                                                //   labelText: "Select date/time",
                                                //   prefixIcon: Icon(
                                                //     Icons.calendar_today,
                                                //     color: Colors.blue,
                                                //   ),
                                                //   hintStyle:
                                                //       FlutterFlowTheme.of(
                                                //               context)
                                                //           .title1,
                                                //   enabledBorder:
                                                //       OutlineInputBorder(
                                                //     borderSide: BorderSide(
                                                //       color:
                                                //           FlutterFlowTheme.of(
                                                //                   context)
                                                //               .primaryText,
                                                //       width: 1,
                                                //     ),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8),
                                                //   ),
                                                //   focusedBorder:
                                                //       OutlineInputBorder(
                                                //     borderSide: BorderSide(
                                                //       color:
                                                //           FlutterFlowTheme.of(
                                                //                   context)
                                                //               .primaryText,
                                                //       width: 1,
                                                //     ),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8),
                                                //   ),
                                                //   errorBorder:
                                                //       OutlineInputBorder(
                                                //     borderSide: BorderSide(
                                                //       color: Color(0x00000000),
                                                //       width: 1,
                                                //     ),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8),
                                                //   ),
                                                //   focusedErrorBorder:
                                                //       OutlineInputBorder(
                                                //     borderSide: BorderSide(
                                                //       color: Color(0x00000000),
                                                //       width: 1,
                                                //     ),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8),
                                                //   ),
                                                // ),
                                                // style:
                                                //     FlutterFlowTheme.of(context)
                                                //         .subtitle1,
                                                // keyboardType:
                                                //     TextInputType.datetime,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
