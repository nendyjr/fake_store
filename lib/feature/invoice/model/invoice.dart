import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

class Invoice extends Equatable {  
  final String id;
  final String externalId;

  Invoice({this.id, this.externalId});
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(id : json['id'] as String,
    externalId : json['external_id'] as String);
  }
  // Equatable
  @override
  List<Object> get props => [id, externalId];

  @override
  String toString() => 'Post { id: $id }';
}
