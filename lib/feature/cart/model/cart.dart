import 'package:equatable/equatable.dart';
import 'package:fake_store/feature/product_list/model/product.dart';

class Cart extends Equatable {
  final int id;
  final int userId;
  final String date;
  List<ProductCart> products;
  List<Product> realProducts;

  Cart({
    this.id,
    this.userId,
    this.date,
    this.products,
    this.realProducts,
  });

  @override
  // TODO: implement props
  List<Object> get props => [id, userId, date];

  @override
  String toString() => 'Product { id: $id, title: $userId }';

  @override
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json['id'] as int,
        userId: json['userId'] as int,
        date: json['date'] as String,
        products: (json['products'] as List)
            .map((e) => ProductCart.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

class ProductCart extends Equatable {
  final int productId;
  final int quantity;

  ProductCart({this.productId, this.quantity});

  @override
  // TODO: implement props
  List<Object> get props => [productId, quantity];

  @override
  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
        productId: json['productId'] as int, quantity: json['quantity'] as int);
  }
}
