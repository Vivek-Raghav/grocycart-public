import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../widgets/app_routes.dart';

AppBar appbarHomeScreen(BuildContext context) {
  return AppBar(
    // title: SizedBox(
    //   width: 60,
    //   child: Image.asset(
    //     'assets/app_logo.png',
    //     fit: BoxFit.cover,
    //   ),
    // ),
    elevation: 0,
    // backgroundColor: isDarkTheme
    //     ? Color.fromARGB(255, 243, 235, 235)
    //     : Color.fromARGB(255, 243, 235, 235),
    backgroundColor: Theme.of(context).secondaryHeaderColor,
    leading: CircleAvatar(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      radius: 10,
      child: SizedBox(
        height: 30,
        width: 30,
        child: Image.asset(
          'assets/home/home_category.png',
          fit: BoxFit.fill,
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          navigateToPusNamed(context, AppRoutes.wishlistScreen);
        },
        icon: const Icon(
          IconlyLight.heart,
          size: 24,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
          size: 28,
          color: Colors.black,
        ),
      ),
    ],
  );
}
