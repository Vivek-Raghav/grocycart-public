import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/widgets/TextWidget/Text_widget.dart';
import '../../consts/color_list.dart';
import '../../models/product.dart';
import '../../widgets/const_widgets.dart';
import 'productWidgets/coupon_widget.dart';
import 'productWidgets/product_appbar.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/productScreen';
  final Product product;
  const ProductScreen(this.product, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  // int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final cartItemsProvider = ref.read(cartRepositoryProvider.notifier);
    final isDarkTheme = ref.read(themeProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbarProductScreen(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.imageUrl,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  content: widget.product.name,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
                TextWidget(
                  content: ' ₹ ${widget.product.price}',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            child: TextWidget(
              content: "Weight : ${widget.product.weightPerUnit}",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          //
          //
          // Description section
          //
          // App by Vivek Raghav
          //

          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: TextWidget(
              content: widget.product.description,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
//
//
// Increase and decrease button section start
//
//
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, top: 10, bottom: 10, right: 15),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: 10,),
                    const TextWidget(
                      content: 'Quantity',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            widget.product.quantity == 1
                                ? null
                                : widget.product.quantity =
                                    widget.product.quantity - 1;
                          },
                        );
                      },
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: greenGradient(context),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 29.0, right: 29.0),
                        child: TextWidget(
                          content: '${widget.product.quantity}',
                          fontSize: 16,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        )),
                    IconButton(
                      onPressed: () {
                        // quantity = quantity + 1;
                        setState(() {
                          widget.product.quantity = widget.product.quantity + 1;
                        });
                      },
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
//
//
// Increase and decrease button section end
//
//
//

          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                offerAnnouncement(
                    context, 'assets/free-delivery.png', 'Delivery', 'Free'),
                offerAnnouncement(
                    context, 'assets/badge.png', 'Quality', '100%')
              ],
            ),
          ),

//
//
// Add to cart Button
//
//
          const Spacer(),
          InkWell(
            onTap: () {
              if (cartItemsProvider.isProductInCartList(widget.product)) {
                showSnackBar(context, 'Already in cartlist');
              } else {
                showSnackBar(context, 'Added successfully');
                cartItemsProvider.addToCart(context, widget.product);
              }
            },
            child: Center(
              child: Container(
                height: 60,
                width: size.width - 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(20),
                  gradient: greenButtonGradient(context),
                ),
                child: const Center(
                  child: TextWidget(
                    content: 'Add to Cart',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
