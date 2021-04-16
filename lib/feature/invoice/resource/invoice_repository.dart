import 'package:meta/meta.dart';
import 'package:fake_store/common/constant/env.dart';
import 'package:fake_store/common/http/api_provider.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/invoice/model/invoice.dart';
import 'invoice_api_provider.dart';

class InvoiceRepository {
  ApiProvider apiProvider;
  InvoiceApiProvider invoiceApiProvider;
  Env env;

  InvoiceRepository({@required this.env, @required this.apiProvider}) {
    invoiceApiProvider =
        InvoiceApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<Invoice>> createNewInvoice(String email) async {
    var response = await invoiceApiProvider.createInvoice(email);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response['error']) {
      final Invoice _invoice =
          Invoice(id: response['id'], externalId: response['externalId']);
      return DataResponse.success(_invoice);
    } else {
      return DataResponse.error('error');
    }
  }
}
