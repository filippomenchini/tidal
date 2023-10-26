import 'package:equatable/equatable.dart';

class MultipleResponseItem<T> extends Equatable {
  final String id;
  final int status;
  final String message;
  final T data;

  const MultipleResponseItem({
    required this.id,
    required this.status,
    required this.message,
    required this.data,
  });

  MultipleResponseItem.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic> json) itemFactory,
  })  : id = json["id"],
        status = json["status"],
        message = json["message"],
        data = itemFactory(json["resource"]);

  @override
  List<Object?> get props => [id, status, message, data];
}
