// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../../flutter_flow/flutter_flow_theme.dart';
// import '../../flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../helper/database_service.dart';
// import '../../model/appointment_data.dart';
// import '../../route.dart';

// class HistoryBooking extends StatefulWidget {
//   const HistoryBooking({Key? key}) : super(key: key);

//   @override
//   _HistoryBookingState createState() => _HistoryBookingState();
// }

// class _HistoryBookingState extends State<HistoryBooking> {
//   TextEditingController? searchController;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   DataService service = DataService();
//   Future<List<AppointmentData>>? AppointmentList;
//   List<AppointmentData>? retrievedAppointmentList;

//   @override
//   void initState() {
//     super.initState();
//     _initRetrieval();
//     searchController = TextEditingController();
//   }

//   Future<void> _initRetrieval() async {
//     AppointmentList = service.retrieveApppointment2();
//     retrievedAppointmentList = await service.retrieveApppointment2();
//   }

//   @override
//   void dispose() {
//     searchController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   constraints: BoxConstraints(
//                     maxHeight: double.infinity,
//                   ),
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryColor,
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Align(
//                               alignment: AlignmentDirectional(-0.95, 0),
//                               child: Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     100, 40, 0, 100),
//                                 child: Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.3,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   decoration: BoxDecoration(),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Align(
//                                         alignment: AlignmentDirectional(-1, 0),
//                                         child: Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   20, 20, 20, 20),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.pushNamed(context,
//                                                   RouteName.MainPagesPage);
//                                             },
//                                             child: Text(
//                                               'Home',
//                                               textAlign: TextAlign.justify,
//                                               style:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyText1,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             20, 20, 20, 20),
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(context,
//                                                 RouteName.viewProfilePage);
//                                           },
//                                           child: Text(
//                                             'Profile',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyText1,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             20, 20, 20, 20),
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(
//                                                 context,
//                                                 RouteName
//                                                     .historyBookingRiverpod);
//                                           },
//                                           child: Text(
//                                             'Booking History',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyText1,
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: TextFormField(
//                                           controller: searchController,
//                                           autofocus: true,
//                                           obscureText: false,
//                                           decoration: InputDecoration(
//                                             hintText: 'Search Something here..',
//                                             hintStyle:
//                                                 FlutterFlowTheme.of(context)
//                                                     .bodyText2,
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .primaryText,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .primaryText,
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             errorBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color(0x00000000),
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             focusedErrorBorder:
//                                                 OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color(0x00000000),
//                                                 width: 1,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             prefixIcon: Icon(
//                                               Icons.search,
//                                             ),
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyText1,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0, 40, 100, 100),
//                               child: Image.asset(
//                                 'lib/images/Logo-Slogan-BL-H400-W1080.png',
//                                 width: MediaQuery.of(context).size.width * 0.12,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.06,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height * 1.5,
//                           child: Stack(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 height:
//                                     MediaQuery.of(context).size.height * 1.5,
//                                 decoration: BoxDecoration(
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryBackground,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       blurRadius: 12,
//                                       color: Color(0x33000000),
//                                       offset: Offset(0, 2),
//                                     )
//                                   ],
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(0),
//                                     bottomRight: Radius.circular(0),
//                                     topLeft: Radius.circular(60),
//                                     topRight: Radius.circular(60),
//                                   ),
//                                   shape: BoxShape.rectangle,
//                                 ),
//                                 child: StreamBuilder<QuerySnapshot>(
//                                     stream: FirebaseFirestore.instance
//                                         .collection('appointment')
//                                         .where('clientId',
//                                             isEqualTo: FirebaseAuth
//                                                 .instance.currentUser?.uid)
//                                         .where('statusAppointment',
//                                             isNotEqualTo: 'ongoing')
//                                         .snapshots(
//                                             includeMetadataChanges: true),
//                                     builder: (BuildContext context,
//                                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                                       if (snapshot.hasData &&
//                                           snapshot.data!.docs.isNotEmpty) {
// // Generated code for this Column Widget...
//                                         return Column(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsetsDirectional
//                                                   .fromSTEB(20, 20, 20, 20),
//                                               child: Text(
//                                                 'My Booking History',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .title1,
//                                               ),
//                                             ),
//                                             FutureBuilder(
//                                                 future: AppointmentList,
//                                                 builder: (context,
//                                                     AsyncSnapshot<
//                                                             List<
//                                                                 AppointmentData>>
//                                                         snapshot) {
//                                                   if (snapshot.hasData &&
//                                                       snapshot
//                                                           .data!.isNotEmpty) {
//                                                     return ListView.builder(
//                                                         padding:
//                                                             EdgeInsets.zero,
//                                                         shrinkWrap: true,
//                                                         scrollDirection:
//                                                             Axis.vertical,
//                                                         itemCount:
//                                                             retrievedAppointmentList!
//                                                                 .length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return tableDepanAppointment(
//                                                               context,
//                                                               retrievedAppointmentList![
//                                                                   index],
//                                                               retrievedAppointmentList,
//                                                               index);
//                                                         });

//                                                     // ListView(
//                                                     //   padding: EdgeInsets.zero,
//                                                     //   shrinkWrap: true,
//                                                     //   scrollDirection:
//                                                     //       Axis.vertical,
//                                                     // );
//                                                   } else if (snapshot
//                                                               .connectionState ==
//                                                           ConnectionState
//                                                               .done &&
//                                                       retrievedAppointmentList!
//                                                           .isEmpty) {
//                                                     return Center(
//                                                       child: ListView(
//                                                         physics:
//                                                             const AlwaysScrollableScrollPhysics(),
//                                                         children: const <
//                                                             Widget>[
//                                                           Align(
//                                                             alignment:
//                                                                 AlignmentDirectional
//                                                                     .center,
//                                                             child: Text(
//                                                                 'No Data Availble'),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     return const Center(
//                                                       child:
//                                                           CircularProgressIndicator(),
//                                                     );
//                                                   }
//                                                 })
//                                           ],
//                                         );
//                                       } else {
//                                         return Column(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsetsDirectional
//                                                   .fromSTEB(20, 60, 20, 20),
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.8,
//                                                 height: MediaQuery.of(context)
//                                                         .size
//                                                         .height *
//                                                     0.8,
//                                                 decoration: BoxDecoration(
//                                                   // color: FlutterFlowTheme.of(context)
//                                                   //     .lineColor,
//                                                   // boxShadow: [
//                                                   //   BoxShadow(
//                                                   //     blurRadius: 12,
//                                                   //     color: Color(0x33000000),
//                                                   //     offset: Offset(0, 2),
//                                                   //   )
//                                                   // ],
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                                 child: Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.max,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           EdgeInsetsDirectional
//                                                               .fromSTEB(20, 20,
//                                                                   20, 20),
//                                                       child: Text(
//                                                         'My Booking History',
//                                                         style:
//                                                             FlutterFlowTheme.of(
//                                                                     context)
//                                                                 .title1,
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           EdgeInsetsDirectional
//                                                               .fromSTEB(
//                                                                   0, 150, 0, 0),
//                                                       child: ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8),
//                                                         child: Image.asset(
//                                                           'lib/images/noappointment.png',
//                                                           width: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .width *
//                                                               0.3,
//                                                           height: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height *
//                                                               0.4,
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           EdgeInsetsDirectional
//                                                               .fromSTEB(20, 20,
//                                                                   20, 20),
//                                                       child: Text(
//                                                         'You haven\'t an appointment yet',
//                                                         style:
//                                                             FlutterFlowTheme.of(
//                                                                     context)
//                                                                 .subtitle2,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       }
//                                     }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget tableDepanAppointment(BuildContext context, AppointmentData snapshot,
//       List<AppointmentData>? user, int indexs) {
//     return Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
//       child: Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: FlutterFlowTheme.of(context).lineColor,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Booking id',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     'FEFEG#RX',
//                     style: FlutterFlowTheme.of(context).subtitle1,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Date/Time',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     snapshot.dateandtime.toString(),
//                     style: FlutterFlowTheme.of(context).subtitle1,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Services',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     snapshot.services.toString(),
//                     style: FlutterFlowTheme.of(context).subtitle1,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Practioner Name',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     snapshot.practionerName.toString(),
//                     style: FlutterFlowTheme.of(context).subtitle1,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Location',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     snapshot.location.toString(),
//                     style: FlutterFlowTheme.of(context).subtitle1,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
//                   child: Text(
//                     'Status',
//                     style: FlutterFlowTheme.of(context).title3,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                   child: Text(
//                     snapshot.statusAppointment.toString(),
//                     style: FlutterFlowTheme.of(context).subtitle1.override(
//                           fontFamily: 'Poppins',
//                           color: FlutterFlowTheme.of(context).secondaryColor,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
