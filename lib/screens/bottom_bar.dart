// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/screens/Cart/cart_screen.dart';
import 'package:grocycart/screens/Home/home_screen.dart';
import 'package:grocycart/screens/User/user_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:grocycart/screens/wishlist/wishlist_screen.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const String routeName = '/bottomBar';
  final int? choosePage;

  const BottomBar({
    super.key,
    this.choosePage,
  });

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  late int currentPage = widget.choosePage ?? 0;
  final List _pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const UserScreen()
  ];

  void selectedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItemNumber = ref.watch(cartRepositoryProvider).length;
    final wishListLength = ref.watch(wishlistRepositoryProvider).length;
    return Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: selectedPage,
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: badges.Badge(
              showBadge: true,
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.square,
                borderRadius: BorderRadius.circular(20),
                badgeColor: Theme.of(context).secondaryHeaderColor,
              ),
              badgeContent: TextWidget(content: '$wishListLength'),
              child: const Icon(
                IconlyBold.heart,
                color: Colors.white,
              ),
            ),
            label: 'WishList',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: badges.Badge(
              showBadge: true,
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.square,
                borderRadius: BorderRadius.circular(20),
                badgeColor: Theme.of(context).secondaryHeaderColor,
              ),
              badgeContent: TextWidget(content: '$cartItemNumber'),
              child: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.people,
              color: Colors.white,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
