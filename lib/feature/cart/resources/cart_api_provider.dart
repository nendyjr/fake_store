import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:fake_store/common/http/api_provider.dart';

class CartApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  CartApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<dynamic> fetchCart(int userId) {
    print("fetch cart");
    return apiProvider.get('$baseUrl/carts/user/$userId');
  }

  Future<dynamic> cartRemoveItem(int productId, int cartId) {
    print("fetchProduct");
    const params = {
      "userId": 3,
      "date": '2021-04-15',
      "products": [
        {"productId": 5, "quantity": 1}
      ]
    };
    return apiProvider.put('$baseUrl/carts', jsonEncode(params));
  }
}
