import 'package:equatable/equatable.dart';

class TidalArtistError extends Equatable {
  final String category;
  final String code;
  final String detail;

  const TidalArtistError({
    required this.category,
    required this.code,
    required this.detail,
  });

  TidalArtistError.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        code = json['code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [category, code, detail];
}

class BadRequestTidalArtistError extends TidalArtistError {
  final String field;

  const BadRequestTidalArtistError({
    required this.field,
    required super.code,
    required super.category,
    required super.detail,
  });

  BadRequestTidalArtistError.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, field];
}
