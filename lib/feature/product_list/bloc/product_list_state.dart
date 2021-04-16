import 'package:equatable/equatable.dart';
import 'package:fake_store/feature/product_list/model/product.dart';

class ProductListState extends Equatable {
  ProductListState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductListEmpty extends ProductListState {}

class ProductListFetch extends ProductListState {}

class ProductListError extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  ProductListLoaded({this.products});
  @override
  List<Object> get props => [products];
}

class ProductListCategoriesEmpty extends ProductListState {}

class ProductListCategoriesFetch extends ProductListState {}

class ProductListCategoriesError extends ProductListState {}

class ProductListCategoriesLoaded extends ProductListState {
  final List<String> categories;

  ProductListCategoriesLoaded({this.categories});
  @override
  List<Object> get props => [categories];
}
