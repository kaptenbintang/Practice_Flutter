import 'package:booking_calendar/booking_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_drop_down.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/provider/appointment_page/appointment_upload_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/location_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
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

    final userUid = ref.watch(userIdProvider);
    final userInfo = ref.watch(userInfoModelProvider(userUid.toString()));

    final pNameController = useTextEditingController();
    final dateandtimeController = useTextEditingController();
    final emailController = useTextEditingController();
    final phNumbController = useTextEditingController();
    final commentController = useTextEditingController();
    String? selectedService,
        selectedDate,
        selectedTime,
        selectedEmail,
        selectedPhone,
        selectedLocation,
        selectedCodeorName;

    final isAppointmentButtonEnable = useState(false);

    final List<String> genderItems = [
      'Male',
      'Female',
    ];

    // String? selectedLocation;

    useEffect(
      () {
        void listener() {
          isAppointmentButtonEnable.value =
              dateandtimeController.text.isNotEmpty;
        }

        dateandtimeController.addListener(listener);

        // commentController.addListener(listener);

        return () {
          dateandtimeController.removeListener(listener);

          // commentController.removeListener(listener);
        };
      },
      [
        dateandtimeController,

        // commentController,
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
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
                    padding: EdgeInsetsDirectional.fromSTEB(100, 40, 0, 100),
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
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.viewProfilePage);
                              },
                              child: Text(
                                'Profile',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.historyBookingRiverpod);
                              },
                              child: Text(
                                'Booking History',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search Something here..',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
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
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 100, 100),
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
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  'Make an appointment!',
                                  style: FlutterFlowTheme.of(context).title1,
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
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: TextFormField(
                                        controller: pNameController,
                                        autofocus: true,
                                        obscureText: false,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText:
                                              widget.practioner.firstName +
                                                  ' ' +
                                                  widget.practioner.lastName,
                                          enabled: false,
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                        style: FlutterFlowTheme.of(context)
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
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: Consumer(
                                        builder: (BuildContext context,
                                            WidgetRef ref, Widget? child) {
                                          final services =
                                              ref.watch(servicesProvider);
                                          String initService = ref
                                              .watch(selectedServiceProvider)
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
                                                  selectedService = val;
                                                  // print(initService);
                                                },
                                                initialOption: initService,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1,
                                                hintText: 'Please select..',
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                                elevation: 0,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                borderWidth: 1,
                                                borderRadius: 8,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 4),
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
                                  const SizedBox(width: 10),
                                  Text(
                                    'Date: ',
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Expanded(
                                    flex: 2,
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
                                              ) ??
                                              '';
                                          // setState(() {
                                          dateandtimeController.text =
                                              result.toString();

                                          selectedDate = result.toString();
                                          // });

                                          // print(resultDate);
                                          // print(
                                          //     dateandtimeController.text);
                                        },
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          labelText: "Select date",
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.blue,
                                          ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                  const SizedBox(width: 10),
                                  Text(
                                    'Time: ',
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          return DropdownButtonFormField2(
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            hint: Text(
                                              'Select Time',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle1,
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black45,
                                            ),
                                            iconSize: 30,
                                            buttonHeight: 60,
                                            buttonPadding:
                                                const EdgeInsets.only(
                                                    left: 20, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            items: genderItems
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select gender.';
                                              }
                                            },
                                            onChanged: (value) {
                                              selectedTime = value;

                                              //Do something when changing the item if you want.
                                            },
                                            onSaved: (value) {
                                              // selectedValue = value.toString();
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Location: ',
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                                  iconSize: 30,
                                                  buttonHeight: 60,
                                                  buttonPadding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 10),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                                        .subtitle1,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle1,
                                                  items: List.generate(
                                                    data.length,
                                                    (index) => DropdownMenuItem(
                                                      value: data
                                                          .elementAt(index)
                                                          .type,
                                                      child: Text(
                                                        data
                                                            .elementAt(index)
                                                            .type,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // selectedLocation = value;
                                                    ref
                                                        .read(
                                                            locationSelectedProvider
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
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Text(
                                  'Your Details',
                                  style: FlutterFlowTheme.of(context).title1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: userInfo.when(
                                data: (data) {
                                  emailController.text = data.email.toString();
                                  phNumbController.text =
                                      data.phoneNumber.toString();

                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Code/Name: ',
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                              child: DropdownButtonFormField2(
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black45,
                                                ),
                                                iconSize: 30,
                                                buttonHeight: 60,
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 20, right: 10),
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                hint: Text(
                                                  'Select Name/Code',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle1,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1,
                                                items: [
                                                  DropdownMenuItem(
                                                    value:
                                                        '${data.firstName} ${data.lastName}',
                                                    child: Text(
                                                        '${data.firstName} ${data.lastName}'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: data.clientcode,
                                                    child:
                                                        Text(data.clientcode),
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Email: ',
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                              child: TextFormField(
                                                // initialValue: data.email,

                                                controller: emailController,
                                                // onChanged: (value) {
                                                //   selectedEmail = emailController.text;
                                                // },
                                                autofocus: true,
                                                obscureText: false,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: data.email,
                                                  // enabled: false,
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1,
                                                keyboardType:
                                                    TextInputType.name,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Phone Number: ',
                                            style: FlutterFlowTheme.of(context)
                                                .title1,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                              child: TextFormField(
                                                // initialValue: data.phoneNumber,
                                                controller: phNumbController,
                                                // onChanged: (value) {
                                                //   selectedPhone = value;
                                                // },
                                                autofocus: true,
                                                obscureText: false,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: data.phoneNumber,
                                                  // enabled: false,
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1,
                                                keyboardType:
                                                    TextInputType.name,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Comment: ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title1,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 20, 20, 20),
                                              child: TextFormField(
                                                controller: commentController,
                                                autofocus: true,
                                                obscureText: false,
                                                // readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "What would you like to gain from this session?",
                                                  // enabled: false,
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1,
                                                keyboardType:
                                                    TextInputType.multiline,
                                              ),
                                            ),
                                          ),
                                        ],
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
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                          width: 1.0,
                                          color: Colors.transparent),
                                    ),
                                  ),
                                  onPressed: isAppointmentButtonEnable.value
                                      ? () async {
                                          final appointmentData =
                                              AppointmentData(
                                            clientId: userUid.toString(),
                                            practionerId: widget
                                                .practioner.practionerId
                                                .toString(),
                                            practionerName:
                                                '${widget.practioner.firstName} ${widget.practioner.lastName}',
                                            services:
                                                selectedService.toString(),
                                            date: dateandtimeController.text
                                                .toString(),
                                            time: selectedTime,
                                            location:
                                                selectedLocation.toString(),
                                            clientNameorCode:
                                                selectedCodeorName.toString(),
                                            clientEmail: emailController.text,
                                            clientphNumber:
                                                phNumbController.text,
                                            clientComment: commentController
                                                .text
                                                .toString(),
                                          );
                                          final isUploaded = await ref
                                              .read(appointmentUploaderProvider
                                                  .notifier)
                                              .upload(
                                                appointmentData:
                                                    appointmentData,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
