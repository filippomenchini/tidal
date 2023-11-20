import 'package:equatable/equatable.dart';

import 'multiple_response_item.dart';

/// Represents a multiple response containing a list of items of type [T] and metadata.
///
/// A [MultipleResponse] consists of a list of [MultipleResponseItem] objects, each representing
/// an item within the response, and a metadata map.
///
/// This class is used to deserialize responses from APIs that return multiple items of type [T].
///
/// Parameters:
/// - [items]: A list of [MultipleResponseItem] objects, each containing an item of type [T].
/// - [metadata]: A map containing additional metadata related to the response.
class MultipleResponse<T> extends Equatable {
  final List<MultipleResponseItem<T>> items;
  final Map<String, dynamic>? metadata;

  const MultipleResponse({
    required this.items,
    this.metadata,
  });

  /// Creates a [MultipleResponse] from a JSON map, using the provided [itemFactory] function
  /// to convert the "resource" JSON data of each item into the specific type [T].
  ///
  /// Parameters:
  /// - [json]: The JSON map to deserialize.
  /// - [itemFactory]: A function that converts a JSON map into the specific type [T].
  MultipleResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic> json) itemFactory,
    String? itemsFieldName,
  })  : items = (json[itemsFieldName ?? "data"] as List)
            .map((e) => MultipleResponseItem.fromJson(
                json: e, itemFactory: itemFactory))
            .toList(),
        metadata = json["metadata"];

  @override
  List<Object?> get props => [metadata];
}
