import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends CartEvent {
  int userId;
  Fetch(this.userId);
}

class RemoveItemCart extends CartEvent {
  int productId;
  int cartId;
  RemoveItemCart(this.productId, this.cartId);
}
