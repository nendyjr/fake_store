import 'package:bloc/bloc.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:fake_store/feature/product_list/resources/product_list_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductListRepository productListRepository;

  ProductListBloc({this.productListRepository})
      : assert(productListRepository != null),
        super(ProductListEmpty());

  @override
  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    final ProductListState currentState = state;
    if (event is Fetch) {
      try {
        yield ProductListFetch();
        final List<Product> products = await _fetchProducts(event.category);
        yield ProductListLoaded(products: products);
      } catch (_) {
        yield ProductListError();
      }
    } else if (event is FetchCategory) {
      try {
        yield ProductListCategoriesFetch();
        final List<String> categories = await _fetchCategories();
        yield ProductListCategoriesLoaded(categories: categories);
      } catch (_) {
        yield ProductListCategoriesError();
      }
    }
  }

  Future<List<Product>> _fetchProducts(String category) async {
    final response = await productListRepository.fetchProducts(category);
    if (response.status == Status.Success) {
      return response.data;
    }
    return [];
  }

  Future<List<String>> _fetchCategories() async {
    final response = await productListRepository.fetchCategories();
    if (response.status == Status.Success) {
      return response.data;
    }
    return [];
  }
}
