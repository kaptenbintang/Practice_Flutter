// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import 'package:login_uix_firebase/model/events/events_data.dart';

class ManageEventDesktop extends StatefulWidget {
  const ManageEventDesktop({super.key});

  @override
  State<ManageEventDesktop> createState() => _ManageEventDesktopState();
}

class _ManageEventDesktopState extends State<ManageEventDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<EventsData>>? EventsList;
  Map<String, dynamic>? currentEventsData;
  List<EventsData>? retrievedEventsList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  EventsData? dataU;

  final _eventDate = TextEditingController();
  final _eventLocation = TextEditingController();
  final _eventPrice = TextEditingController();
  final _eventTitle = TextEditingController();
  final _eventDescription = TextEditingController();

  String? eventId;
  Timestamp? eventDate;
  String? eventLocation;
  String? eventPrice;
  String? eventTitle;
  String? eventDescription;
  String? eventImage;

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
    EventsList = service.retrieveEventsAll();
    retrievedEventsList = await service.retrieveEventsAll();
    selected =
        List<bool>.generate(retrievedEventsList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedEventsList = await service.retrieveEventsAll();

    setState(() {
      EventsList = service.retrieveEventsAll();
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
                blurRadius: 4,
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
                          fontSize: screenWidth / (width / 20)),
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
                    screenWidth / (width / 12),
                    0,
                    screenWidth / (width / 12),
                    0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 4),
                          0,
                          screenWidth / (width / 4),
                          screenWidth / (width / 24)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              screenWidth / (width / 30),
                                          borderWidth: 1,
                                          buttonSize:
                                              screenWidth / (width / 50),
                                          icon: Icon(
                                            Icons.playlist_add,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: screenWidth / (width / 25),
                                          ),
                                          onPressed: () {
                                            dialogaddEvent(context);
                                            _pullRefresh();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 5), 0, 0, 0),
                                        child: Text(
                                          'Events',
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Search textfield and icon
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: screenWidth / (width / 200),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  screenWidth / (width / 16),
                                                  0,
                                                  screenWidth / (width / 5)),
                                          child: Container(
                                            width: screenWidth / (width / 200),
                                            child: TextFormField(
                                              controller: textController,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Search...',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: screenWidth /
                                                            (width / 14)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius:
                                            screenWidth / (width / 30),
                                        borderWidth: 1,
                                        buttonSize: screenWidth / (width / 50),
                                        icon: Icon(
                                          Icons.search,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: screenWidth / (width / 25),
                                        ),
                                        onPressed: () {},
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
                                      child: Text(
                                        'Date',
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
                                          'Price',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                    ))
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Title',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                      Expanded(
                                        child: Text(
                                          'Location',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    Expanded(
                                      child: Text(
                                        'Thumbnail',
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
                                        'Action',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
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
                                    future: EventsList,
                                    builder: (context,
                                        AsyncSnapshot<List<EventsData>>
                                            snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              retrievedEventsList!.length,
                                          itemBuilder: (context, indexs) {
                                            return _buildTableUser(
                                                context,
                                                retrievedEventsList![indexs],
                                                retrievedEventsList,
                                                indexs);
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          retrievedEventsList!.isEmpty) {
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
            ],
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, EventsData event,
      List<EventsData>? user, int indexs) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
      padding:
          EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenWidth / (width / 2)),
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
              // Date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      DateFormat.yMMMd().format(event.eventsDate!.toDate()),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 16),
                          ),
                    ),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                //Price
                Expanded(
                  child: Text(
                    event.eventsPrice!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                //Title
                Expanded(
                  flex: 2,
                  child: Text(
                    event.eventsTitle!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                //Location
                Expanded(
                  child: Text(
                    event.eventsLocation!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              //Event Image
              Expanded(
                child: Image.network(
                  event.eventsImage!,
                  height: screenWidth / (width / 200),
                  fit: BoxFit.cover,
                ),
              ),
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
                          dialogEditEvent(context, event);
                          setState(() {
                            eventId = event.id;
                            _eventDate.text = DateFormat.yMd()
                                .add_jm()
                                .format(event.eventsDate!.toDate());
                            eventDate = event.eventsDate;
                            _eventLocation.text =
                                event.eventsLocation.toString();
                            _eventDescription.text = event.eventsDescription!;
                            _eventPrice.text = event.eventsPrice!;
                            _eventTitle.text = event.eventsTitle!;
                            eventImage = event.eventsImage;
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
                            borderRadius: screenWidth / (width / 8)),
                      ),
                    ),
                    //Delete Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 5), 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await service.deleteEvent(context, event);
                          await service.deleteEventImage(event);
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
                            borderRadius: screenWidth / (width / 8)),
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

  Future<dynamic> dialogEditEvent(BuildContext context, EventsData eventdata) {
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
            title: Center(child: const Text("Edit Event")),
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
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth / (width / 500),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: [
                            Text(
                              "Thumbnail:",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth / (width / 12),
                                  ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  /*
                                  * Step 1. Pick/Capture an image   (image_picker)
                                  * Step 2. Upload the image to Firebase storage
                                  * Step 3. Get the URL of the uploaded image
                                  * Step 4. Store the image URL inside the corresponding
                                  *         document of the database.
                                  * Step 5. Display the image on the list
                                  *
                                  * */

                                  /*Step 1:Pick image*/
                                  //Install image_picker
                                  //Import the corresponding library
                                  FilePickerResult? result;

                                  try {
                                    result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'jpg',
                                        'png',
                                        'jpeg',
                                        'gif'
                                      ],
                                    );
                                  } catch (e) {
                                    print(e);
                                  }

                                  if (result != null) {
                                    try {
                                      String dirpath = 'eventsImage/';

                                      Uint8List? uploadfile =
                                          result.files.single.bytes;

                                      String filename =
                                          result.files.single.name;

                                      Reference storageRef = FirebaseStorage
                                          .instance
                                          .ref()
                                          .child('$dirpath$filename');

                                      final UploadTask uploadTask =
                                          storageRef.putData(uploadfile!);

                                      final TaskSnapshot downloadUrl =
                                          await uploadTask;

                                      eventImage = (await downloadUrl.ref
                                          .getDownloadURL());
                                    } catch (e) {
                                      print(e);
                                    }
                                  }

                                  // FilePickerResult? result =
                                  //     await FilePicker.platform.pickFiles(
                                  //   type: FileType.custom,
                                  //   allowedExtensions: [
                                  //     'jpg',
                                  //     'png',
                                  //     'jpeg',
                                  //     'gif'
                                  //   ],
                                  // );

                                  // if (result != null) {
                                  //   Uint8List fileBytes =
                                  //       result.files.first.bytes!;
                                  //   String fileName = result.files.first.name;
                                  //   print(result.paths.first);
                                  //   //Import dart:core
                                  //   String uniqueFileName = eventTitle!;

                                  //   /*Step 2: Upload to Firebase storage*/
                                  //   //Install firebase_storage
                                  //   //Import the library

                                  //   //Get a reference to storage root
                                  //   Reference referenceRoot =
                                  //       FirebaseStorage.instance.ref();
                                  //   Reference referenceDirImages =
                                  //       referenceRoot.child('eventsImage/');

                                  //   //Create a reference for the image to be stored
                                  //   Reference referenceImageToUpload =
                                  //       referenceDirImages
                                  //           .child(uniqueFileName);

                                  //   //Handle errors/success
                                  //   try {
                                  //     //Store the file
                                  //     // await referenceImageToUpload.putFile(file);
                                  //     await FirebaseStorage.instance
                                  //         .ref('eventsImage/$fileName')
                                  //         .putData(fileBytes);
                                  //     //Success: get the download URL
                                  //     eventImage = await referenceImageToUpload
                                  //         .getDownloadURL();
                                  //   } catch (error) {
                                  //     //Some error occurred
                                  //   }
                                  //   // Upload file

                                  // }
                                },
                                icon: Icon(Icons.camera_alt)),
                          ]),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: SizedBox(
                              width: screenWidth / (width / 500),
                              child: TextFormField(
                                maxLines: 4,
                                controller: _eventDescription,
                                decoration: InputDecoration(
                                  labelText: "Event Description",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: TextFormField(
                              controller: _eventLocation,
                              decoration: InputDecoration(
                                labelText: "Event Location",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: TextFormField(
                              controller: _eventPrice,
                              decoration: InputDecoration(
                                labelText: "Event Price",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: TextFormField(
                              controller: _eventTitle,
                              decoration: InputDecoration(
                                labelText: "Event Title",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        2023), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2024));

                                var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());

                                // DateTimeRange? pickedRange =
                                //     await showDateRangePicker(
                                //   context: context,
                                //   firstDate: DateTime.now(),
                                //   lastDate: DateTime(2023),
                                //   // initialDateRange: dateRange.value
                                // );

                                if (pickedDate != null &&
                                    // pickedRange != null &&
                                    time != null) {
                                  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement
                                  setState(() {
                                    _eventDate.text =
                                        "$formattedDate ${time.hour}:${time.minute}";
                                    eventDate = Timestamp.fromDate(pickedDate);
                                    //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              controller: _eventDate,
                              decoration: InputDecoration(
                                labelText: "Event Date",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenWidth / (width / 40),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth / (width / 8)),
                            child: ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await service.deleteEventImage(eventdata);
                                  EventsData eventData = EventsData(
                                    id: eventId,
                                    eventsDate: eventDate,
                                    eventsLocation: _eventLocation.text,
                                    eventsPrice: _eventPrice.text,
                                    eventsTitle: _eventTitle.text,
                                    eventsDescription: _eventDescription.text,
                                    eventsImage: eventImage,
                                  );
                                  await service.updateEvent(eventData);
                                  Navigator.pop(context);
                                  _pullRefresh();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogaddEvent(BuildContext context) {
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
            title: const Text("Add new event"),
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
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(children: [
                          Text(
                            "Thumbnail:",
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 12),
                                    ),
                          ),
                          IconButton(
                              onPressed: () async {
                                /*
                                  * Step 1. Pick/Capture an image   (image_picker)
                                  * Step 2. Upload the image to Firebase storage
                                  * Step 3. Get the URL of the uploaded image
                                  * Step 4. Store the image URL inside the corresponding
                                  *         document of the database.
                                  * Step 5. Display the image on the list
                                  *
                                  * */

                                /*Step 1:Pick image*/
                                //Install image_picker
                                //Import the corresponding library
                                FilePickerResult? result;

                                try {
                                  result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'png',
                                      'jpeg',
                                      'gif'
                                    ],
                                  );
                                } catch (e) {
                                  print(e);
                                }

                                if (result != null) {
                                  try {
                                    String dirpath = 'eventsImage/';

                                    Uint8List? uploadfile =
                                        result.files.single.bytes;

                                    String filename = result.files.single.name;

                                    Reference storageRef = FirebaseStorage
                                        .instance
                                        .ref()
                                        .child('$dirpath$filename');

                                    final UploadTask uploadTask =
                                        storageRef.putData(uploadfile!);

                                    final TaskSnapshot downloadUrl =
                                        await uploadTask;

                                    eventImage = (await downloadUrl.ref
                                        .getDownloadURL());
                                  } catch (e) {
                                    print(e);
                                  }
                                }

                                // FilePickerResult? result =
                                //     await FilePicker.platform.pickFiles(
                                //   type: FileType.custom,
                                //   allowedExtensions: [
                                //     'jpg',
                                //     'png',
                                //     'jpeg',
                                //     'gif'
                                //   ],
                                // );

                                // if (result != null) {
                                //   Uint8List fileBytes =
                                //       result.files.first.bytes!;
                                //   String fileName = result.files.first.name;
                                //   print(result.paths.first);
                                //   //Import dart:core
                                //   String uniqueFileName = eventTitle!;

                                //   /*Step 2: Upload to Firebase storage*/
                                //   //Install firebase_storage
                                //   //Import the library

                                //   //Get a reference to storage root
                                //   Reference referenceRoot =
                                //       FirebaseStorage.instance.ref();
                                //   Reference referenceDirImages =
                                //       referenceRoot.child('eventsImage/');

                                //   //Create a reference for the image to be stored
                                //   Reference referenceImageToUpload =
                                //       referenceDirImages
                                //           .child(uniqueFileName);

                                //   //Handle errors/success
                                //   try {
                                //     //Store the file
                                //     // await referenceImageToUpload.putFile(file);
                                //     await FirebaseStorage.instance
                                //         .ref('eventsImage/$fileName')
                                //         .putData(fileBytes);
                                //     //Success: get the download URL
                                //     eventImage = await referenceImageToUpload
                                //         .getDownloadURL();
                                //   } catch (error) {
                                //     //Some error occurred
                                //   }
                                //   // Upload file

                                // }
                              },
                              icon: Icon(Icons.camera_alt)),
                        ]),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: SizedBox(
                            width: screenWidth / (width / 500),
                            child: TextFormField(
                              maxLines: 4,
                              controller: _eventDescription,
                              decoration: InputDecoration(
                                labelText: "Event Description",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _eventLocation,
                            decoration: InputDecoration(
                              labelText: "Event Location",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _eventPrice,
                            decoration: InputDecoration(
                              labelText: "Event Price",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _eventTitle,
                            decoration: InputDecoration(
                              labelText: "Event Title",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2023), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2024));

                              var time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());

                              // DateTimeRange? pickedRange =
                              //     await showDateRangePicker(
                              //   context: context,
                              //   firstDate: DateTime.now(),
                              //   lastDate: DateTime(2023),
                              //   // initialDateRange: dateRange.value
                              // );

                              if (pickedDate != null &&
                                  // pickedRange != null &&
                                  time != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  _eventDate.text =
                                      "$formattedDate ${time.hour}:${time.minute}";
                                  eventDate = Timestamp.fromDate(pickedDate);
                                  //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            controller: _eventDate,
                            decoration: InputDecoration(
                              labelText: "Event Date",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenWidth / (width / 40),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (eventImage!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Please upload an image')));

                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                EventsData eventsData = EventsData(
                                  id: eventId,
                                  eventsDate: eventDate,
                                  eventsLocation: _eventLocation.text,
                                  eventsPrice: _eventPrice.text,
                                  eventsTitle: _eventTitle.text,
                                  eventsDescription: _eventDescription.text,
                                  eventsImage: eventImage,
                                );
                                await service.addEvent(eventsData);
                                Navigator.pop(context);
                                _pullRefresh();
                              }
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
  }
}
