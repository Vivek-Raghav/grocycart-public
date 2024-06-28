import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinkitProgressiveIndicator(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    color: Colors.transparent.withOpacity(0.7),
    child: const Center(
      child: SpinKitFadingFour(
        color: Colors.white,
      ),
    ),
  );
}
