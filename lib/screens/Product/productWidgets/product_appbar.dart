import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

AppBar appbarProductScreen(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Theme.of(context).secondaryHeaderColor,
    title: const Text(
      'Details',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          IconlyLight.bag,
        ),
      ),
    ],
  );
}
