import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/routing/routes.dart';

import '../../constant/controllers.dart';

import 'dart:developer' as devtools show log;

import '../../flutter_flow/flutter_flow_theme.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class HiddenPass extends StateNotifier<bool?> {
  HiddenPass() : super(true);
  void change() => state = state == false ? true : false;
}

class RememberNotifier extends StateNotifier<bool?> {
  RememberNotifier() : super(false);
}

final hiddenPassProvider = StateNotifierProvider<HiddenPass, bool?>((ref) {
  return HiddenPass();
});

final rememberProvider = StateNotifierProvider<RememberNotifier, bool?>((ref) {
  return RememberNotifier();
});

class LoginDesktop2 extends ConsumerStatefulWidget {
  const LoginDesktop2({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginDesktop2state();
  // @override
  // _blackOutPageState createState() => _blackOutPageState();
}

class LoginDesktop2state extends ConsumerState {
  // LoginDesktop2({super.key});

  bool isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Box box1;

  @override
  void initState() {
    createOpenBox();
  }

  void createOpenBox() async {
    box1 = await Hive.openBox('logindata');
    getdataEmailPassChecked();
  }

  void getdataEmailPassChecked() async {
    if (box1.get('email') != null) {
      emailController.text = box1.get('email');
      isChecked = true;
      setState(() {});
    }
    if (box1.get('pass') != null) {
      passwordController.text = box1.get('pass');
      isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //text controllers
    final formKey = GlobalKey<FormState>();
    bool isEmail(String input) => EmailValidator.validate(input);
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = 1920;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(_width / (maxWidth / 30)),
        child: Row(
          children: [
            //Image
            Expanded(
              child: Image.asset(
                'lib/images/mountain.png',
                fit: BoxFit.fill,
              ),
            ),
            //TextField
            Expanded(
              //<-- Expanded widget
              child: Container(
                constraints: BoxConstraints(maxWidth: _width / (maxWidth / 21)),
                padding:
                    EdgeInsets.symmetric(horizontal: _width / (maxWidth / 50)),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome back',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: _width / (maxWidth / 17),
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(height: _width / (maxWidth / 8)),
                      Text(
                        'Login to your account',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: _width / (maxWidth / 23),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(height: _width / (maxWidth / 35)),
                      //email textfield
                      TextFormField(
                        controller: emailController,
                        // onChanged: (text) => setState(() => _text),
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'abc@example.com',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 14),
                                      color: Colors.black,
                                    ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            // hintText: 'Email',
                            fillColor: Colors.grey[200],
                            filled: true),
                        validator: (value) {
                          if (value!.isEmpty || !isEmail(value)) {
                            return "Enter correct email";
                          } else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(height: _width / (maxWidth / 20)),
                      //password textfield

                      Consumer(
                        builder: (context, ref, child) {
                          final hidden = ref.watch(hiddenPassProvider)!;
                          return TextFormField(
                            controller: passwordController,
                            obscureText: hidden,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: '********',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 14),
                                    color: Colors.black,
                                  ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              // hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffix: InkWell(
                                onTap: ref
                                    .read(hiddenPassProvider.notifier)
                                    .change,
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return Icon(hidden
                                        ? Icons.visibility_off
                                        : Icons.visibility);
                                  },
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return "Enter correct password";
                              } else {
                                return null;
                              }
                            },
                          );
                        },
                      ),

                      SizedBox(height: _width / (maxWidth / 25)),
                      //remember me & forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  // final remember = ref.watch(rememberProvider)!;
                                  return SizedBox(
                                    height: _width / (maxWidth / 24),
                                    width: _width / (maxWidth / 24),
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        isChecked = !isChecked;
                                        setState(() {});
                                      },
                                      side: BorderSide(
                                          color: Colors.grey, width: 1.5),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: _width / (maxWidth / 8)),
                              Text(
                                'Remember me',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 14),
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(width: _width / (maxWidth / 25)),
                          InkWell(
                            onTap: () {
                              navigationController
                                  .navigateTo(ForgotPassworRoute);
                            },
                            // onTap: () {
                            //   navigationController.navigationKey.currentState!
                            //       .pushNamed(RouteName.ForgotPasswordPage);
                            // },
                            child: Text(
                              'Forgot password?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 14),
                                    color:
                                        const Color.fromARGB(255, 0, 84, 152),
                                  ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: _width / (maxWidth / 30)),
                      //login button
                      TextButton(
                        onPressed: (() async {
                          navigationController.navigateTo(sideMenuItems[0]);
                          // if (formKey.currentState!.validate()) {
                          await ref
                              .read(authStateProvider.notifier)
                              .loginWithEmailPassword(emailController.text,
                                  passwordController.text, context);
                          // result.log();
                          // }
                          if (isChecked == true) {
                            loginRememberMe();
                          } else {
                            Hive.box('logindata').clear();
                          }
                        }),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            vertical: _width / (maxWidth / 20),
                            horizontal: _width / (maxWidth / 10),
                          ),
                        ),
                        child: Text(
                          'Login now',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 15),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      SizedBox(height: _width / (maxWidth / 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / (maxWidth / 15),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigationController.navigateTo(sideMenuItems[4]);
                              menuController
                                  .changeActiveitemTo(sideMenuItems[4]);
                            },
                            child: Text(
                              " Register now!",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: _width / (maxWidth / 15),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginRememberMe() {
    if (isChecked) {
      box1.put('email', emailController.value.text);
      box1.put('pass', passwordController.value.text);
    }
  }
}
