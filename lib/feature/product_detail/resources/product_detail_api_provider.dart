import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:fake_store/common/http/api_provider.dart';

class ProductDetailApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  ProductDetailApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<dynamic> fetchProduct(int productId) {
    print("fetchProduct");
    return apiProvider.get('$baseUrl/products/$productId');
  }

  Future<dynamic> addToCart(int productId) {
    print("add to cart");
    const params = {
      "userId": 3,
      "date": '2021-04-15',
      "products": [
        {"productId": 5, "quantity": 1}
      ]
    };
    return apiProvider.post('$baseUrl/carts', jsonEncode(params));
  }
}
