import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fake_store/common/http/response.dart';
import 'package:fake_store/feature/invoice/bloc/index.dart';
import 'package:fake_store/feature/invoice/model/invoice.dart';
import 'package:fake_store/feature/invoice/resource/invoice_repository.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceRepository invoiceRepository;

  InvoiceBloc({@required this.invoiceRepository})
      : assert(invoiceRepository != null),
        super(InvoiceEmpty());

  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async* {
    final InvoiceState currentState = state;

    if (event is Create) {
      try {
        if (currentState is InvoiceEmpty) {
          yield InvoiceLoading();
          final Invoice invoice = await _createInvoice(event.email);
        }
      } catch (_) {
        yield InvoiceError();
      }
    }
  }

  Future<Invoice> _createInvoice(String email) async {
    final response = await invoiceRepository.createNewInvoice(email);
    if (response.status == Status.Success) {
      return response.data;
    }
    return null;
  }
}
