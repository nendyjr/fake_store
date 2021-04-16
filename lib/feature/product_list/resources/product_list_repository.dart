import 'package:meta/meta.dart';

import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/product_list/model/product.dart';
import 'product_list_api_provider.dart';

class ProductListRepository {
  ApiProvider apiProvider;
  ProductListApiProvider productListApiProvider;
  Env env;

  ProductListRepository({this.apiProvider, this.env}) {
    productListApiProvider =
        ProductListApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<List<Product>>> fetchProducts(String category) async {
    final response = await productListApiProvider.fetchProducts(category);
    if (response == null) {
      return DataResponse.error("No Response");
    }

    if (response is List) {
      final List<Product> _products = (response)?.map((dynamic e) {
        return e == null ? null : Product.fromJson(e as Map<String, dynamic>);
      })?.toList();
      return DataResponse.success(_products);
    } else {
      return DataResponse.error("error");
    }
  }

  Future<DataResponse<List<String>>> fetchCategories() async {
    final response = await productListApiProvider.fetchCategories();
    if (response == null) {
      return DataResponse.error("No Response");
    }

    if (response is List) {
      final List<String> _categories = (response)?.map((dynamic e) {
        return e == null ? null : e.toString();
      })?.toList();
      return DataResponse.success(_categories);
    } else {
      return DataResponse.error("error");
    }
  }
}
