import 'package:flutter/material.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import 'package:grocycart/widgets/app_routes.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

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
          content: 'No orders',
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        const TextWidget(
          content:
              'Looks like you haven\'t ordered anything !!! \n Please order something now!!',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              navigateToPusNamed(context, AppRoutes.home);
            },
            child: SizedBox(
              height: 60,
              width: size.width * 0.5 + 20,
              child: const Center(
                child: TextWidget(
                  content: 'Browse',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
