import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/services/cart/cart_repository.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../consts/color_list.dart';
import 'cart_empty_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cartControl = ref.read(cartRepositoryProvider);
    bool isDarkTheme = ref.read(themeProvider);
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final cartItems = ref.watch(cartRepositoryProvider);
      final cartRepoNotifier = ref.read(cartRepositoryProvider.notifier);
      // final cartItems = cartRepo;
      final totalAmount = cartRepoNotifier.calculateTotalPrice();
      return Scaffold(
          appBar: AppBar(
            title: const TextWidget(
              content: 'Cart Screen',
              fontWeight: FontWeight.bold,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cartRepoNotifier.removeAllTheProducts(context);
                  },
                  icon: const Icon(Icons.delete))
            ],
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cartItems.isEmpty
                  ? const EmptyCartScreen()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (conext, index) => SizedBox(
                          width: double.infinity,
                          child: Container(
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
                                            cartItems[index].imageUrl),
                                      ),
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      content: cartItems[index].name,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextWidget(
                                      content:
                                          'Price : ${cartItems[index].price}',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    TextWidget(
                                      content:
                                          'weight : ${cartItems[index].weightPerUnit}',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            //
                                            //
                                            // decreasing the quantity in a product
                                            //
                                            //

                                            if (cartItems[index].quantity > 1) {
                                              cartRepoNotifier.updateQuantity(
                                                  cartItems[index],
                                                  cartItems[index].quantity -
                                                      1);
                                              setState(() {});
                                            }
                                            print(
                                                'Decreasing product quantity to : : ${cartItems[index].quantity}');
                                          },
                                          icon: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                gradient:
                                                    greenGradient(context),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        TextWidget(
                                          content:
                                              '${cartItems[index].quantity}',
                                          fontSize: 16,
                                          color: isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            //
                                            //
                                            //
                                            // managing quantity
                                            //
                                            //
                                            cartRepoNotifier.updateQuantity(
                                                cartItems[index],
                                                cartItems[index].quantity + 1);
                                            setState(() {});
                                            print(
                                                'increasing product quantity to : ${cartItems[index]..quantity}');
                                          },
                                          icon: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.9),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                const Spacer(),
                                Container(
                                  height: size.height * 0.12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            colorList[index].withOpacity(0.4),
                                        width: 4),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        //
                                        //
                                        //
                                        //
                                        //
                                        // removing the cart according to their index
                                        //
                                        //
                                        cartRepoNotifier.removeFromCart(
                                            context, index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: isDarkTheme
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TextWidget(
                          content: 'Total -',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          content: '₹ ${totalAmount.toStringAsFixed(2)}',
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          // textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // print(cartItemsNotifier.calculateTotalPrice());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 3, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20),
                          gradient: greenButtonGradient(context),
                        ),
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        // color: Colors.black,
                        child: const Center(
                            child: TextWidget(
                          content: 'Check Out',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
