// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocycart/consts/globalWidget/error_dialog.dart';
import 'package:grocycart/services/shared_preferences.dart';
import 'package:grocycart/widgets/app_routes.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key});
  bool isLoading = false;

  Future<void> _googleSignIn(context) async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    try {
      if (googleAccount != null) {
        // final GoogleSignInAuthentication googleAuth =
        //     await googleAccount.authentication;
        // final idToken = googleAuth.idToken;
        // final accessToken = googleAuth.accessToken;
        print('Google Sign-In successful: ${googleAccount.email}');
        await SharedPrefs().isUserLoggedIn(true);
        navigateToPushReplacement(context, AppRoutes.bottomBar);
      } else {
        showErrorDialog(context, 'Something Wrong');
      }
    } on FirebaseAuthException catch (error) {
      print('Error signing in with Google: $error');
      showErrorDialog(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: size.width * 0.6,
        decoration: BoxDecoration(
          // color: isDarkTheme ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            // color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        child: InkWell(
          onTap: () {
            print('Google Account verification Inititae');
            _googleSignIn(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/google_logo.png', // Google logo asset
                height: 24.0, // Logo height
                width: 24.0, // Logo width
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Sign in with Google',
                style: TextStyle(fontSize: 18.0), // Button text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
