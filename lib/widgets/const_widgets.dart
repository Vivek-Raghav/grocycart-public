import 'package:flutter/material.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 500),
    content: TextWidget(
      content: message,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Theme.of(context)
        .secondaryHeaderColor, // Use primary color from the current theme
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
