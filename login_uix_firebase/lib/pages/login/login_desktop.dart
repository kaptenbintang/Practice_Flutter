import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/routing/routes.dart';

import '../../auth/controller_page.dart';
import '../../constant/controllers.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  bool _isChecked = false;
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

//   Future signIn() async {
// //loading circle
//     FirebaseAuth.instance.signOut();

//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: _emailController.text.trim(),
//               password: _passwordController.text.trim())
//           .then((value) => ControllerPage());
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       await showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text(e.message.toString()),
//             );
//           });
//     }
//     // Navigator.of(context).pop();
//   }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Image.asset(
                    'lib/images/mountain.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                //<-- Expanded widget
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 21),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome back',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Login to your account',
                          style: GoogleFonts.inter(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 35),
                        //email textfield
                        TextFormField(
                          controller: _emailController,
                          // onChanged: (text) => setState(() => _text),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'abc@example.com',
                              labelStyle: GoogleFonts.inter(
                                fontSize: 14,
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

                        const SizedBox(height: 20),
                        //password textfield

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '********',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 14,
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
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return "Enter correct password";
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: 25),
                        //remember me & forgot password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                    value: _isChecked,
                                    onChanged: onChanged,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Remember me',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 25),
                            Text(
                              'Forgot password?',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 0, 84, 152),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        //login button
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // signIn();

                            }
                            return;
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                          ),
                          child: Text(
                            'Login now',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a member?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigationController
                                    .navigateTo(sideMenuItems[4]);
                              },
                              child: Text(
                                " Register now!",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }

  void onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }
}

class HiddenPass extends StateNotifier<bool?> {
  HiddenPass() : super(false);
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

class LoginDesktop2 extends ConsumerWidget {
  const LoginDesktop2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //text controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isEmail(String input) => EmailValidator.validate(input);

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Image.asset(
                    'lib/images/mountain.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                //<-- Expanded widget
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 21),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome back',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Login to your account',
                          style: GoogleFonts.inter(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 35),
                        //email textfield
                        TextFormField(
                          controller: emailController,
                          // onChanged: (text) => setState(() => _text),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'abc@example.com',
                              labelStyle: GoogleFonts.inter(
                                fontSize: 14,
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

                        const SizedBox(height: 20),
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
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 14,
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
                                          ? Icons.visibility
                                          : Icons.visibility_off);
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

                        const SizedBox(height: 25),
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
                                    final remember =
                                        ref.watch(rememberProvider)!;
                                    return SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: remember,
                                        onChanged: (_) {
                                          // ref
                                          //         .read(
                                          //             rememberProvider.notifier)
                                          //         .state ==
                                          //     _;
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Remember me',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 25),
                            Text(
                              'Forgot password?',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 0, 84, 152),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        //login button
                        TextButton(
                          onPressed: (() async {
                            // if (formKey.currentState!.validate()) {
                            await ref
                                .read(authStateProvider.notifier)
                                .loginWithEmailPassword(emailController.text,
                                    passwordController.text, context);
                            // result.log();
                            // }
                          }),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                          ),
                          child: Text(
                            'Login now',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a member?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigationController
                                    .navigateTo(sideMenuItems[4]);
                              },
                              child: Text(
                                " Register now!",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
