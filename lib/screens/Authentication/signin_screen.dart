import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/authentication_consts.dart';
import 'package:grocycart/consts/globalWidget/error_dialog.dart';
import 'package:grocycart/consts/globalWidget/toast.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/screens/Authentication/forget_password_screen.dart';
import 'package:grocycart/screens/Authentication/singup_screen.dart';
import 'package:grocycart/services/shared_preferences.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import 'package:grocycart/widgets/app_routes.dart';

import 'authenticationWidgets/google_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameText = TextEditingController();
  final _passwordText = TextEditingController();
  final _focus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obsecure = true;

  void submitOnlineForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print(
        'Sign In With : \n Email  : ${_usernameText.text} , Password : ${_passwordText.text}',
      );
      try {
        await authInstance.signInWithEmailAndPassword(
          email: _usernameText.text,
          password: _passwordText.text,
        );
        showToast(context, 'Login Successful');
        print(
            'Before submit form : ${_usernameText.text} , Password : ${_passwordText.text}');
        await SharedPrefs().isUserLoggedIn(true);
        // showToast(context, 'Logging in successfully');
        navigateToPushReplacement(context, AppRoutes.bottomBar);
        print('Form is valid');
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException : ${e.message}');
        // Display a generic error message to the user
        showErrorDialog(context, 'Invalid email or password');
      } catch (e) {
        // showErrorDialog(context, e.toString());
      }
    }
  }

  @override
  void dispose() {
    _usernameText.dispose();
    _passwordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = ref.read(themeProvider);
    Color isDark = isDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(isDarkTheme
                        ? 'assets/icons/dark_background.png'
                        : 'assets/icons/light_background.jpeg'),
                    fit: BoxFit.fill)),
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.15,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/app_logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextWidget(
                  content: 'Welcome Back',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const TextWidget(
                  content: 'Login to continue',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameText,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_focus),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          iconColor: Theme.of(context).secondaryHeaderColor,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          filled: true,
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: isDark),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passwordText,
                        maxLines: 1,
                        obscureText: _obsecure,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          print(
                            'Current Email and Password : \n Email  : ${_usernameText.text} , Password : ${_passwordText.text}',
                          );
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return 'Please enter valid password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obsecure = !_obsecure;
                              });
                            },
                            icon: _obsecure
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          iconColor: Theme.of(context).secondaryHeaderColor,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          filled: true,
                          hintText: 'Enter password',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: isDark),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              navigateToPusNamed(
                                  context, SignUpScreen.routeName);
                              //
                              //
                              // Here we are creating a funciton to send a password refeator authenticationb
                              //
                              //
                            },
                            child: const TextWidget(
                              content: 'Create New Account',
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.end,
                              color: Colors.red,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateToPusNamed(
                                  context, ForgotPasswordScreen.routeName);
                            },
                            child: TextWidget(
                              content: 'Forgot Password ?',
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.end,
                              color: isDarkTheme ? Colors.white : Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: 50,
                        width: size.width * 0.6,
                        child: TextButton(
                          onPressed: () {
                            submitOnlineForm();
                          },
                          child: const TextWidget(
                            content: 'Sign In',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GoogleButton(),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: isDarkTheme ? Colors.white : Colors.black,
                          )),
                          const TextWidget(
                            content: '  OR  ',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          Expanded(
                              child: Divider(
                            color: isDarkTheme ? Colors.white : Colors.black,
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    isDarkTheme ? Colors.white : Colors.black),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        height: 50,
                        width: size.width * 0.6,
                        child: TextButton(
                          onPressed: () {},
                          child: const TextWidget(
                            content: 'Continue as guest',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
