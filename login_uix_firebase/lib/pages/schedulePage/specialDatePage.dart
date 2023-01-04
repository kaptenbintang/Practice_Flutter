import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/specialdate_provider/specialdate_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/responsive.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class specialDatePage extends StatefulWidget {
  const specialDatePage({Key? key}) : super(key: key);

  @override
  _specialDatePageState createState() => _specialDatePageState();
}

class _specialDatePageState extends State<specialDatePage> {
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController?.dispose();
    super.dispose();
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenWidth / (width / 100)),
        child: AppBar(
          actions: const [],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: screenWidth / (width / 30),
            borderWidth: 1,
            buttonSize: screenWidth / (width / 50),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: screenWidth / (width / 50),
            ),
            onPressed: () {
              print('IconButton pressed ...');
              Navigator.pop(context);
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, 0, 0, screenWidth / (width / 14)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        screenWidth / (width / 24), 0, 0, 0),
                    child: Text(
                      'Off Day',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: screenWidth / (width / 30),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          // actions: [],
          centerTitle: true,
          elevation: 2,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Consumer(builder: (context, ref, child) {
                      final specialDate = ref.watch(specialDateProvider);
                      return specialDate.when(data: (data) {
                        if (data.isNotEmpty) {
                          final listDay = data.elementAt(0).dayoff;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Text(
                                  'Plan your off day?',
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 30),
                                      ),
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final value = listDay.values.elementAt(index);
                                  final key = listDay.keys.elementAt(index);

                                  return tableDepanSpecialPage(
                                      context, value, key, index);
                                },
                              ),
                              FFButtonWidget(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          actions: <Widget>[
                                            Container(
                                              height: 30,
                                              child: MaterialButton(
                                                color: Colors.green,
                                                child: Text(
                                                  'Set',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    // date_of_birth = date_controller.text;
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                setState(() {
                                                  // date_controller.text = date_of_birth;
                                                });

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                          content: Container(
                                            height: 300,
                                            width: 300,
                                            child: SfDateRangePicker(
                                              // initialSelectedDate:
                                              //     DateTime.now(),
                                              onSelectionChanged:
                                                  _onSelectionChanged,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              view: DateRangePickerView.month,
                                              monthViewSettings:
                                                  DateRangePickerMonthViewSettings(
                                                      blackoutDates: [
                                                    DateTime(2022, 12, 14)
                                                  ],
                                                      weekendDays: [
                                                    7,
                                                    6
                                                  ],
                                                      specialDates: [
                                                    DateTime(2022, 12, 26),
                                                    DateTime(2022, 12, 27),
                                                    DateTime(2022, 12, 28)
                                                  ],
                                                      showTrailingAndLeadingDates:
                                                          true),
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                blackoutDatesDecoration:
                                                    BoxDecoration(
                                                        color: Colors.red,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFF44436),
                                                            width: 1),
                                                        shape: BoxShape.circle),
                                                weekendDatesDecoration:
                                                    BoxDecoration(
                                                        color: const Color(
                                                            0xFFDFDFDF),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFB6B6B6),
                                                            width: 1),
                                                        shape: BoxShape.circle),
                                                specialDatesDecoration:
                                                    BoxDecoration(
                                                        color: Colors.green,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFF2B732F),
                                                            width: 1),
                                                        shape: BoxShape.circle),
                                                blackoutDateTextStyle:
                                                    TextStyle(
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                specialDatesTextStyle:
                                                    const TextStyle(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  print('Button pressed ...');
                                },
                                text: 'Add',
                                icon: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
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
                            ],
                          );
                        } else {
                          return const LoadingAnimationView();
                        }
                      }, error: (error, stackTrace) {
                        print(error);
                        return const ErrorAnimationView();
                      }, loading: () {
                        return const LoadingAnimationView();
                      });
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableDepanSpecialPage(BuildContext context, data, key, index) {
    // print(data);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   'You\'ll off',
                        //   style: FlutterFlowTheme.of(context).subtitle1,
                        // ),
                        Text(
                          'From: ' +
                              data["startDayoff"].toString() +
                              ',' +
                              'To: ' +
                              data["endDayoff"],
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        //   child: Text(
                        //     'From: ' +
                        //         data["startDayoff"].toString() +
                        //         ',' +
                        //         'To: ' +
                        //         data["endDayoff"],
                        //     style: FlutterFlowTheme.of(context).subtitle1,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional
                        //       .fromSTEB(5, 0, 0, 0),
                        //   child: Text(
                        //     'duration: 1d',
                        //     style: FlutterFlowTheme.of(
                        //             context)
                        //         .subtitle1,
                        //   ),
                        // ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Description:\n' + data["description"].toString(),
                            textAlign: TextAlign.justify,
                            style:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primaryText,
                    borderRadius: 30,
                    borderWidth: 2,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.edit_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              actions: <Widget>[
                                Container(
                                  height: 30,
                                  child: MaterialButton(
                                    color: Colors.green,
                                    child: Text(
                                      'Set',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // date_of_birth = date_controller.text;
                                      });

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    setState(() {
                                      // date_controller.text = date_of_birth;
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              content: Container(
                                height: 300,
                                width: 300,
                                child: SfDateRangePicker(
                                  // initialSelectedDate: DateTime.now(),
                                  onSelectionChanged: _onSelectionChanged,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  view: DateRangePickerView.month,
                                  monthViewSettings:
                                      DateRangePickerMonthViewSettings(
                                          blackoutDates: [
                                        DateTime(2022, 12, 14)
                                      ],
                                          weekendDays: [
                                        7,
                                        6
                                      ],
                                          specialDates: [
                                        DateTime(2022, 12, 26),
                                        DateTime(2022, 12, 27),
                                        DateTime(2022, 12, 28)
                                      ],
                                          showTrailingAndLeadingDates: true),
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                    blackoutDatesDecoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(
                                            color: const Color(0xFFF44436),
                                            width: 1),
                                        shape: BoxShape.circle),
                                    weekendDatesDecoration: BoxDecoration(
                                        color: const Color(0xFFDFDFDF),
                                        border: Border.all(
                                            color: const Color(0xFFB6B6B6),
                                            width: 1),
                                        shape: BoxShape.circle),
                                    specialDatesDecoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(
                                            color: const Color(0xFF2B732F),
                                            width: 1),
                                        shape: BoxShape.circle),
                                    blackoutDateTextStyle: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough),
                                    specialDatesTextStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          });
                      print('IconButton pressed ...');
                    },
                  ),
                  Text(
                    'Edit',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).primaryText,
                      borderRadius: 30,
                      borderWidth: 2,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.delete,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    Text(
                      'Delete',
                      style: FlutterFlowTheme.of(context).bodyText1,
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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final DateTime rangeStartDate = args.value.startDate;
      final DateTime rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }
  //   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   /// The argument value will return the changed date as [DateTime] when the
  //   /// widget [SfDateRangeSelectionMode] set as single.
  //   ///
  //   /// The argument value will return the changed dates as [List<DateTime>]
  //   /// when the widget [SfDateRangeSelectionMode] set as multiple.
  //   ///
  //   /// The argument value will return the changed range as [PickerDateRange]
  //   /// when the widget [SfDateRangeSelectionMode] set as range.
  //   ///
  //   /// The argument value will return the changed ranges as
  //   /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
  //   /// multi range.
  //   setState(() {
  //     if (args.value is PickerDateRange) {
  //     } else if (args.value is DateTime) {
  //       dateandtimeController?.text =
  //           DateFormat('dd/MM/yyyy').format(args.value).toString();
  //       ;
  //     } else if (args.value is List<DateTime>) {
  //     } else {}
  //   });
  // }
}


// class MyAppState extends State<MyApp> {

//  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//    if (args.value is PickerDateRange) {
//      final DateTime rangeStartDate = args.value.startDate;
//      final DateTime rangeEndDate = args.value.endDate;
//    } else if (args.value is DateTime) {
//      final DateTime selectedDate = args.value;
//    } else if (args.value is List<DateTime>) {
//      final List<DateTime> selectedDates = args.value;
//    } else {
//      final List<PickerDateRange> selectedRanges = args.value;
//    }
//  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        home: Scaffold(
//      appBar: AppBar(
//        title: Text('DatePicker demo'),
//      ),
//      body: SfDateRangePicker(
//        onSelectionChanged: _onSelectionChanged,
//        selectionMode: DateRangePickerSelectionMode.range,
//        initialSelectedRange: PickerDateRange(
//            DateTime.now().subtract(Duration(days: 4)),
//            DateTime.now().add(Duration(days: 3))),
//      ),
//    ));
//  }
// }