import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/services/wishlist/wishlist_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../consts/color_list.dart';
import '../../consts/product_list.dart';
import '../../models/product.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/const_widgets.dart';
import 'homeScreenWidgets/product_widget.dart';

class AllProductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/allProductScreen';
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends ConsumerState<AllProductScreen> {
  late bool isDarkTheme;
  late Size size;
  late List<Product> filteredProducts;
  late String searchText;

  @override
  void initState() {
    super.initState();
    isDarkTheme = ref.read(themeProvider);
    size = Size.zero;
    filteredProducts = [];
    searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    final wishListNotifier = ref.read(wishlistRepositoryProvider.notifier);
    final ProductList = ref.watch(productListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const TextWidget(
          content: 'All Products',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search Products...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          filteredProducts.clear();
                          searchText = '';
                          print(
                              'Here typing the value of searchText after clicking on buton: ${searchText + "yoo"}');
                        });
                      },
                      icon: const Icon(Icons.clear))),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                  filteredProducts = ProductList.where((product) =>
                      product.name.toLowerCase().contains(searchText)).toList();
                  // Limit suggestions to first five products
                  filteredProducts = filteredProducts.take(5).toList();
                });
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 190 / 240,
                    children: List.generate(
                      filteredProducts.length,
                      (index) => ProductWidget(
                        title: filteredProducts[index].name,
                        isDarkTheme: isDarkTheme,
                        color: colorList[index],
                        price: filteredProducts[index].price,
                        imageLink: filteredProducts[index].imageUrl,
                        itemWeight: filteredProducts[index].weightPerUnit,
                        onTap: () {
                          navigateToPusNamed(
                            context,
                            AppRoutes.productScreen,
                            arguments: filteredProducts[index],
                          );
                        },
                        onTapWishlist: () {
                          if (wishListNotifier
                              .isProductInWishList(filteredProducts[index])) {
                            showSnackBar(context, 'Already in wishlist');
                          } else {
                            wishListNotifier.addToWishList(
                                context, filteredProducts[index]);
                            showSnackBar(context, 'Added in WishList');
                          }
                        },
                        onTapForAdd: () {
                          // This is empty as per your original code
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    height: size.height * 1,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 190 / 240,
                      children: List.generate(
                        ProductList.length,
                        (index) => ProductWidget(
                          title: ProductList[index].name,
                          isDarkTheme: isDarkTheme,
                          color: colorList[index],
                          price: ProductList[index].price,
                          imageLink: ProductList[index].imageUrl,
                          itemWeight: ProductList[index].weightPerUnit,
                          onTap: () {
                            navigateToPusNamed(
                              context,
                              AppRoutes.productScreen,
                              arguments: ProductList[index],
                            );
                          },
                          onTapWishlist: () {
                            // This is empty as per your original code
                          },
                          onTapForAdd: () {
                            // This is empty as per your original code
                          },
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
