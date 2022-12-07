import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/widgets/custom_text.dart';

import '../flutter_flow/flutter_flow_theme.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('pressed');
                  },
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu),
              color: Colors.black),
      backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
      automaticallyImplyLeading: true,
      title: Align(
        alignment: AlignmentDirectional(0.15, 0),
        child: SelectionArea(
            child: Text(
          'Welcome',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryText,
              ),
        )),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 8, 5),
          child: Image.asset(
            'assets/images/Signature-Logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ],
      centerTitle: false,
      elevation: 0,
    );
