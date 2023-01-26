// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_field, sized_box_for_whitespace, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_final_fields

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/database_service.dart';
import '../../model/roles_data.dart';

class ManageRolesMobile extends StatefulWidget {
  const ManageRolesMobile({super.key});

  @override
  State<ManageRolesMobile> createState() => _ManageRolesMobileState();
}

class _ManageRolesMobileState extends State<ManageRolesMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<RolesData>>? RolesList;
  Map<String, dynamic>? currentRolesData;
  List<RolesData>? retrievedRolesList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  RolesData? dataU;
  final FocusNode dropDownFocus = FocusNode();

  final _rolesNameController = TextEditingController();

  String? userId;
  String? _isRoles;

  String? selectedValueRoles;
  String? selectedValue;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  bool? _isWrite;
  bool? _isWriteAll;
  bool? _isRead;
  bool? _isDelete;

  List<bool>? selected;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    RolesList = service.retrieveRoles();
    retrievedRolesList = await service.retrieveRoles();
    selected =
        List<bool>.generate(retrievedRolesList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedRolesList = await service.retrieveRoles();

    setState(() {
      RolesList = service.retrieveRoles();
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
              //Title and Subtitle
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
                                Dimensions.width16, 0, 0, Dimensions.height05),
                            child: Text(
                              'Roles Accessibilty',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                          //Search textfield,search icon and add Button
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, Dimensions.height05, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Search Textfield and search icon
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
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15 /
                                                            3),
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
                                //Add Button
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: Dimensions.radius30,
                                  borderWidth: 1,
                                  buttonSize: Dimensions.font20 * 2,
                                  icon: Icon(
                                    Icons.playlist_add,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    size: Dimensions.font20,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                    dialogAddNewRoles(context);
                                  },
                                ),
                              ],
                            ),
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
                                          Dimensions.width10, 0, 0, 0),
                                      child: Text(
                                        'Roles',
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
                            child: FutureBuilder(
                                future: RolesList,
                                builder: (context,
                                    AsyncSnapshot<List<RolesData>> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: retrievedRolesList!.length,
                                      itemBuilder: (context, indexs) {
                                        return _buildTableUser(
                                            context,
                                            retrievedRolesList![indexs],
                                            retrievedRolesList,
                                            indexs);
                                      },
                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      retrievedRolesList!.isEmpty) {
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

  _buildTableUser(BuildContext context, RolesData snapshot,
      List<RolesData>? user, int indexs) {
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
              //Roles Type Name
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  snapshot.rolesName as String,
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
              ),
              //Dropdown Button
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusNode: dropDownFocus,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(30),
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
                                service.deleteRoles(
                                    context, snapshot.id.toString());
                                _pullRefresh();
                                break;
                              case "Edit":
                                dialogEditRoles(context);
                                setState(() {
                                  userId = snapshot.id;
                                  _isRoles = snapshot.rolesName;
                                  _isWrite = snapshot.canWrite;
                                  _isWriteAll = snapshot.canWriteAll;
                                  _isRead = snapshot.canRead;
                                  _isDelete = snapshot.canDelete;
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

  Future<dynamic> dialogEditRoles(BuildContext context) {
    List<bool> listOfValue = [true, false];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Roles Data"),
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
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWrite,
                            decoration: InputDecoration(
                              labelText: "Can Write?",
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _isWrite = value!;
                              });
                            },
                            items: listOfValue.map((bool val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: _isWriteAll,
                            decoration: InputDecoration(
                              labelText: "Can Write All?",
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _isWriteAll = value!;
                              });
                            },
                            items: listOfValue.map((bool val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _isRead,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.manage_search,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isRead = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _isDelete,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isDelete = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              RolesData rolesData = RolesData(
                                  id: userId,
                                  rolesName: _isRoles,
                                  canWrite: _isWrite,
                                  canWriteAll: _isWriteAll,
                                  canRead: _isRead,
                                  canDelete: _isDelete);
                              await service.updateRoles(rolesData);
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

  Future<dynamic> dialogAddNewRoles(BuildContext context) {
    bool? _selectedValue;
    List<bool> listOfValue = [true, false];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new roles"),
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
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: TextFormField(
                          controller: _rolesNameController,
                          decoration: InputDecoration(
                            labelText: "Enter roles name",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter correct roles name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Write?",
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isWrite = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Write All?",
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isWriteAll = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Read?",
                          ),
                          icon: Icon(
                            Icons.manage_search,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isRead = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                            labelText: "Can Delete?",
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _isDelete = value!;
                            });
                          },
                          onSaved: (value) {},
                          items: listOfValue.map((bool val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height08),
                        child: ElevatedButton(
                          child: Text("Submit"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              RolesData rolesData = RolesData(
                                  id: userId,
                                  rolesName: _rolesNameController.text,
                                  canWrite: _isWrite,
                                  canWriteAll: _isWriteAll,
                                  canRead: _isRead,
                                  canDelete: _isDelete);
                              await service.addRoles(rolesData);
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
