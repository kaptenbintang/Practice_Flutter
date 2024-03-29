// ignore_for_file: depend_on_referenced_packages, preferructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/controllers/side_bar_admin_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:login_uix_firebase/auth/provider/is_logged_in_provider.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/pages/MainPages/main_page_pages.dart';
import 'package:login_uix_firebase/pages/admin_dashboard_layout.dart';

import 'package:login_uix_firebase/pages/add_user_page.dart';

import 'package:login_uix_firebase/pages/appointment_page_riverpod_ver2.dart';
import 'package:login_uix_firebase/pages/change_pw_page.dart';
import 'package:login_uix_firebase/pages/check_email_page.dart';

import 'package:login_uix_firebase/pages/delete_account_page.dart';
import 'package:login_uix_firebase/pages/detailPractionerPage/detail_practioner_page.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_page.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';

import 'package:login_uix_firebase/pages/historybookingpage/historybooking_riverpod.dart';
import 'package:login_uix_firebase/pages/landing_layout.dart';
import 'package:login_uix_firebase/pages/login/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:login_uix_firebase/pages/registerPage/register_page.dart';
import 'package:login_uix_firebase/pages/schedulePage/blackoutDatePage.dart';
import 'package:login_uix_firebase/pages/schedulePage/mainSchedulePage.dart';
import 'package:login_uix_firebase/pages/schedulePage/specialDatePage.dart';
import 'package:login_uix_firebase/pages/schedulePage/timeSchedulePage.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_desktop_riverpod.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_page.dart';
import 'package:login_uix_firebase/provider/loading_provider/is_loading_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/widgets/loading/loading_screen.dart';
import 'controllers/menu_controller.dart' as r;
import 'controllers/navigation_controller.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/LandingPage/landing_page.dart';

void main() async {
  Get.put(r.MenuController());
  Get.put(NavigationController());
  Get.put(SideBarAdminController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  initializeDateFormatting().then((_) => runApp(ProviderScope(child: MyApp())));
}

final navigatorKey = GlobalKey<NavigatorState>();

class Util {
  static void routeToWidget(context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Consumer(
          builder: (context, ref, child) {
            ref.listen<bool>(
              isLoadingProvider,
              (_, isLoading) {
                if (isLoading) {
                  LoadingScreen.instance().show(
                    context: context,
                  );
                } else {
                  LoadingScreen.instance().hide();
                }
              },
            );

            final isLoggedin = ref.watch(isLoggedInProvider);

            if (isLoggedin) {
              final userRoles = ref.watch(
                userDetailProvider,
              );
              return userRoles.when(
                data: (data) {
                  if (data?['roles'] != 'user') {
                    return AdminDashboardLayout();
                  } else {
                    return MainPagesPage();
                  }
                },
                error: (error, stackTrace) {
                  return Text('$error');
                },
                loading: () {
                  return Container();
                },
              );
            } else {
              return LandingLayout();
            }
          },
        ),
        routes: {
          DeleteAccount.routeName: (context) => DeleteAccount(),
          CheckEmailView.routeName: (context) => CheckEmailView(),
          ProfileRiverpodPage2.routeName: (context) => ProfileRiverpodPage2(),
          DetailPagePractioner.routeName: (context) => DetailPagePractioner(
              practioner:
                  ModalRoute.of(context)?.settings.arguments as Practioner),
          AppointmentPageRiverpodVersion2.routeName: (context) =>
              AppointmentPageRiverpodVersion2(
                  practioner:
                      ModalRoute.of(context)?.settings.arguments as Practioner),
          RouteName.changePWPage: (context) => changePWPage(),
          RouteName.checkEmailPage: (context) => CheckEmailView(),
          RouteName.loginPage: (context) => LoginPage(),
          RouteName.registerPage: (context) => RegisterPage(),
          RouteName.landingPage: (context) => LandingPage(),
          RouteName.editProfilePage: (context) => EditProfilePage(),
          RouteName.viewProfilePage: (context) => ViewProfilePage(),
          RouteName.historyBookingRiverpod: (context) =>
              HistoryBookingRiverpod(),
          RouteName.MainPagesPage: (context) => MainPagesPage(),
          RouteName.mainSchedulePage: (context) => mainSchedulePage(),
          RouteName.timeSchedulePage: (context) => timeSchedulePage(),
          RouteName.specialDatePage: (context) => specialDatePage(),
          RouteName.blackOutPage: (context) => blackOutPage(),
          RouteName.ForgotPasswordPage: (context) => ForgotPasswordPage(),
          AddUserPage.routeName: (context) => AddUserPage(),
        });
  }
}
