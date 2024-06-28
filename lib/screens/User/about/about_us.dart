import 'package:flutter/material.dart';

import '../../../widgets/TextWidget/Text_widget.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/aboutScreen';

  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color color = isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              content: 'About Grocery App',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            const SizedBox(height: 20),
            TextWidget(
              content:
                  'Grocery App is a mobile application built using Flutter, a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. The app allows users to conveniently shop for groceries online.',
              fontSize: 16,
              color: color,
            ),
            const SizedBox(height: 20),
            TextWidget(
              content: 'Author: Vivek Raghav',
              fontSize: 16,
              color: color,
            ),
            const SizedBox(height: 20),
            TextWidget(
              content: 'Version: Flutter 3.19.0',
              fontSize: 16,
              color: color,
            ),
            TextWidget(
              content: 'Channel: Stable',
              fontSize: 16,
              color: color,
            ),
            TextWidget(
              content: 'Framework Revision: bae5e49bc2',
              fontSize: 16,
              color: color,
            ),
            TextWidget(
              content: 'Engine Revision: 04817c99c9',
              fontSize: 16,
              color: color,
            ),
            TextWidget(
              content: 'Dart Version: 3.3.0',
              fontSize: 16,
              color: color,
            ),
            TextWidget(
              content: 'DevTools Version: 2.31.1',
              fontSize: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
