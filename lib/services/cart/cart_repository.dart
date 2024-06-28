import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/authentication_consts.dart';

import '../../consts/globalWidget/error_dialog.dart';
import '../../models/product.dart';

final cartRepositoryProvider =
    StateNotifierProvider<CartRepository, List<Product>>(
        (ref) => CartRepository());

class CartRepository extends StateNotifier<List<Product>> {
  CartRepository() : super([]);

  int get cartItemsLength => state.length;

  List<Product> getCartItems() {
    return state;
  }

  //
  //
  //
  // Retreiving the details
  //
  //
  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var product in state) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  Future<List<Product>> retrieveCartItem({
    required BuildContext context,
  }) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? cartData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> cartListData = cartData!['cartlist'];
        // print('cartList Data => $cartListData');

        // Convert cartListData to List<Product>
        List<Product> cartList = cartListData
            .map((item) => Product.fromJson(item['product']))
            .toList();
        // print('Retrieve data function => ${cartList.length}');
        state = cartList;
        return cartList;
      }
    } on FirebaseException catch (err) {
      showErrorDialog(
        context,
        err.message.toString(),
      );
      print(
        'Error addAddress => ${err.message.toString()}',
      );
      return [];
    }
    return [];
  }

  //
  //
  // add data to cartlist in firebase
  //
  //

  void addToCart(BuildContext context, Product product) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? cartData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> cartListData =
            cartData!['cartlist'] as List<dynamic>;
        cartListData.add({
          'product': product.toJson(),
        });
        await firestoreInstance.collection('users').doc(uid).update({
          'cartlist': cartListData,
        });
        await retrieveCartItem(context: context);
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }

  //
  //
  //
  //
  //
  //
  //

  void removeFromCart(BuildContext context, int index) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? cartData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> cartListData =
            cartData!['cartlist'] as List<dynamic>;
        cartListData.removeAt(index);
        print('Product Removed successfully');
        await firestoreInstance.collection('users').doc(uid).update({
          'cartlist': cartListData,
        });
        await retrieveCartItem(context: context);
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }

//
//
//
// Changing the details in a product
//

  void updateQuantity(Product product, int newQuantity) {
    state = state.map((item) {
      if (item.id == product.id) {
        // Update the quantity of the matching product
        item.quantity = newQuantity;
      }
      return item; // Return the updated or original item
    }).toList();
  }

//
//
//  remove all the products
//
//
  void removeAllTheProducts(BuildContext context) async {
    try {
      final uid = authInstance.currentUser!.uid;
      print('All Product Removed successfully');
      await firestoreInstance.collection('users').doc(uid).update({
        'cartlist': [],
      });
      await retrieveCartItem(context: context);
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }

//
//
// Check whether the product is already available in cartList or not
//

  bool isProductInCartList(Product product) {
    return state.any((item) => item.id == product.id);
  }
}
