import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/services/auth/auth_controller.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import 'package:grocycart/widgets/app_routes.dart';
import '../../consts/authentication_consts.dart';
import '../../consts/globalWidget/error_dialog.dart';
import '../../widgets/const_widgets.dart';
import '../../widgets/spinkit_indicator.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = '/signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _usernameText = TextEditingController();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final _confirmPasswordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _obscurePassword = true;
  var _obscureConfirmPassword = true;
  bool isLoading = false;

  void submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      isLoading = true;
      _formKey.currentState!.save();
      print('Password entered: ${_passwordText.text}'); // Add this line
      try {
        await authInstance.createUserWithEmailAndPassword(
          email: _emailText.text,
          password: _passwordText.text,
        );
        print(
          'Registration successful : \n Email : ${_usernameText.text} \n Password : ${_passwordText.text}',
        );
        setState(() {
          isLoading = false;
        });
        //
        //
        // Firebase Storage data input starts
        //
        //
        final uploadData = ref.read(authController);
        uploadData.signUpWithEmail(
          context: context,
          email: _emailText.text,
          fullName: _usernameText.text,
          profilePicURL: '',
          addressList: [],
        );
        print('Upload Data => : $uploadData  :');
        //
        //
        //
        // Firebase Storage Data input ends here
        //
        //
        navigateToPushReplacement(context, AppRoutes.bottomBar);
      } on FirebaseException catch (err) {
        if (mounted) {
          showErrorDialog(context, err.message.toString());
        }
        isLoading = false;
      } catch (error) {
        if (mounted) {
          showSnackBar(context, error.toString());
        }
        isLoading = false;
      }
      // Perform sign-up action
    }
  }

  @override
  void dispose() {
    _usernameText.dispose();
    _emailText.dispose();
    _passwordText.dispose();
    _confirmPasswordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = ref.read(themeProvider);
    Color isDark = isDarkTheme ? Colors.white : const Color.fromARGB(255, 23, 22, 22);
    return Scaffold(
      body: Stack(
        children: [
          //
          //
          // First Container
          //
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  isDarkTheme
                      ? 'assets/icons/dark_background.png'
                      : 'assets/icons/light_background.jpeg',
                ),
                fit: BoxFit.fill,
              ),
            ),
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
                const SizedBox(height: 15),
                const TextWidget(
                  content: 'Create an Account',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const TextWidget(
                  content: 'Sign up to get started',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameText,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: isDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _emailText,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: isDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordText,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: isDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordText,
                        obscureText: _obscureConfirmPassword,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty || value != _passwordText.text) {
                            print('Current Value : $value');
                            print('password Value : ${_passwordText.text}');
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            icon: _obscureConfirmPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: isDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                          onPressed: submitForm,
                          child: const TextWidget(
                            content: 'Sign Up',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      content: 'Already have an Account ? ',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToPusNamed(context, AppRoutes.loginScreen);
                      },
                      child: const TextWidget(
                        content: 'Sign In',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          //
          //
          // On Loading spinkitProgressiveIndicator indicator
          //
          //
          Center(
            child: isLoading ? spinkitProgressiveIndicator(context) : null,
          ),
        ],
      ),
    );
  }
}
