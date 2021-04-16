import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final num price;
  final String category;
  final String description;
  final String image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image});

  @override
  // TODO: implement props
  List<Object> get props => [id, title, price];

  @override
  String toString() => 'Product { id: $id, title: $title }';

  @override
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        title: json['title'] as String,
        price: json['price'] as num,
        category: json['category'] as String,
        description: json['description'] as String,
        image: json['image'] as String);
  }
}
