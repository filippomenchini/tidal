import 'package:equatable/equatable.dart';

/// Represents an error related to a Tidal artist operation.
class TidalArtistError extends Equatable {
  final String category;
  final String code;
  final String detail;

  const TidalArtistError({
    required this.category,
    required this.code,
    required this.detail,
  });

  /// Constructs a TidalArtistError object from JSON data.
  TidalArtistError.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        code = json['code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [category, code, detail];
}

/// Represents a specific type of Tidal artist error indicating a bad request.
class BadRequestTidalArtistError extends TidalArtistError {
  final String field;

  const BadRequestTidalArtistError({
    required this.field,
    required super.code,
    required super.category,
    required super.detail,
  });

  /// Constructs a BadRequestTidalArtistError object from JSON data.
  BadRequestTidalArtistError.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, field];
}
