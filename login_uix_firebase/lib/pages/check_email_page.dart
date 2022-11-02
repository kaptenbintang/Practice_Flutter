import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';
import 'dart:html' as html;
import '../main.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      size: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Check your mail',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          'We have sent password recovery instructions to your email.',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 200,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ElevatedButton(
                      onPressed: () {
                        const url = 'https://gmail.com';
                        html.window.open(url, "_blank");
                      },
                      child: Text(
                        'Open email app',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: () {
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    'Skip, I\'ll confirm later',
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Did not receive the email? Check your spam filter,'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('or'),
                    TextButton(
                      onPressed: () {
                        Util.routeToWidget(context, ForgotPasswordPage());
                      },
                      child: Text('try another email address'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
