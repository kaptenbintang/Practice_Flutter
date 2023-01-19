// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../model/events/events_data.dart';
import '../../model/practioner_data.dart';

class ManageEventMobile extends StatefulWidget {
  const ManageEventMobile({super.key});

  @override
  State<ManageEventMobile> createState() => _ManageEventMobileState();
}

class _ManageEventMobileState extends State<ManageEventMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<EventsData>>? EventsList;
  Map<String, dynamic>? currentEventsData;
  List<EventsData>? retrievedEventsList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  EventsData? dataU;
  final FocusNode dropDownFocus = FocusNode();

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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            Dimensions.width16,
            Dimensions.height08 * 2,
            Dimensions.width16,
            Dimensions.height08 * 2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, Dimensions.height08 / 4),
              )
            ],
            borderRadius: BorderRadius.circular(Dimensions.font16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(Dimensions.width16,
                    Dimensions.height08 * 2, 0, Dimensions.height08 * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height08 / 2, 0, 0),
                      child: Text(
                        'Your project status is appearing here.',
                        style: FlutterFlowTheme.of(context).bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    Dimensions.width24 - Dimensions.width10,
                    0,
                    Dimensions.width24 - Dimensions.width10,
                    Dimensions.height24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(Dimensions.font16),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).lineColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, Dimensions.height08 * 2, 0, Dimensions.height24 / 2),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Container title
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.width08 * 2, 0, 0, 0),
                            child: Text(
                              'Events',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                          //Search textfield icon, add button
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //search row
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10,
                                          Dimensions.height05,
                                          0,
                                          Dimensions.height05),
                                      child: Container(
                                        width: Dimensions.width100 +
                                            Dimensions.width10 * 5,
                                        child: TextFormField(
                                          controller: textController,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search...',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                lineHeight: 1.01,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10 / 2, 0, 0, 0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: Dimensions.radius30,
                                        borderWidth: 1,
                                        buttonSize: Dimensions.font20 * 2,
                                        icon: Icon(
                                          Icons.search,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: Dimensions.font20,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //add button
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: Dimensions.radius30,
                                borderWidth: 1,
                                buttonSize: Dimensions.font20 * 2,
                                icon: Icon(
                                  Icons.playlist_add,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: Dimensions.font20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                  dialogaddEvent(context);
                                  _pullRefresh();
                                },
                              ),
                            ],
                          ),
                          //Column title
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.width24 / 2,
                                Dimensions.height24 / 2,
                                Dimensions.width24 / 2,
                                0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10, 0, 0, 0),
                                      child: Text(
                                        'Events',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Text(
                                    'Action',
                                    textAlign: TextAlign.end,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Data row
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, Dimensions.height08 * 2, 0, 0),
                            child: FutureBuilder(
                                future: EventsList,
                                builder: (context,
                                    AsyncSnapshot<List<EventsData>> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: retrievedEventsList!.length,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, EventsData event,
      List<EventsData>? user, int indexs) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height08 / 4),
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
              Dimensions.width24 / 2,
              Dimensions.height24 / 2,
              Dimensions.width24 / 2,
              Dimensions.height24 / 2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //date title and image
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //date
                    AutoSizeText(
                      DateFormat.yMMMd().format(event.eventsDate!.toDate()),
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      //title
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, Dimensions.height08 / 4, 0, 0),
                        child: Text(
                          event.eventsTitle!,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    //image
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height08 / 4, 0, 0),
                      child: Image.network(
                        event.eventsImage!,
                        height: Dimensions.height100,
                        width: Dimensions.height100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              //dropdown
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusNode: dropDownFocus,
                        isExpanded: true,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        iconSize: Dimensions.font20 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: Dimensions.font20,
                        ),
                        onChanged: (value) async {
                          print(value);
                          // if value doesnt contain just close the dropDown
                          if (value == null) {
                            dropDownFocus.unfocus();
                          } else {
                            switch (value) {
                              case "Remove":
                                print('Button pressed ...');
                                await service.deleteEvent(context, event);
                                await service.deleteEventImage(event);
                                _pullRefresh();
                                break;
                              case "Edit":
                                print('Button pressed ...');
                                dialogEditEvent(context, event);
                                setState(() {
                                  eventId = event.id;
                                  _eventDate.text = DateFormat.yMd()
                                      .add_jm()
                                      .format(event.eventsDate!.toDate());
                                  eventDate = event.eventsDate;
                                  _eventLocation.text =
                                      event.eventsLocation.toString();
                                  _eventDescription.text =
                                      event.eventsDescription!;
                                  _eventPrice.text = event.eventsPrice!;
                                  _eventTitle.text = event.eventsTitle!;
                                  eventImage = event.eventsImage;
                                });
                                break;
                              default:
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Action'),
                            value: "Action",
                          ),
                          DropdownMenuItem(
                            child: Text('Edit'),
                            value: "Edit",
                          ),
                          DropdownMenuItem(
                            child: Text('Remove'),
                            value: "Remove",
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
    );
  }

  Future<dynamic> dialogEditEvent(BuildContext context, EventsData eventdata) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Event"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width10 * 4),
                  top: -(Dimensions.height20 * 4),
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
                                      fontSize: Dimensions.height24 / 2,
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
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            maxLines: 4,
                            controller: _eventDescription,
                            decoration: InputDecoration(
                              labelText: "Event Description",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventLocation,
                            decoration: InputDecoration(
                              labelText: "Event Location",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventPrice,
                            decoration: InputDecoration(
                              labelText: "Event Price",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventTitle,
                            decoration: InputDecoration(
                              labelText: "Event Title",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          height: Dimensions.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogaddEvent(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new Event"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width10 * 4),
                  top: -(Dimensions.height20 * 4),
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
                                      fontSize: Dimensions.height24 / 2,
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
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            maxLines: 4,
                            controller: _eventDescription,
                            decoration: InputDecoration(
                              labelText: "Event Description",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventLocation,
                            decoration: InputDecoration(
                              labelText: "Event Location",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventPrice,
                            decoration: InputDecoration(
                              labelText: "Event Price",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _eventTitle,
                            decoration: InputDecoration(
                              labelText: "Event Title",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          height: Dimensions.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
