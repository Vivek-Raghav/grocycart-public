import 'package:flutter/material.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.40,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/cart/empty_cart.png',
                ),
                fit: BoxFit.cover),
          ),
        ),
        const TextWidget(
          content: 'Your Cart is empty',
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        const TextWidget(
          content:
              'Looks like you haven\'t added anything !!! \n Please add items in your cart',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
