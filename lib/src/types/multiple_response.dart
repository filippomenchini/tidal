import 'package:equatable/equatable.dart';

import 'multiple_response_item.dart';

class MultipleResponse<T> extends Equatable {
  final List<MultipleResponseItem<T>> items;
  final Map<String, dynamic> metadata;

  const MultipleResponse({
    required this.items,
    required this.metadata,
  });

  MultipleResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic> json) itemFactory,
  })  : items = (json["data"] as List)
            .map((e) => MultipleResponseItem.fromJson(
                json: e, itemFactory: itemFactory))
            .toList(),
        metadata = json["metadata"];

  @override
  List<Object?> get props => [metadata];
}
