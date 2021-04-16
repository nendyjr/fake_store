import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class Fetch extends ProductListEvent {
  String category;
  Fetch(this.category);

  @override
  List<Object> get props => [category];
}

class FetchCategory extends ProductListEvent {}
