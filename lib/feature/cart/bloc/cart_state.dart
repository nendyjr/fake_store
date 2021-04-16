import 'package:equatable/equatable.dart';
import 'package:fake_store/feature/cart/model/cart.dart';

class CartState extends Equatable {
  CartState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CartEmpty extends CartState {}

class CartFetch extends CartState {}

class CartError extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> carts;

  CartLoaded({this.carts});
  @override
  List<Object> get props => [carts];
}

class CartRemoveProduct extends CartState {}

class CartRemoveProductSuccess extends CartState {}

class CartRemoveProductError extends CartState {}
