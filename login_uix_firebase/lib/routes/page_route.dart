import 'package:login_uix_firebase/pages/change_pw_page.dart';
import 'package:login_uix_firebase/pages/check_email_page.dart';
import 'package:login_uix_firebase/pages/dashboard_page.dart';
import 'package:login_uix_firebase/pages/delete_account_page.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';

import 'package:login_uix_firebase/pages/main_page.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';

class PageRoutes {
  static const dashboard = DashboardPage.routeName;
  // static const main = MainPage.routeName;

  static const changePw = changePasswordPage.routeName;
  static const checkEmail = CheckEmailView.routeName;
  static const forgotPw = ForgotPasswordPage.routeName;
  static const profile = ProfilePage.routeName;
  static const deleteAccount = DeleteAccount.routeName;
}
