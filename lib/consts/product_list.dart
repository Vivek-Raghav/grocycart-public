import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../widgets/const_widgets.dart';

final productListProvider =
    StateNotifierProvider<ProductRepositoryProvider, List<Product>>(
        (ref) => ProductRepositoryProvider());

class ProductRepositoryProvider extends StateNotifier<List<Product>> {
  ProductRepositoryProvider() : super([]);
  int get productLength => state.length;

  Future<void> retrieveProducts(BuildContext context) async {
    try {
      final ffstore = FirebaseFirestore.instance;
      QuerySnapshot query = await ffstore.collection('products').get();
      final alldata = query.docs
          .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      state = alldata;
    } on FirebaseException catch (error) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, error.toString());
    }
  }
}
