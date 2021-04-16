import 'package:equatable/equatable.dart';
import 'package:fake_store/feature/product_list/model/product.dart';

class ProductDetailState extends Equatable {
  ProductDetailState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductDetailEmpty extends ProductDetailState {}

class ProductDetailFetch extends ProductDetailState {}

class ProductDetailError extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  ProductDetailLoaded({this.product});
  @override
  List<Object> get props => [product.id];
}

class ProductDetailAddToCart extends ProductDetailState {}

class ProductDetailAddToCartSuccess extends ProductDetailState {}

class ProductDetailAddToCartError extends ProductDetailState {}
