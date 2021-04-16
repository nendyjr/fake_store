import 'package:bloc/bloc.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'package:fake_store/feature/cart/resources/cart_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({this.cartRepository})
      : assert(cartRepository != null),
        super(CartEmpty());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    final CartState currentState = state;
    if (event is Fetch) {
      try {
        if (currentState is CartEmpty) {
          yield CartFetch();
          final List<Cart> carts = await _fetchCart(event.userId);
          yield CartLoaded(carts: carts);
        }
      } catch (_) {
        yield CartError();
      }
    } else if (event is RemoveItemCart) {
      try {
        yield CartRemoveProduct();
        final Cart cart =
            await _removeProductCart(event.productId, event.cartId);
        yield CartRemoveProductSuccess();
      } catch (_) {
        yield CartRemoveProductError();
      }
    }
  }

  Future<List<Cart>> _fetchCart(int userId) async {
    final response = await cartRepository.fetchCart(userId);
    if (response.status == Status.Success) {
      return response.data;
    }
    return null;
  }

  Future<Cart> _removeProductCart(int productId, int cartId) async {
    final response = await cartRepository.removeProductCart(productId, cartId);
    if (response.status == Status.Success) {
      return response.data;
    }
    return null;
  }
}
