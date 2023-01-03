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
import 'package:login_uix_firebase/widgets/dialogs/date_time_dialog_appointment.dart';

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
    String? resultDate;

    final isAppointmentButtonEnable = useState(false);

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
                                        Flexible(
                                          child: Text(
                                            'Services: ',
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 20, 20, 20),
                                            child: Consumer(
                                              builder: (BuildContext context,
                                                  WidgetRef ref,
                                                  Widget? child) {
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
                                                      initialOption:
                                                          initService,
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
                                                      hintText:
                                                          'Please select..',
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
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Date: ',
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: dateandtimeController,
                                              autofocus: true,
                                              obscureText: false,
                                              readOnly: true,
                                              onTap: () async {
                                                final result = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return DateTimeAppointmentDialog(
                                                      practioner: widget
                                                          .practioner.firstName,
                                                      context: context,
                                                    );
                                                  },
                                                );
                                                setState(() {
                                                  dateandtimeController.text =
                                                      result.toString();
                                                });

                                                print(resultDate);
                                                // print(
                                                //     dateandtimeController.text);
                                              },
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: InputDecoration(
                                                labelText: "Select date/time",
                                                prefixIcon: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.blue,
                                                ),
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .title1,
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
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
