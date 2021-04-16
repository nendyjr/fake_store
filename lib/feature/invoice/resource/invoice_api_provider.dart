import 'dart:async';
import 'dart:convert';

import 'package:fake_store/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class InvoiceApiProvider {
  ApiProvider apiProvider;
  final String baseUrl;
  InvoiceApiProvider({@required this.baseUrl, @required this.apiProvider});

  Future<dynamic> createInvoice(String email) async {
    try {
      var params = json.encode({'payer_email': email, 'amount': 10000});
      return this
          .apiProvider
          .post('$baseUrl/v2/invoices', params, token: '134kjadkf');
    } on Error catch (e) {
      throw Exception('Failed to load post' + e.toString());
    }
  }
}
