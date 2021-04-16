import 'dart:async';
import 'package:meta/meta.dart';
import 'package:fake_store/common/http/api_provider.dart';

class ProductListApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  ProductListApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  Future<dynamic> fetchProducts(String category) {
    print("FetchProducts");
    if (category.length == 0 || category.toLowerCase() == 'all') {
      return apiProvider.get('$baseUrl/products');
    } else {
      return apiProvider.get('$baseUrl/products/category/$category');
    }
  }

  Future<dynamic> fetchCategories() {
    print("Fetch Categories");
    return apiProvider.get('$baseUrl/products/categories');
  }
}
