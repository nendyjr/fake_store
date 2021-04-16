import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends ProductDetailEvent {
  int productId;
  Fetch(this.productId);
}

class AddToCart extends ProductDetailEvent {
  int productId;
  AddToCart(this.productId);
}
