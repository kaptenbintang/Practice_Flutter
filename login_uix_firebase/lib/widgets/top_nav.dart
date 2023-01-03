import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/widgets/custom_text.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../provider/profile_provider/user_profile_provider.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  double _width = MediaQuery.of(context).size.width;
  double _maxWidth = ResponsiveWidget.isphoneScreen(context)
      ? 414
      : ResponsiveWidget.isSmallScreen(context)
          ? 912
          : ResponsiveWidget.isLargeScreen(context)
              ? 1920
              : 1280;
  return AppBar(
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Icon(
            Icons.menu,
            size: _width / (_maxWidth / 25),
            color: Colors.black,
          )
        : IconButton(
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: _width / (_maxWidth / 20),
            ),
            color: Colors.black),
    backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
    automaticallyImplyLeading: true,
    title: Consumer(builder: (context, ref, child) {
      final userData = ref.watch(
        userDetailProvider,
      );
      final model = userData.value;
      return Text(
        'Welcome' + ' ' + (model?['firstName'] ?? ''),
        textAlign: TextAlign.center,
        style: FlutterFlowTheme.of(context).title3.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: _width / (_maxWidth / 20),
            ),
      );
    }),
    actions: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            0, _width / (_maxWidth / 5), 8, _width / (_maxWidth / 5)),
        child: Image.asset(
          'assets/images/Signature-Logo.png',
          width: _width / (_maxWidth / 100),
          height: _width / (_maxWidth / 100),
          fit: BoxFit.contain,
        ),
      ),
    ],
    centerTitle: true,
    elevation: ResponsiveWidget.isphoneScreen(context) ? 3 : 0,
    toolbarHeight: _width / (_maxWidth / 70),
  );
}
