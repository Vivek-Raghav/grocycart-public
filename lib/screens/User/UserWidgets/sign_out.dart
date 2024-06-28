import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocycart/consts/authentication_consts.dart';
import 'package:grocycart/screens/Authentication/signin_screen.dart';
import 'package:grocycart/services/shared_preferences.dart';
import 'package:grocycart/widgets/app_routes.dart';

void showSignOutDialog(BuildContext context, bool isDarkTheme) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        title: Text(
          'Sign Out',
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'No',
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              navigateToPusNamed(context, LoginScreen.routeName);
              await SharedPrefs().isUserLoggedIn(false);
              authInstance.signOut();
              GoogleSignIn().signOut();
              navigateToPushReplacement(context, AppRoutes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
            ),
            child: Text(
              'Yes',
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      );
    },
  );
}
