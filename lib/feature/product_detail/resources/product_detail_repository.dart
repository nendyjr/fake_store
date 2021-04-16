import 'package:meta/meta.dart';

import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'package:fake_store/feature/cart/model/cart.dart';
import 'product_detail_api_provider.dart';

class ProductDetailRepository {
  ApiProvider apiProvider;
  ProductDetailApiProvider productDetailApiProvider;
  Env env;

  ProductDetailRepository({this.apiProvider, this.env}) {
    productDetailApiProvider = ProductDetailApiProvider(
        baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<Product>> fetchProduct(int productId) async {
    final response = await productDetailApiProvider.fetchProduct(productId);
    if (response == null) {
      return DataResponse.error("No Response");
    }

    if (response is Map) {
      final Product _product = Product.fromJson(response);
      return DataResponse.success(_product);
    } else {
      return DataResponse.error("error");
    }
  }

  Future<DataResponse<Cart>> addToCart(int productId) async {
    final response = await productDetailApiProvider.addToCart(productId);
    // if (response != null) {
    //   return DataResponse.error("No Response");
    // }

    if (response is Map) {
      final Cart _cart = Cart.fromJson(response);
      return DataResponse.success(_cart);
    } else {
      return DataResponse.error("error");
    }
  }
}
