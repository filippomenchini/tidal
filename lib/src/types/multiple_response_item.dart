import 'package:equatable/equatable.dart';

/// Represents an item within a multiple response, such as a list of items from an API response.
///
/// A [MultipleResponseItem] contains an ID, status, a message, and the actual data of type [T].
///
/// This class is typically used to deserialize items within a multiple response, with the [itemFactory]
/// parameter being used to convert the JSON data into the specific type [T].
///
/// Parameters:
/// - [id]: The unique identifier for the item.
/// - [status]: The status code associated with the item.
/// - [message]: A message related to the item.
/// - [data]: The data associated with the item, of type [T].
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

  /// Creates a [MultipleResponseItem] from a JSON map, using the provided [itemFactory] function
  /// to convert the "resource" JSON data into the specific type [T].
  ///
  /// Parameters:
  /// - [json]: The JSON map to deserialize.
  /// - [itemFactory]: A function that converts a JSON map into the specific type [T].
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
