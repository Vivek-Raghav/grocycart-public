import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/screens/bottom_bar.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/services/shared_preferences.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

import '../consts/consts.dart';
import '../consts/product_list.dart';
import '../services/auth/auth_repository.dart';
import 'Authentication/signin_screen.dart'; // Import your login screen here

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> initializeSharedPreferences() async {
    SharedPrefs prefs = SharedPrefs();
    final userLoginStatus = await prefs.getUserLoginStatus();
    if (userLoginStatus) {
      await ref
          .read(cartRepositoryProvider.notifier)
          .retrieveCartItem(context: context);
      await ref
          .read(wishlistRepositoryProvider.notifier)
          .retrieveWishListItem(context: context);
    }

    // Add a delay to simulate a splash screen
    Timer(const Duration(seconds: 1), () {
      print(' Current userLogin Status : $userLoginStatus');
      if (userLoginStatus == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      // Navigate to the login screen after the delay
    });
  }

  void initUserData() async {
    final userData = ref.read(authRepository);
    String? name = await userData.retrieveUserDetail('username');
    if (name != null) {
      setState(() {
        constName = name!;
      });
    } else {
      name = '';
      print('Failed to retrieve username');
    }

    String? email = await userData.retrieveUserDetail('email');
    if (email != null) {
      setState(() {
        constEmail = email!;
      });
    } else {
      email = '';
      print('Failed to retrieve username');
    }
  }

  void retrieveData() async {
    await ref.read(productListProvider.notifier).retrieveProducts(context);
  }

  @override
  void initState() {
    initUserData();
    retrieveData();
    super.initState();
    initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/app_logo.png'))),
            ),
            const TextWidget(
              content: 'GrocyCart',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
