import 'package:equatable/equatable.dart';

/// Represents an error item in the Tidal service.
///
/// A [TidalErrorItem] contains information about an error, including its category, code, and detail.
///
/// This class is used to represent error data retrieved from the Tidal service.
///
/// Parameters:
/// - [category]: The category of the error.
/// - [code]: The error code.
/// - [detail]: Additional details about the error.
class TidalErrorItem extends Equatable {
  final String category;
  final String code;
  final String detail;

  const TidalErrorItem({
    required this.category,
    required this.code,
    required this.detail,
  });

  /// Constructs a TidalErrorItem object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing error data.
  TidalErrorItem.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        code = json['code'],
        detail = json['detail'];

  @override
  List<Object?> get props => [category, code, detail];
}

/// Represents a bad request error item in the Tidal service.
///
/// A [BadRequestTidalErrorItem] extends [TidalErrorItem] to include information about the error field.
///
/// This class is used to represent bad request error data retrieved from the Tidal service.
///
/// Parameters:
/// - [field]: The specific field related to the error.
class BadRequestTidalErrorItem extends TidalErrorItem {
  final String field;

  const BadRequestTidalErrorItem({
    required this.field,
    required super.code,
    required super.category,
    required super.detail,
  });

  /// Constructs a BadRequestTidalErrorItem object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing error data.
  BadRequestTidalErrorItem.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, field];
}

/// Represents a Tidal error response.
///
/// A [TidalError] contains a list of error items, which can be of type [TidalErrorItem] or [BadRequestTidalErrorItem].
///
/// This class is used to represent error responses retrieved from the Tidal service.
///
/// Parameters:
/// - [errors]: The list of error items.
class TidalError<T extends TidalErrorItem> extends Equatable {
  final List<T> errors;

  const TidalError({required this.errors});

  @override
  List<Object?> get props => [errors];
}
