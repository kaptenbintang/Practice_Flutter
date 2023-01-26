// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, sort_child_properties_last

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/database_service.dart';
import '../../model/clientType_data.dart';

class ManageClientTypeMobile extends StatefulWidget {
  const ManageClientTypeMobile({super.key});

  @override
  State<ManageClientTypeMobile> createState() => _ManageClientTypeMobileState();
}

class _ManageClientTypeMobileState extends State<ManageClientTypeMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<ClientData>>? clientList;
  Map<String, dynamic>? currentClientData;
  List<ClientData>? retrievedClientList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  ClientData? dataU;
  final FocusNode dropDownFocus = FocusNode();

  final _clientTypeController = TextEditingController();

  String? userId;
  String? clientTypeName;

  String? selectedValueClient;
  String? selectedValue;
  int _currentSortColumn = 0;
  bool _isAscending = true;

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
    clientList = service.retrieveClientType();
    retrievedClientList = await service.retrieveClientType();
    selected =
        List<bool>.generate(retrievedClientList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedClientList = await service.retrieveClientType();

    setState(() {
      clientList = service.retrieveClientType();
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
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(Dimensions.font16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title and subtitle
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(Dimensions.width16,
                    Dimensions.width16, 0, Dimensions.height08 * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title
                    Text(
                      'Dashboard',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                    //Subtitle
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
                          //COntainer Title
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.width16, 0, 0, 0),
                            child: Text(
                              'Client Type',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                          //Search and add button
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    //textfield search
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
                                    //search icon
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
                                  dialogAddNewClientType(context);
                                },
                              ),
                            ],
                          ),
                          //Column Title
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
                                          Dimensions.width30 / 10, 0, 0, 0),
                                      child: Text(
                                        'Client Type',
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
                          //Data Row
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, Dimensions.height08 * 2, 0, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                FutureBuilder(
                                    future: clientList,
                                    builder: (context,
                                        AsyncSnapshot<List<ClientData>>
                                            snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              retrievedClientList!.length,
                                          itemBuilder: (context, indexs) {
                                            return _buildTableUser(
                                                context,
                                                retrievedClientList![indexs],
                                                retrievedClientList,
                                                indexs);
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          retrievedClientList!.isEmpty) {
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
                              ],
                            ),
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

  _buildTableUser(BuildContext context, ClientData snapshot,
      List<ClientData>? user, int indexs) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height10 / 5),
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
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  snapshot.ctName!,
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
              ),
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
                        onChanged: (value) {
                          print(value);
                          // if value doesnt contain just close the dropDown
                          if (value == null) {
                            dropDownFocus.unfocus();
                          } else {
                            switch (value) {
                              case "Remove":
                                service.deleteClientType(
                                    context, snapshot.id.toString());
                                _pullRefresh();
                                break;
                              case "Edit":
                                dialogEditClientType(context);
                                setState(() {
                                  userId = snapshot.id;
                                  clientTypeName = snapshot.ctName;
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

  Future<dynamic> dialogEditClientType(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Client Type"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width20 * 2),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Dimensions.font16 / 2),
                        child: TextFormField(
                          controller: _clientTypeController,
                          decoration: InputDecoration(
                            labelText: "Client Type",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.font16 / 2),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ClientData clientData = ClientData(
                                id: userId,
                                ctName: _clientTypeController.text,
                              );
                              await service.updateClientType(clientData);
                              Navigator.pop(context);
                              _pullRefresh();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogAddNewClientType(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new client type"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width20 * 2),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Dimensions.font16 / 2),
                        child: TextFormField(
                          controller: _clientTypeController,
                          decoration: InputDecoration(
                            labelText: "Enter client type name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct client type name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.font16 / 2),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ClientData clientData = ClientData(
                                  id: userId,
                                  ctName: _clientTypeController.text);
                              await service.addClientType(clientData);
                              Navigator.pop(context);
                              _pullRefresh();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
