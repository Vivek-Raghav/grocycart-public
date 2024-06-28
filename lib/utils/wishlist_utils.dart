// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/product.dart';

// final wishListNotifierProvider =
//     StateNotifierProvider<WishListNotifier, List<Product>>((ref) {
//   return WishListNotifier();
// });

// class WishListNotifier extends StateNotifier<List<Product>> {
//   WishListNotifier() : super([]);

//   void addToWishlist(Product product) {
//     if (!isProductInWishlist(product)) {
//       final newItem = Product(
//         id: product.id,
//         name: product.name,
//         description: product.description,
//         price: product.price,
//         imageUrl: product.imageUrl,
//         quantity: product.quantity,
//         weightPerUnit: product.weightPerUnit,
//       );
//       state = [...state, newItem];
//     } else {
//       throw Exception('This product is already in the wishlist.');
//     }
//   }

//   void removeFromWishlist(Product product) {
//     state = state.where((item) => item.id != product.id).toList();
//   }

//   bool isProductInWishlist(Product product) {
//     return state.any((item) => item.id == product.id);
//   }

//   int get wishListLength => state.length;
// }
