import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  // Use ScaffoldMessenger to show the Snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      // action: SnackBarAction(
      //   label: 'UNDO',
      //   onPressed: () {
      //     // Handle the action when the user presses UNDO
      //     // This is optional and can be used to perform an action when the user clicks UNDO
      //   },
      // ),
    ),
  );
}

