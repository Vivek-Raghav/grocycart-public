import 'package:flutter/material.dart';
import 'package:grocycart/models/collection.dart';
import 'package:grocycart/screens/Cart/cart_screen.dart';
import 'package:grocycart/screens/Categories/categories_screen.dart';
import 'package:grocycart/screens/Home/home_screen.dart';
import 'package:grocycart/screens/Product/product_screen.dart';
import 'package:grocycart/screens/User/Order/order_screen.dart';
import 'package:grocycart/screens/User/user_screen.dart';
import 'package:grocycart/screens/bottom_bar.dart';
import 'package:grocycart/screens/splash_screen.dart';

import '../models/product.dart';
import '../screens/Authentication/forget_password_screen.dart';
import '../screens/Authentication/signin_screen.dart';
import '../screens/Authentication/singup_screen.dart';
import '../screens/Categories/category_product_screen.dart';
import '../screens/Home/all_products_screen.dart';
import '../screens/User/about/about_us.dart';
import '../screens/User/profile/my_profile_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';

void navigateToPusNamed(BuildContext context, String route,
    {Object? arguments}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

void navigateToPushReplacement(BuildContext context, String route,
    {Object? arguments}) {
  Navigator.pushReplacementNamed(context, route, arguments: arguments);
}

class AppRoutes {
  static const String splashScreen = SplashScreen.routeName;
  static const String bottomBar = BottomBar.routeName;
  static const String home = HomeScreen.routeName;
  static const String wishlistScreen = WishlistScreen.routeName;
  static const String cart = CartScreen.routeName;
  static const String user = UserScreen.routeName;
  static const String categories = CategoryScreen.routeName;
  static const String productScreen = ProductScreen.routeName;
  static const String allProductsScreen = AllProductScreen.routeName;
  static const String myProfileScreen = MyProfileScreen.routeName;
  static const String orderScreen = OrderScreen.routeName;
  static const String loginScreen = LoginScreen.routeName;
  static const String signUpScreen = SignUpScreen.routeName;
  static const String forgotPasswordScreen = ForgotPasswordScreen.routeName;
  static const String aboutUsScreen = AboutUsScreen.routeName;
  static const String categoryProductScreen = CategoryProductScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    bottomBar: (context) => const BottomBar(),
    home: (context) => const BottomBar(choosePage: 0),
    wishlistScreen: (context) => const BottomBar(choosePage: 1),
    cart: (context) => const BottomBar(choosePage: 2),
    user: (context) => const BottomBar(choosePage: 3),
    categories: (context) => const CategoryScreen(),
    productScreen: (context) =>
        ProductScreen(ModalRoute.of(context)!.settings.arguments as Product),
    allProductsScreen: (context) => const AllProductScreen(),
    myProfileScreen: (context) => const MyProfileScreen(),
    orderScreen: (context) => const OrderScreen(),
    loginScreen: (context) => const LoginScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
    aboutUsScreen: (context) => const AboutUsScreen(),
    categoryProductScreen: (context) => CategoryProductScreen(
        ModalRoute.of(context)!.settings.arguments as Collection),
  };
}
