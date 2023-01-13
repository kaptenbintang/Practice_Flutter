// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/specialdate_provider/specialdate_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../flutter_flow/flutter_flow.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/responsive.dart';
import '../../model/practioner_data.dart';
import '../../provider/appointment_page/date_selected.dart';
import '../../provider/specialdate_provider/specialdate_get_provider.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class specialDatePage extends ConsumerStatefulWidget {
  const specialDatePage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _specialDatePageState();
  // @override
  // _specialDatePageState createState() => _specialDatePageState();
}

class _specialDatePageState extends ConsumerState<specialDatePage> {
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _descriptionController = TextEditingController();

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
      appBar: AppBar(
        actions: const [],
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: screenWidth / (width / 30),
            borderWidth: 1,
            buttonSize: screenWidth / (width / 30),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: screenWidth / (width / 20),
            ),
            onPressed: () {
              print('IconButton pressed ...');
              Navigator.pop(context);
            },
          ),
        ),

        title: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
          child: Text(
            'Off Day',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: screenWidth / (width / 30),
                ),
          ),
        ),

        // actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth / (width / 8)),
            child: Container(
              height: screenWidth / (width / 800),
              width: ResponsiveWidget.isphoneScreen(context)
                  ? screenWidth
                  : screenWidth / (width / 500),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: screenWidth / (width / 12),
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
              ),
              child: SingleChildScrollView(
                child: Consumer(builder: (context, ref, child) {
                  final dayoff = ref.watch(specialDateProvider);
                  return dayoff.when(data: (data) {
                    if (data.isNotEmpty) {
                      final listDay = data.elementAt(0).dayoff;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20)),
                            child: Text(
                              'Plan your off day?',
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 24),
                                      ),
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listDay.length,
                            itemBuilder: (context, index) {
                              final value = listDay.values.elementAt(index);
                              final key = listDay.keys.elementAt(index);

                              return tableDepanSpecialPage(
                                  listDay, context, value, key, index);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: FFButtonWidget(
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
                                                    .range,
                                            view: DateRangePickerView.month,
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
        ),
      ),
    );
  }

  Widget tableDepanSpecialPage(datas, BuildContext context, data, key, index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    // print(data);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20)),
      child: Container(
        height: screenWidth / (width / 120),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  screenWidth / (width / 10),
                  screenWidth / (width / 10),
                  screenWidth / (width / 10),
                  screenWidth / (width / 10)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["dateDayoff"],
                    style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                  Text(
                    'Description:\n' + data["description"].toString(),
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth / (width / 12),
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / (width / 8)),
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
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  actions: <Widget>[
                                    Consumer(builder: (context, ref, child) {
                                      return Container(
                                        height: 30,
                                        child: MaterialButton(
                                          color: Colors.green,
                                          child: Text(
                                            'Set',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            PractionerData practionerData =
                                                PractionerData(
                                              id: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                            );
                                            final selectedDate =
                                                ref.watch(dateRangeProvider);
                                            await ref
                                                .read(editSpecialDateProvider
                                                    .notifier)
                                                .editstartDayoff(
                                                    dayoffs: selectedDate,
                                                    index: index,
                                                    practionerData:
                                                        practionerData)
                                                .then((value) => ref.refresh(
                                                    specialDateProvider
                                                        .future));
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      );
                                    }),
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
                                          DateRangePickerSelectionMode.range,
                                      view: DateRangePickerView.month,
                                      // monthViewSettings: DateRangePickerMonthViewSettings(specialDates: ),
                                    ),
                                  ),
                                );
                              });

                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("input description"),
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
                                        // key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth / (width / 8)),
                                                child: TextFormField(
                                                  controller:
                                                      _descriptionController,
                                                  decoration: InputDecoration(
                                                    labelText: "Description",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    screenWidth / (width / 40),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    screenWidth / (width / 8)),
                                                child: ElevatedButton(
                                                  child: Text("Submit"),
                                                  onPressed: () async {
                                                    PractionerData
                                                        practionerData =
                                                        PractionerData(
                                                      id: FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                    );
                                                    await ref
                                                        .read(
                                                            editDescriptionDayoffProvider
                                                                .notifier)
                                                        .editDescription(
                                                            descriptiong:
                                                                _descriptionController
                                                                    .text,
                                                            index: index,
                                                            practionerData:
                                                                practionerData)
                                                        .then((value) =>
                                                            ref.refresh(
                                                                specialDateProvider
                                                                    .future));
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
                  padding: EdgeInsets.all(screenWidth / (width / 8)),
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
                        onPressed: () async {
                          print(datas);
                          await ref
                              .read(deleteSpecialDateProvider.notifier)
                              .deleteDayoff(
                                listDay: datas,
                                userID: FirebaseAuth.instance.currentUser!.uid,
                                selectedIndex: index,
                              )
                              .then((value) =>
                                  ref.refresh(specialDateProvider.future));
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        'Delete',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      // final DateTime rangeStartDate = args.value.startDate;
      // final DateTime rangeEndDate = args.value.endDate;
      final _range =
          '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate)}';
      ref.read(dateRangeProvider.notifier).changeDateRange(_range);
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