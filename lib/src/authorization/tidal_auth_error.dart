import 'package:equatable/equatable.dart';

/// Represents an error that can occur during Tidal authentication.
class TidalAuthError extends Equatable {
  /// The error code associated with the authentication error.
  final String errorCode;

  /// A message describing the authentication error.
  final String errorMessage;

  const TidalAuthError({
    required this.errorCode,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorCode, errorMessage];
}
