import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/authentication_consts.dart';

import '../../consts/globalWidget/error_dialog.dart';
import '../../models/product.dart';

final wishlistRepositoryProvider =
    StateNotifierProvider<WishListRepository, List<Product>>(
        (ref) => WishListRepository());

class WishListRepository extends StateNotifier<List<Product>> {
  WishListRepository() : super([]);

  int get wishListLength => state.length;

  bool isProductInWishList(Product product) {
    return state.any((item) => item.id == product.id);
  }

  Future<List<Product>> retrieveWishListItem({
    required BuildContext context,
  }) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? wishData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> wishlistData = wishData!['wishlist'];
        List<Product> wishlist = wishlistData
            .map((item) => Product.fromJson(item['product']))
            .toList();
        // print('Retrieve data function => ${wishlist.length}');
        state = wishlist;
        return wishlist;
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
  // add data to wishlist in firebase
  //
  //

  void addToWishList(BuildContext context, Product product) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? wishData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> wishlistData =
            wishData!['wishlist'] as List<dynamic>;
        wishlistData.add({
          'product': product.toJson(),
        });
        await firestoreInstance.collection('users').doc(uid).update({
          'wishlist': wishlistData,
        });
        await retrieveWishListItem(context: context);
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

  void removeFromWishList(BuildContext context, int index) async {
    try {
      final uid = authInstance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await firestoreInstance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? cartData =
            documentSnapshot.data() as Map<String, dynamic>?;
        final List<dynamic> wishlistData =
            cartData!['wishlist'] as List<dynamic>;
        wishlistData.removeAt(index);
        print('Product Removed successfully');
        await firestoreInstance.collection('users').doc(uid).update({
          'wishlist': wishlistData,
        });
        await retrieveWishListItem(context: context);
      }
    } catch (error) {
      print('Error adding to cart: $error');
    }
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
        'wishlist': [],
      });
      await retrieveWishListItem(context: context);
    } catch (error) {
      print('Error adding to cart: $error');
    }
  }
}
