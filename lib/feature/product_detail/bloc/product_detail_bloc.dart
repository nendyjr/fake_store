import 'package:bloc/bloc.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:fake_store/feature/product_detail/resources/product_detail_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository productDetailRepository;

  ProductDetailBloc({this.productDetailRepository})
      : assert(productDetailRepository != null),
        super(ProductDetailEmpty());

  @override
  Stream<Transition<ProductDetailEvent, ProductDetailState>> transformEvents(
    Stream<ProductDetailEvent> events,
    TransitionFunction<ProductDetailEvent, ProductDetailState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    final ProductDetailState currentState = state;
    if (event is Fetch) {
      try {
        if (currentState is ProductDetailEmpty) {
          yield ProductDetailFetch();
          final Product product = await _fetchProduct(event.productId);
          yield ProductDetailLoaded(product: product);
        }
      } catch (_) {
        yield ProductDetailError();
      }
    } else if (event is AddToCart) {
      try {
        yield ProductDetailAddToCart();
        final Cart cart = await _addToCart(event.productId);
        yield ProductDetailAddToCartSuccess();
      } catch (_) {
        yield ProductDetailAddToCartError();
      }
    }
  }

  Future<Product> _fetchProduct(int productId) async {
    final response = await productDetailRepository.fetchProduct(productId);
    if (response.status == Status.Success) {
      return response.data;
    }
    return null;
  }

  Future<Cart> _addToCart(int productId) async {
    final response = await productDetailRepository.addToCart(productId);
    if (response.status == Status.Success) {
      return response.data;
    }
    return null;
  }
}
