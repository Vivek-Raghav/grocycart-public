import 'package:flutter/material.dart';

import '../../../widgets/TextWidget/text_widget.dart';

Widget offerAnnouncement(
    BuildContext context, String imgUrl, String title, String subtitle) {
  return Row(
    children: [
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage(imgUrl),
            // 'https://img.freepik.com/premium-vector/cargo-van-line-icon-truck-garbage-disposal-car-box-delivery-fragile-goods-delivery-concept-vector-line-icon-white-background_727385-530.jpg?w=996'
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            content: title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(content: subtitle),
        ],
      )
    ],
  );
}
