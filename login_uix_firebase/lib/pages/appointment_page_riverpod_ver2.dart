// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/provider/appointment_page/appointment_upload_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/location_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_auto_change_provider.dart';

import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/dialogs/date_time_dialog_appointment.dart';
import 'package:login_uix_firebase/widgets/time/time_grid_view.dart';

import '../helper/dimensions.dart';
import '../helper/responsive.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final userUid = ref.watch(userIdProvider);
    final userInfo = ref.watch(userInfoModelProvider(userUid.toString()));

    final pNameController = useTextEditingController();
    final dateandtimeController = useTextEditingController();
    final emailController = useTextEditingController();
    final phNumbController = useTextEditingController();
    final commentController = useTextEditingController();
    TextEditingController? searchController;
    String? selectedService,
        selectedDate,
        selectedTime,
        // selectedEmail,
        // selectedPhone,
        selectedLocation,
        selectedCodeorName;

    // final isAppointmentButtonEnable = useState(false);
    // final isServiceandDateContainValue = useState(false);

    // useEffect(
    //   () {
    //     void listener() {
    //       isAppointmentButtonEnable.value =
    //           dateandtimeController.text.isNotEmpty;
    //       // isServiceandDateContainValue.value =
    //       //     selectedService!.isNotEmpty && selectedDate!.isNotEmpty;
    //     }

    //     dateandtimeController.addListener(listener);

    //     // commentController.addListener(listener);

    //     return () {
    //       dateandtimeController.removeListener(listener);

    //       // commentController.removeListener(listener);
    //     };
    //   },
    //   [
    //     dateandtimeController,

    //     // commentController,
    //   ],
    // );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Header /NavigationBar
            ResponsiveWidget.isLargeScreen(context)
                ? Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth / (width / 100),
                        top: screenWidth / (width / 40),
                        right: screenWidth / (width / 100),
                        bottom: screenWidth / (width / 40)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //Home navigation
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.MainPagesPage);
                                  },
                                  child: Text(
                                    'Home',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              ),
                              //Profile navigation
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.viewProfilePage);
                                  },
                                  child: Text(
                                    'Profile',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              ),
                              //Booking History
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.historyBookingRiverpod);
                                  },
                                  child: Text(
                                    'Booking History',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ),
                              ),
                              //Search Text field
                              SizedBox(
                                height: screenWidth / (width / 50),
                                width: screenWidth / (width / 300),
                                child: TextFormField(
                                  controller: searchController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search Something here..',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    contentPadding: EdgeInsets.all(
                                        screenWidth / (width / 8)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 20)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 20)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 20)),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 14)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'lib/images/Logo-Slogan-BL-H400-W1080.png',
                          width: screenWidth / (width / 300),
                          height: screenWidth / (width / 60),
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.height10,
                        right: Dimensions.height10,
                        bottom: Dimensions.height20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radius15),
                          bottomRight: Radius.circular(Dimensions.radius15),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width08),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Home navigation
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.MainPagesPage);
                              },
                              child: Text(
                                'Home',
                                textAlign: TextAlign.justify,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font12),
                              ),
                            ),
                            //Profile navigation
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.viewProfilePage);
                              },
                              child: Text(
                                'Profile',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font12),
                              ),
                            ),
                            //Booking History
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.historyBookingRiverpod);
                              },
                              child: Text(
                                'Booking History',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font12),
                              ),
                            ),

                            //Logo Image
                            Image.asset(
                              'lib/images/Logo-Slogan-BL-H400-W1080.png',
                              width: Dimensions.width100,
                              height: Dimensions.height20 * 2,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

            //Appointment Form Container
            Padding(
              padding: EdgeInsets.only(
                  right: ResponsiveWidget.isLargeScreen(context)
                      ? screenWidth / (width / 400)
                      : screenWidth / (width / 10),
                  left: ResponsiveWidget.isLargeScreen(context)
                      ? screenWidth / (width / 400)
                      : screenWidth / (width / 10),
                  bottom: ResponsiveWidget.isLargeScreen(context)
                      ? screenWidth / (width / 24)
                      : screenWidth / (width / 20)),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).lineColor,
                  borderRadius:
                      BorderRadius.circular(screenWidth / (width / 20)),
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Appointment Details

                      //Title
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, screenWidth / (width / 20), 0, 0),
                        child: Text(
                          'Make an appointment!',
                          style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? screenWidth / (width / 24)
                                  : screenWidth / (width / 20)),
                        ),
                      ),
                      //Practioner Name Row
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'Practioner Name: ',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? screenWidth / (width / 18)
                                                : screenWidth / (width / 16)),
                              ),
                            ),
                            Expanded(
                              flex: ResponsiveWidget.isLargeScreen(context)
                                  ? 4
                                  : 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / (width / 8)),
                                child: Text(
                                  widget.practioner.firstName +
                                      ' ' +
                                      widget.practioner.lastName,
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? screenWidth / (width / 18)
                                                : screenWidth / (width / 14),
                                        fontStyle: FontStyle.italic,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Services Row
                      if (ResponsiveWidget.isLargeScreen(context))
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Services: ',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize:
                                              ResponsiveWidget.isLargeScreen(
                                                      context)
                                                  ? screenWidth / (width / 18)
                                                  : screenWidth / (width / 16)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: screenWidth / (width / 8),
                                      left: screenWidth / (width / 12),
                                      right: screenWidth / (width / 8),
                                      bottom: screenWidth / (width / 8)),
                                  child: Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final services =
                                          ref.watch(servicesProvider);
                                      String initService =
                                          ref.watch(selectedServiceProvider);

                                      // print(initService);

                                      return services.when(
                                        data: (data) {
                                          return DropdownButtonFormField2(
                                            items: List.generate(
                                              data.length,
                                              (index) => DropdownMenuItem(
                                                value: data
                                                    .elementAt(index)
                                                    .servicesName,
                                                child: Text(
                                                  data
                                                      .elementAt(index)
                                                      .servicesName,
                                                  style: TextStyle(
                                                    fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context)
                                                        ? screenWidth /
                                                            (width / 14)
                                                        : screenWidth /
                                                            (width / 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) {
                                              ref
                                                  .read(selectedServiceProvider
                                                      .notifier)
                                                  .selectedService(
                                                      val.toString());

                                              selectedService = val;

                                              ref
                                                  .read(servicesChangeProvider
                                                      .notifier)
                                                  .state = val!.isNotEmpty;
                                            },
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize:
                                                ResponsiveWidget.isLargeScreen(
                                                        context)
                                                    ? screenWidth / (width / 30)
                                                    : 0,
                                            buttonHeight:
                                                screenWidth / (width / 60),
                                            buttonPadding: EdgeInsets.only(
                                                left: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 20)
                                                    : 0,
                                                right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 15)),
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  width: 1,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Select Services',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle2
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 18)),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 18)),
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
                              Text(
                                'Date: ',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? screenWidth / (width / 24)
                                                : screenWidth / (width / 20)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenWidth / (width / 8)),
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
                                                practioner:
                                                    widget.practioner.firstName,
                                                context: context,
                                              );
                                            },
                                          ) ??
                                          '';
                                      // setState(() {
                                      dateandtimeController.text =
                                          result.toString();

                                      print(dateandtimeController.text);

                                      selectedDate = result.toString();
                                    },
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18)),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      labelText: "Select date",
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .title2
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize: ResponsiveWidget
                                                      .isLargeScreen(context)
                                                  ? screenWidth / (width / 24)
                                                  : screenWidth / (width / 20)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              screenWidth / (width / 20),
                              screenWidth / (width / 20),
                              screenWidth / (width / 20),
                              screenWidth / (width / 20)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Services: ',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize:
                                              ResponsiveWidget.isLargeScreen(
                                                      context)
                                                  ? screenWidth / (width / 24)
                                                  : screenWidth / (width / 16)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenWidth / (width / 8)),
                                  child: Consumer(
                                    builder: (BuildContext context,
                                        WidgetRef ref, Widget? child) {
                                      final services =
                                          ref.watch(servicesProvider);
                                      String initService =
                                          ref.watch(selectedServiceProvider);

                                      // print(initService);

                                      return services.when(
                                        data: (data) {
                                          return DropdownButtonFormField2(
                                            // value: locationSelected,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize:
                                                screenWidth / (width / 30),
                                            buttonHeight:
                                                screenWidth / (width / 60),
                                            buttonPadding: EdgeInsets.only(
                                                left:
                                                    screenWidth / (width / 20),
                                                right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 15)),
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  width: 1,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Select Services',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle2
                                                  .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: ResponsiveWidget
                                                              .isLargeScreen(
                                                                  context)
                                                          ? screenWidth /
                                                              (width / 18)
                                                          : screenWidth /
                                                              (width / 14)),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context)
                                                        ? screenWidth /
                                                            (width / 18)
                                                        : screenWidth /
                                                            (width / 14)),
                                            items: List.generate(
                                              data.length,
                                              (index) => DropdownMenuItem(
                                                value: data
                                                    .elementAt(index)
                                                    .servicesName,
                                                child: Text(
                                                  data
                                                      .elementAt(index)
                                                      .servicesName,
                                                  style: TextStyle(
                                                    fontSize: screenWidth /
                                                        (width / 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) {
                                              ref
                                                  .read(selectedServiceProvider
                                                      .notifier)
                                                  .selectedService(
                                                      val.toString());

                                              selectedService = val;

                                              ref
                                                  .read(servicesChangeProvider
                                                      .notifier)
                                                  .state = val!.isNotEmpty;
                                            },
                                            onSaved: (value) {
                                              // selectedValue =
                                              //     value.toString();
                                            },
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
                            ],
                          ),
                        ),
                      if (!ResponsiveWidget.isLargeScreen(context))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              screenWidth / (width / 20),
                              screenWidth / (width / 20),
                              screenWidth / (width / 20),
                              screenWidth / (width / 20)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Date: ',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 16)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenWidth / (width / 8)),
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
                                                practioner:
                                                    widget.practioner.firstName,
                                                context: context,
                                              );
                                            },
                                          ) ??
                                          '';
                                      // setState(() {
                                      dateandtimeController.text =
                                          result.toString();

                                      print(dateandtimeController.text);

                                      selectedDate = result.toString();
                                    },
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize: ResponsiveWidget
                                                    .isLargeScreen(context)
                                                ? screenWidth / (width / 18)
                                                : screenWidth / (width / 14)),
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      labelText: "Select date",
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .title2
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize: ResponsiveWidget
                                                      .isLargeScreen(context)
                                                  ? screenWidth / (width / 24)
                                                  : screenWidth / (width / 20)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 8)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      //Time Row
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'Time: ',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? screenWidth / (width / 18)
                                                : screenWidth / (width / 16)),
                              ),
                            ),
                            Expanded(
                              flex: ResponsiveWidget.isLargeScreen(context)
                                  ? 4
                                  : 2,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final valuesService =
                                        ref.watch(servicesChangeProvider);

                                    final valueDate =
                                        ref.watch(dateChangeProvider);
                                    if (valuesService! && valueDate!) {
                                      return SizedBox(
                                        height: screenWidth / (width / 210),
                                        child: TimesGridView(
                                          serviceTime:
                                              selectedService.toString(),
                                          schedule: widget.practioner.schedules,
                                          selectedTime:
                                              dateandtimeController.text,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'Please select service and date',
                                        style: FlutterFlowTheme.of(context)
                                            .title2
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontStyle: FontStyle.italic,
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 14)),
                                        textAlign: TextAlign.start,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Location Row
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                'Location: ',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            ResponsiveWidget.isLargeScreen(
                                                    context)
                                                ? screenWidth / (width / 18)
                                                : screenWidth / (width / 16)),
                              ),
                            ),
                            Expanded(
                              flex: ResponsiveWidget.isLargeScreen(context)
                                  ? 4
                                  : 2,
                              child: Padding(
                                  padding:
                                      EdgeInsets.all(screenWidth / (width / 8)),
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final locations =
                                          ref.watch(locationProvider);
                                      // final locationSelected = ref.watch(
                                      //     locationSelectedProvider);

                                      return locations.when(
                                        data: (data) {
                                          // print(selectedLocation);
                                          return DropdownButtonFormField2(
                                            // value: locationSelected,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize:
                                                screenWidth / (width / 30),
                                            buttonHeight:
                                                screenWidth / (width / 60),
                                            buttonPadding: EdgeInsets.only(
                                                left:
                                                    screenWidth / (width / 20),
                                                right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 15)),
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  width: 1,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth /
                                                            (width / 8)),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            hint: Text(
                                              'Select Location',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle2
                                                  .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: ResponsiveWidget
                                                              .isLargeScreen(
                                                                  context)
                                                          ? screenWidth /
                                                              (width / 18)
                                                          : screenWidth /
                                                              (width / 14)),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context)
                                                        ? screenWidth /
                                                            (width / 18)
                                                        : screenWidth /
                                                            (width / 14)),
                                            items: List.generate(
                                              data.length,
                                              (index) => DropdownMenuItem(
                                                value:
                                                    data.elementAt(index).type,
                                                child: Text(
                                                  data.elementAt(index).type,
                                                  style: TextStyle(
                                                    fontSize: screenWidth /
                                                        (width / 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              // selectedLocation = value;
                                              ref
                                                  .read(locationSelectedProvider
                                                      .notifier)
                                                  .changeLocation(
                                                      value.toString());

                                              selectedLocation = value;
                                              //Do something when changing the item if you want.
                                            },
                                            onSaved: (value) {
                                              // selectedValue =
                                              //     value.toString();
                                            },
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
                                  )),
                            ),
                          ],
                        ),
                      ),

                      //Client Details

                      //Title
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20)),
                        child: Text(
                          'Your Details',
                          style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: ResponsiveWidget.isLargeScreen(context)
                                  ? screenWidth / (width / 24)
                                  : screenWidth / (width / 20)),
                        ),
                      ),
                      //Client Details Column
                      userInfo.when(
                        data: (data) {
                          emailController.text = data.email.toString();
                          phNumbController.text = data.phoneNumber.toString();

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Code/Name: ',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 16)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 4
                                          : 2,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10)),
                                        child: DropdownButtonFormField2(
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: screenWidth / (width / 30),
                                          buttonHeight:
                                              screenWidth / (width / 60),
                                          buttonPadding: EdgeInsets.only(
                                              left: screenWidth / (width / 20),
                                              right: 10),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                screenWidth / (width / 15)),
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                width: 1,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          hint: Text(
                                            'Select Name/Code',
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context)
                                                        ? screenWidth /
                                                            (width / 18)
                                                        : screenWidth /
                                                            (width / 12)),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ResponsiveWidget
                                                          .isLargeScreen(
                                                              context)
                                                      ? screenWidth /
                                                          (width / 18)
                                                      : screenWidth /
                                                          (width / 12)),
                                          items: [
                                            DropdownMenuItem(
                                              value:
                                                  '${data.firstName} ${data.lastName}',
                                              child: Text(
                                                '${data.firstName} ${data.lastName}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: ResponsiveWidget
                                                                .isLargeScreen(
                                                                    context)
                                                            ? screenWidth /
                                                                (width / 18)
                                                            : screenWidth /
                                                                (width / 8)),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: data.clientcode,
                                              child: Text(
                                                data.clientcode,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: ResponsiveWidget
                                                                .isLargeScreen(
                                                                    context)
                                                            ? screenWidth /
                                                                (width / 18)
                                                            : screenWidth /
                                                                (width / 8)),
                                              ),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            selectedCodeorName = value;
                                            //Do something when changing the item if you want.
                                          },
                                          onSaved: (value) {
                                            // selectedValue = value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Email: ',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 16)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 4
                                          : 2,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10)),
                                        child: Text(
                                          data.email!,
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 14),
                                                fontStyle: FontStyle.italic,
                                              ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Phone Number: ',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 16)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 4
                                          : 2,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10)),
                                        child: Text(
                                          data.phoneNumber!,
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 14),
                                                fontStyle: FontStyle.italic,
                                              ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(screenWidth / (width / 20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Comment: ',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize: ResponsiveWidget
                                                        .isLargeScreen(context)
                                                    ? screenWidth / (width / 18)
                                                    : screenWidth /
                                                        (width / 16)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 4
                                          : 2,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10)),
                                        child: TextFormField(
                                          controller: commentController,
                                          autofocus: true,
                                          obscureText: false,
                                          // readOnly: true,
                                          decoration: InputDecoration(
                                            hintText:
                                                "What would you like to gain from this session?",
                                            // enabled: false,
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .subtitle2
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context)
                                                        ? screenWidth /
                                                            (width / 18)
                                                        : screenWidth /
                                                            (width / 16)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 8)),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 18)),
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          return const ErrorAnimationView();
                        },
                        loading: () {
                          return const LoadingAnimationView();
                        },
                      ),

                      //Submit button
                      Padding(
                        padding: EdgeInsets.all(screenWidth / (width / 8)),
                        child: SizedBox(
                          width: screenWidth / (width / 150),
                          height: screenWidth / (width / 30),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => FlutterFlowTheme.of(context)
                                      .primaryColor),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                    width: 1.0, color: Colors.transparent),
                              ),
                            ),
                            onPressed: true
                                ? () async {
                                    final appointmentData = AppointmentData(
                                      clientId: userUid.toString(),
                                      practionerId:
                                          widget.practioner.userId.toString(),
                                      practionerName:
                                          '${widget.practioner.firstName} ${widget.practioner.lastName}',
                                      services: selectedService.toString(),
                                      date:
                                          dateandtimeController.text.toString(),
                                      time: selectedTime,
                                      location: selectedLocation.toString(),
                                      clientNameorCode:
                                          selectedCodeorName.toString(),
                                      clientEmail: emailController.text,
                                      clientphNumber: phNumbController.text,
                                      clientComment:
                                          commentController.text.toString(),
                                    );
                                    // final appointmentData2 = Appointment(
                                    //     appointmentId: appointmentId,
                                    //     json: json);
                                    final isUploaded = await ref
                                        .read(appointmentUploaderProvider
                                            .notifier)
                                        .upload(
                                          appointmentData: appointmentData,
                                        );
                                    if (isUploaded && mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            child: Text(
                              'Submit',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth / (width / 16),
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
