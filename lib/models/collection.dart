import 'product.dart';

class Collection {
  final String name;
  final String imageUrl;
  final List<Product> productList;

  Collection({
    required this.name,
    required this.imageUrl,
    required this.productList,
  });
}
