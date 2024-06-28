// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/product.dart';

// final cartNotifierProvider =
//     StateNotifierProvider<CartNotifier, List<Product>>((ref) {
//   return CartNotifier();
// });

// class CartNotifier extends StateNotifier<List<Product>> {
//   CartNotifier() : super([]);

//   void addToCart(Product product) {
//     state = [...state, product];
//   }

//   void removeFromCart(Product product) {
//     state = state.where((item) => item.id != product.id).toList();
//   }

//   void updateQuantity(Product product, int newQuantity) {
//     state = state.map((item) {
//       if (item.id == product.id) {
//         product.quantity = newQuantity;
//         return product;
//       } else {
//         return item;
//       }
//     }).toList();
//   }

//   // double getTotalPrice() {
//   //   return
//   // }

//   double calculateTotalPrice() {
//     double totalPrice = 0;
//     for (var product in state) {
//       totalPrice += product.price * product.quantity;
//     }
//     return totalPrice;
//   }

//   int get cartItemsLength => state.length;
// }
