import 'package:equatable/equatable.dart';

/// Represents an error related to a Tidal album operation.
class TidalAlbumError extends Equatable {
  final String category;
  final String code;
  final String detail;

  const TidalAlbumError({
    required this.category,
    required this.code,
    required this.detail,
  });

  /// Constructs a TidalAlbumError object from JSON data.
  TidalAlbumError.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        code = json['code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [category, code, detail];
}

/// Represents a specific type of Tidal album error indicating a bad request.
class BadRequestTidalAlbumError extends TidalAlbumError {
  final String field;

  const BadRequestTidalAlbumError({
    required this.field,
    required super.code,
    required super.category,
    required super.detail,
  });

  /// Constructs a BadRequestTidalAlbumError object from JSON data.
  BadRequestTidalAlbumError.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, field];
}
