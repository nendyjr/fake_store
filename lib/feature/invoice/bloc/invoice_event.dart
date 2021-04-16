import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class Create extends InvoiceEvent {
  final String email;
  const Create({@required this.email});
  @override
  List<Object> get props => [email];

  @override
  String toString() => 'Create { email: $email }';
}
