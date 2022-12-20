import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';
import 'package:login_uix_firebase/routing/routes.dart';

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

class LoginMobileRiverpod extends ConsumerWidget {
  const LoginMobileRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //text controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isEmail(String input) => EmailValidator.validate(input);

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height30),
            child: Center(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome back',
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.font17,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height08),
                      Text(
                        'Login to your account',
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.font23,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                          height: Dimensions.height30 + Dimensions.height05),

                      //email textfield
                      TextFormField(
                        controller: emailController,
                        // onChanged: (text) => setState(() => _text),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: Dimensions.height10,
                                bottom: Dimensions.height10),
                            labelText: "Email address",
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.blue,
                              size: Dimensions.iconSize24,
                            ),
                            // errorText: _errorEmailText,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius12)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius12)),
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
                      SizedBox(height: Dimensions.height20),
                      //password textfield
                      Consumer(
                        builder: (context, ref, child) {
                          final hidden = ref.watch(hiddenPassProvider)!;
                          return TextFormField(
                            controller: passwordController,
                            // onChanged: (text) => setState(() => _text),
                            obscureText: hidden,
                            decoration: InputDecoration(
                              labelText: "Password",
                              contentPadding: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  bottom: Dimensions.height10),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.blue,
                                size: Dimensions.iconSize24,
                              ),
                              // errorText: _errorPasswordText,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12)),
                              // hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffix: InkWell(
                                onTap: ref
                                    .read(hiddenPassProvider.notifier)
                                    .change,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.width08,
                                      top: Dimensions.height20 / 10),
                                  child: Icon(
                                    hidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: Dimensions.iconSize24,
                                  ),
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
                      SizedBox(
                          height: Dimensions.height20 + Dimensions.height05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final remember = ref.watch(rememberProvider)!;
                                  return SizedBox(
                                    height: Dimensions.height24,
                                    width: Dimensions.width24,
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
                              SizedBox(width: Dimensions.width08),
                              Text(
                                'Remember me',
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              width:
                                  Dimensions.width20 + Dimensions.width10 / 2),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.font14,
                                color: const Color.fromARGB(255, 0, 84, 152),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height30),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(authStateProvider.notifier)
                                .loginWithEmailPassword(emailController.text,
                                    passwordController.text, context);
                          }
                          return;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height20,
                            horizontal: Dimensions.width10,
                          ),
                        ),
                        child: Text(
                          'Login now',
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.font15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                          height: Dimensions.height20 + Dimensions.height05),
                      //not a member? registernow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigationController.navigateTo(sideMenuItems[4]);
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
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
