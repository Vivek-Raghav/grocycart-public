import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/const_widgets.dart';
import '../../consts/color_list.dart';
import '../../consts/theme_provider.dart';
import '../../models/collection.dart';
import '../../widgets/TextWidget/Text_widget.dart';
import '../../widgets/app_routes.dart';
import '../Home/homeScreenWidgets/product_widget.dart';

class CategoryProductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/categoryProductScreen';
  final Collection collection;

  const CategoryProductScreen(this.collection, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryProductScreenState();
}

class _CategoryProductScreenState extends ConsumerState<CategoryProductScreen> {
  late bool isDarkTheme;
  late Size size;

  @override
  void initState() {
    super.initState();
    isDarkTheme = ref.read(themeProvider);
    size = Size.zero;
  }

  @override
  Widget build(BuildContext context) {
    final cartItemsProvider = ref.read(cartRepositoryProvider.notifier);
    final wishListNotifier = ref.read(wishlistRepositoryProvider.notifier);
    // final
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: TextWidget(
          content: widget.collection.name,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: widget.collection.productList.isNotEmpty
          ? GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 190 / 240,
              children: List.generate(
                widget.collection.productList.length,
                (index) => ProductWidget(
                  title: widget.collection.productList[index].name,
                  isDarkTheme: isDarkTheme,
                  color: colorList[index],
                  price: widget.collection.productList[index].price,
                  imageLink: widget.collection.productList[index].imageUrl,
                  itemWeight:
                      widget.collection.productList[index].weightPerUnit,
                  onTap: () {
                    navigateToPusNamed(
                      context,
                      AppRoutes.productScreen,
                      arguments: widget.collection.productList[index],
                    );
                  },
                  onTapWishlist: () {
                    if (wishListNotifier.isProductInWishList(
                        widget.collection.productList[index])) {
                      showSnackBar(context, 'Already in wishlist');
                    } else {
                      wishListNotifier.addToWishList(
                          context, widget.collection.productList[index]);

                      showSnackBar(context, 'Added in WishList');
                    }
                  },
                  onTapForAdd: () {
                    if (cartItemsProvider.isProductInCartList(
                        widget.collection.productList[index])) {
                      showSnackBar(context, 'Already in cartlist');
                    } else {
                      showSnackBar(context, 'Added successfully');
                      cartItemsProvider.addToCart(
                          context, widget.collection.productList[index]);
                    }
                  },
                ),
              ),
            )
          : const Center(
              child: TextWidget(
                content: 'No products available in this collection yet.',
                color: Colors.grey,
              ),
            ),
    );
  }
}
