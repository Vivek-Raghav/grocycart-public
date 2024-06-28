// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

import 'empty_order_screen.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/orderScreen';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          content: 'Orders',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: isEmpty
          ? Container(
              child: const EmptyOrderScreen(),
            )
          // ignore: dead_code
          : Container(),
    );
  }
}
