import 'package:equatable/equatable.dart';

class TidalErrorItem extends Equatable {
  final String category;
  final String code;
  final String detail;

  const TidalErrorItem({
    required this.category,
    required this.code,
    required this.detail,
  });

  TidalErrorItem.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        code = json['code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [category, code, detail];
}

class BadRequestTidalErrorItem extends TidalErrorItem {
  final String field;

  const BadRequestTidalErrorItem({
    required this.field,
    required super.code,
    required super.category,
    required super.detail,
  });

  BadRequestTidalErrorItem.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, field];
}

class TidalError<T extends TidalErrorItem> extends Equatable {
  final List<T> errors;

  const TidalError({required this.errors});

  @override
  List<Object?> get props => [errors];
}
