// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_icon_button.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:login_uix_firebase/provider/profile_provider/edit_user_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';
import '../../constant/storage_path.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';

class EditProfileDesktopWidget2 extends ConsumerWidget {
  const EditProfileDesktopWidget2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    DataService service = DataService();
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final nameController = TextEditingController();
    final lastsNameController = TextEditingController();
    final dateofbirthController = TextEditingController();
    final phonenumberController = TextEditingController();
    String? profilePic;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
              Navigator.pop(context);
            },
          ),
        ),

        title: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
          child: Text(
            'Edit Profile',
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
          child: Consumer(
            builder: (context, ref, child) {
              final userUid = ref.watch(userIdProvider)!;
              final userInfoModel = ref.watch(
                userInfoModelProvider(userUid),
              );
              return userInfoModel.when(
                data: (data) {
                  nameController.text = data.firstName;
                  lastsNameController.text = data.lastName;
                  phonenumberController.text = data.phoneNumber ?? '';
                  dateofbirthController.text = data.dateofbirth ?? '';

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //photo
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, screenWidth / (width / 20), 0, 0),
                        child: Container(
                          width: screenWidth / (width / 100),
                          height: screenWidth / (width / 100),
                          decoration: BoxDecoration(
                            color: Color(0xFFDBE2E7),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 2),
                                screenWidth / (width / 2),
                                screenWidth / (width / 2),
                                screenWidth / (width / 2)),
                            child: Container(
                              width: screenWidth / (width / 90),
                              height: screenWidth / (width / 90),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 12)),
                                child: (data.profilePic.toString() == '')
                                    ? Icon(Icons.person)
                                    : Image.network(
                                        data.profilePic!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //change photo button
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 12),
                            0,
                            screenWidth / (width / 16)),
                        child: FFButtonWidget(
                          onPressed: () async {
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
                                Uint8List? uploadfile =
                                    result.files.single.bytes;

                                String filename = result.files.single.name;

                                Reference storageRef = FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        StoragePath.userProfilePic + filename);

                                final UploadTask uploadTask =
                                    storageRef.putData(uploadfile!);

                                final TaskSnapshot downloadUrl =
                                    await uploadTask;

                                profilePic =
                                    (await downloadUrl.ref.getDownloadURL());
                                print(profilePic);
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          text: 'Change Photo',
                          options: FFButtonOptions(
                            width: screenWidth / (width / 130),
                            height: screenWidth / (width / 40),
                            color: Color(0xFFF1F4F8),
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF4B39EF),
                                      fontSize: screenWidth / (width / 14),
                                      fontWeight: FontWeight.normal,
                                    ),
                            elevation: 1,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      //firstname
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            0,
                            screenWidth / (width / 20),
                            screenWidth / (width / 16)),
                        child: SizedBox(
                          width: screenWidth / (width / 500),
                          height: screenWidth / (width / 80),
                          child: TextFormField(
                            controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF95A1AC),
                                    fontSize: screenWidth / (width / 14),
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF95A1AC),
                                    fontSize: screenWidth / (width / 14),
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 24),
                                  0,
                                  screenWidth / (width / 24)),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: screenWidth / (width / 14),
                                      fontWeight: FontWeight.normal,
                                    ),
                            maxLines: null,
                          ),
                        ),
                      ),
                      //lastname
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            0,
                            screenWidth / (width / 20),
                            screenWidth / (width / 16)),
                        child: SizedBox(
                          width: screenWidth / (width / 500),
                          height: screenWidth / (width / 80),
                          child: TextFormField(
                            controller: lastsNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 24),
                                  0,
                                  screenWidth / (width / 24)),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenWidth / (width / 14)),
                            textAlign: TextAlign.start,
                            maxLines: null,
                          ),
                        ),
                      ),
                      //phone number
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            0,
                            screenWidth / (width / 20),
                            screenWidth / (width / 16)),
                        child: SizedBox(
                          width: screenWidth / (width / 500),
                          height: screenWidth / (width / 80),
                          child: IntlPhoneField(
                            pickerDialogStyle: PickerDialogStyle(
                              width: screenWidth / (width / 400),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11)
                            ],
                            controller: phonenumberController,
                            showCountryFlag: false,
                            showDropdownIcon: true,
                            initialCountryCode: 'MY',
                            disableLengthCheck: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 24),
                                  0,
                                  screenWidth / (width / 24)),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenWidth / (width / 14)),
                            textAlign: TextAlign.start,
                            validator: (value) {
                              if (value!.toString().isEmpty) {
                                return "Enter correct phone number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      //date of birth
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            0,
                            screenWidth / (width / 20),
                            screenWidth / (width / 16)),
                        child: SizedBox(
                          width: screenWidth / (width / 500),
                          height: screenWidth / (width / 80),
                          child: TextFormField(
                            controller: dateofbirthController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.normal,
                                      fontSize: screenWidth / (width / 14)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 8)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 24),
                                  0,
                                  screenWidth / (width / 24)),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenWidth / (width / 14)),
                            textAlign: TextAlign.start,
                            maxLines: null,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      1950), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                dateofbirthController.text =
                                    formattedDate; //set output date to TextField value.
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ),
                      //submit button/ save change
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, screenWidth / (width / 24), 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await service.deleteUserImage(data);
                            UserData userData = UserData(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              firstName: nameController.text,
                              lastName: lastsNameController.text,
                              doBirth: dateofbirthController.text,
                              phoneNumber: phonenumberController.text,
                              profilePic: profilePic,
                            );
                            await ref
                                .read(editUserProvider.notifier)
                                .editUser(userData: userData)
                                .then((value) =>
                                    ref.refresh(userDetailProvider.future));
                          },
                          text: 'Save Changes',
                          options: FFButtonOptions(
                            width: screenWidth / (width / 340),
                            height: screenWidth / (width / 60),
                            color: Color(0xFF4B39EF),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: screenWidth / (width / 16),
                                      fontWeight: FontWeight.normal,
                                    ),
                            elevation: 2,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
