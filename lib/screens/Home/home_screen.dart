import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/color_list.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/screens/Home/homeScreenWidgets/on_sale_products_widget.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../consts/collection_list.dart';
import '../../consts/product_list.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/const_widgets.dart';
import 'homeScreenWidgets/appbar_home_screen.dart';
import 'homeScreenWidgets/card_and_onsale.dart';
import 'homeScreenWidgets/product_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.read(cartRepositoryProvider.notifier);
    final wishListNotifier = ref.read(wishlistRepositoryProvider.notifier);
    final productList = ref.watch(productListProvider);
    final isDarkTheme = ref.read(themeProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbarHomeScreen(context),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            cardSwiper(context),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    content: 'Categories',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: () {
                      navigateToPusNamed(context, AppRoutes.categories);
                    },
                    child: TextWidget(
                      content: 'View All',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: collectionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            navigateToPusNamed(
                                context, AppRoutes.categoryProductScreen,
                                arguments: collectionList[index]);
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(collectionList[index].imageUrl),
                            radius: 40,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          collectionList[index].name,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            onSale(),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: size.height * 0.25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    navigateToPusNamed(
                      context,
                      AppRoutes.productScreen,
                      arguments: productList[index],
                    );
                  },
                  child: onSaleProductsWidget(
                    context: context,
                    productName: productList[index].name,
                    imgUrl: productList[index].imageUrl,
                    weight: productList[index].weightPerUnit,
                    productPrice: productList[index].price,
                    color: colorList[index],
                    addToWishList: () {
                      if (wishListNotifier
                          .isProductInWishList(productList[index])) {
                        showSnackBar(context, 'Already in wishlist');
                      } else {
                        wishListNotifier.addToWishList(
                            context, productList[index]);

                        showSnackBar(context, 'Added in WishList');
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '   Our Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    //
                    //
                    //
                    // Navigating or showing all the products
                    //
                    //
                    //
                  },
                  child: InkWell(
                    onTap: () {
                      navigateToPusNamed(context, AppRoutes.allProductsScreen);
                    },
                    child: Text(
                      'Browse All   ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.6,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 190 / 240,
                children: List.generate(
                  productList.length,
                  (index) => ProductWidget(
                    title: productList[index].name,
                    isDarkTheme: isDarkTheme,
                    color: colorList[index],
                    price: productList[index].price,
                    imageLink: productList[index].imageUrl,
                    itemWeight: productList[index].weightPerUnit,
                    onTap: () {
                      navigateToPusNamed(
                        context,
                        AppRoutes.productScreen,
                        arguments: productList[index],
                      );
                    },
                    onTapWishlist: () {
                      if (wishListNotifier
                          .isProductInWishList(productList[index])) {
                        showSnackBar(context, 'Already in wishlist');
                      } else {
                        wishListNotifier.addToWishList(
                            context, productList[index]);
                        showSnackBar(context, 'Added in WishList');
                      }
                    },
                    onTapForAdd: () {
                      if (cartItems.isProductInCartList(productList[index])) {
                        showSnackBar(context, 'Already in cartlist');
                      } else {
                        showSnackBar(context, 'Item Added');
                        cartItems.addToCart(context, productList[index]);
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
