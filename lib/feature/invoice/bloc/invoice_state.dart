import 'package:equatable/equatable.dart';
import 'package:fake_store/feature/invoice/model/invoice.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceEmpty extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceError extends InvoiceState {}

class InvoiceCreated extends InvoiceState {
  final Invoice invoice;

  const InvoiceCreated({this.invoice});

  @override
  List<Object> get props => [invoice];

  @override
  String toString() => 'Invoice created { Invoice Id: ${invoice.id} }';
}
