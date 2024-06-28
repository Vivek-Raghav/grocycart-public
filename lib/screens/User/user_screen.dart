import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/consts.dart';
import 'package:grocycart/screens/User/Address/add_address_screen.dart';
import 'package:grocycart/screens/User/Order/order_screen.dart';
import 'package:grocycart/screens/User/about/about_us.dart';
import 'package:grocycart/screens/User/profile/my_profile_screen.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../consts/theme_provider.dart';
import '../../widgets/app_routes.dart';
import 'UserWidgets/custom_little_widgets.dart';
import 'UserWidgets/sign_out.dart';

class UserScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user';
  const UserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.read(themeProvider);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigateToPusNamed(context, AppRoutes.home);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          elevation: 0,
          // shadowColor: isDarkTheme ? Colors.white : Colors.black,
          title: const TextWidget(
            content: 'Profile',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 12, top: 15, bottom: 12),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(42)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).secondaryHeaderColor,
                    offset: const Offset(0, 5),
                    blurRadius: 100,
                    spreadRadius: -25,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                  ],
                  stops: const [0.1, 0.3, 0.9, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 100, // Set your desired width
                    height: 100, // Set your desired height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context)
                            .secondaryHeaderColor, // Set your desired border color
                        width: 3.0, // Set your desired border width
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=800',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        content: "Name : $constName",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        content: "Email : $constEmail",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '     Account Overview',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          customListile(
            isDarkTheme,
            'My Profile',
            null,
            IconlyLight.profile,
            IconlyLight.arrowRight2,
            () {
              navigateToPusNamed(context, MyProfileScreen.routeName);
            },
          ),
          customListile(
            isDarkTheme,
            'My orders',
            null,
            IconlyLight.bag2,
            IconlyLight.arrowRight2,
            () {
              navigateToPusNamed(
                context,
                OrderScreen.routeName,
              );
            },
          ),
          customListile(
            isDarkTheme,
            'Address Book',
            'Add Address',
            Icons.location_city,
            IconlyLight.arrowRight2,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAddressScreen(),
                ),
              );
            },
          ),
          customListile(
            isDarkTheme,
            'About us',
            null,
            Icons.web,
            IconlyLight.arrowRight2,
            () {
              navigateToPusNamed(context, AboutUsScreen.routeName);
            },
          ),
          customListile(
            isDarkTheme,
            'Theme Change',
            null,
            IconlyLight.star,
            IconlyLight.arrowRight2,
            () {
              toggleTheme(ref);
              setState(() {});
            },
          ),
          customListile(
            isDarkTheme,
            'Logout',
            null,
            IconlyLight.logout,
            IconlyLight.dangerCircle,
            () {
              showSignOutDialog(context, isDarkTheme);
            },
          ),
          // customListile(
          //   isDarkTheme,
          //   'Check Function Button',
          //   null,
          //   IconlyLight.message,
          //   IconlyLight.message,
          //   () {
          //     checkButtonFunction(context);
          //   },
          // ),
        ],
      ),
    );
  }

  void checkButtonFunction(BuildContext context) async {
    // ref.read(cartController).addToCart(context, ProductList[3]);
    // final cartList = await ref
    //     .read(cartRepositoryProvider.notifier)
    //     .retrieveCartItem(context: context);
    // print('CartList =>>>>>> $cartList');
  }
}
