import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../consts/color_list.dart';
import 'empty_wishlist_screen.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  static const String routeName = '/wishlistScreen';
  const WishlistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = ref.read(themeProvider);
    final wishListItems = ref.watch(wishlistRepositoryProvider);
    final wishListItemsNotifier =
        ref.watch(wishlistRepositoryProvider.notifier);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          content: 'Your Wishlist',
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
              onPressed: () {
                wishListItemsNotifier.removeAllTheProducts(context);
              },
              icon: const Icon(Icons.delete))
        ],
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          wishListItems.isEmpty
              ? const EmptyWishListScreen()
              : Expanded(
                  child: ListView.builder(
                    itemCount: wishListItems.length,
                    itemBuilder: (conext, index) => Container(
                      decoration: BoxDecoration(
                          color: colorList[index].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.12,
                            width: size.width * 0.5 - 100,
                            decoration: BoxDecoration(
                                color: colorList[index].withOpacity(0.2),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      wishListItems[index].imageUrl),
                                ),
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              TextWidget(
                                content: wishListItems[index].name,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              TextWidget(
                                content:
                                    'Price : ₹ ${wishListItems[index].price}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                              TextWidget(
                                content:
                                    'weight : ${wishListItems[index].weightPerUnit}',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: size.height * 0.12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: colorList[index].withOpacity(0.4),
                                  width: 4),
                            ),
                            child: IconButton(
                              onPressed: () {
                                //
                                //
                                //
                                //
                                //
                                // refresh the quantity of the product
                                //
                                //
                                wishListItems[index].quantity = 1;
                                print(
                                    'removing the product : ${wishListItems[index]}');
                                wishListItemsNotifier.removeFromWishList(
                                    context, index);
                                // Removing the product from cart
                                //
                                //
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color:
                                    isDarkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
