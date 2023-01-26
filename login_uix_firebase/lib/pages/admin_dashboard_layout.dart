// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/widgets/large_adminDashboard.dart';
import 'package:login_uix_firebase/widgets/medium_adminDashboard.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin.dart';
import 'package:login_uix_firebase/widgets/small_adminDashboard.dart';

import '../auth/provider/user_id_provider.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../user_info/providers/user_info_model_provider.dart';
import '../widgets/animations/error_animation_view.dart';
import '../widgets/animations/loading_animation_view.dart';
import '../widgets/top_nav.dart';

class AdminDashboardLayout extends ConsumerWidget {
  AdminDashboardLayout({super.key});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    final userUid = ref.watch(userIdProvider);
    final userInfoModel = ref.watch(
      userInfoModelProvider(userUid.toString()),
    );
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: (!ResponsiveWidget.isLargeScreen(context))
          ? topNavigationBar(context, _scaffoldKey)
          : null,
      drawer: Container(
        width: _width / (maxWidth / 200),
        child: Drawer(
          elevation: 16,
          child: SideBarAdmin(),
        ),
      ),
      body: userInfoModel.when(
        data: (data) {
          String userRole = data.roles;
          return SafeArea(
            child: ResponsiveWidget(
              largeScreen: LargeAdminDashboard(
                roles: userRole,
              ),
              mediumScreen: MediumAdminDashboard(roles: userRole),
              smallScreen: SmallAdminDashboard(roles: userRole),
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
