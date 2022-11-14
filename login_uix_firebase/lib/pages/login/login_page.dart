// import 'package:flutter/material.dart';

// import 'loginWidget/login_desktop.dart';
// import 'loginWidget/login_mobile.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

  
//   bool showLoginPage = true;

//   void toggleScreens() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return const LoginMobile();
//           } else {
//             return  LoginDesktop(showRegisterPage: toggleScreens);
//           }
//         },
//       ),
//     );
//   }
// }
