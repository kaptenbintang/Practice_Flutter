import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/controllers/navigation_controller.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_loading_animation_view.dart';
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
    leading: !ResponsiveWidget.isLargeScreen(context)
        ? IconButton(
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: _width / (_maxWidth / 20),
            ),
            color: Colors.black)
        : null
    // IconButton(
    //     onPressed: () {
    //       NavigationController.instance.goBack();
    //     },
    //     icon: Icon(
    //       Icons.arrow_back_outlined,
    //       size: _width / (_maxWidth / 20),
    //     ),
    //     color: Colors.black)

    ,
    backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
    automaticallyImplyLeading: true,
    title: Consumer(builder: (context, ref, child) {
      final uid = ref.watch(userIdProvider);
      final userData = ref.watch(
        userInfoModelProvider(uid.toString()),
      );
      final model = userData.value;
      if (userData.hasValue) {
        return userData.when(
          data: (data) {
            return Text(
              'Welcome' + ' ' + (data['firstName'] ?? ''),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: _width / (_maxWidth / 20),
                  ),
            );
          },
          loading: () {
            return const SmallLoadingAnimationView();
          },
          error: (Object error, StackTrace stackTrace) {
            return const SmallErrorAnimationView();
          },
        );
      } else {
        return Text(
          'Welcome',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: _width / (_maxWidth / 20),
              ),
        );
      }
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
