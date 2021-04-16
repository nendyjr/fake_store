import 'package:fake_store/feature/product_detail/resources/product_detail_api_provider.dart';
import 'package:meta/meta.dart';

import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'cart_api_provider.dart';

class CartRepository {
  ApiProvider apiProvider;
  CartApiProvider cartApiProvider;
  ProductDetailApiProvider productDetailApiProvider;
  Env env;

  CartRepository({this.apiProvider, this.env}) {
    cartApiProvider =
        CartApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
    productDetailApiProvider = ProductDetailApiProvider(
        baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<List<Cart>>> fetchCart(int userId) async {
    final response = await cartApiProvider.fetchCart(userId);
    if (response == null) {
      return DataResponse.error("No Response");
    }

    if (response is List) {
      final List<Cart> _carts = (response)?.map((dynamic e) {
        return e == null ? null : Cart.fromJson(e as Map<String, dynamic>);
      })?.toList();
      for (var cart in _carts) {
        List<Product> _realProduct = [];
        for (var prod in cart.products) {
          var json =
              await productDetailApiProvider.fetchProduct(prod.productId);
          _realProduct.add(Product.fromJson(json));
        }
        cart.realProducts = _realProduct;
      }
      return DataResponse.success(_carts);
    } else {
      return DataResponse.error("error");
    }
  }

  Future<DataResponse<Cart>> removeProductCart(
      int productId, int cartId) async {
    final response = await cartApiProvider.cartRemoveItem(productId, cartId);
    if (response == null) {
      return DataResponse.error("No Response");
    }

    if (response is Map) {
      final Cart _cart = Cart.fromJson(response);
      return DataResponse.success(_cart);
    } else {
      return DataResponse.error("error");
    }
  }
}
