import 'package:equatable/equatable.dart';

/// Represents a Tidal authentication token with its associated properties.
class TidalAuthToken extends Equatable {
  /// The access token obtained during authentication.
  final String accessToken;

  /// The type of the token (e.g., "bearer").
  final String tokenType;

  /// The duration (in seconds) for which the token is valid.
  final int expiresIn;

  /// The date and time when the token was created.
  final DateTime createdAt;

  const TidalAuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.createdAt,
  });

  /// Constructs a TidalAuthToken object from JSON data and a specified creation date.
  TidalAuthToken.fromJson({
    required Map<String, dynamic> json,
    required this.createdAt,
  })  : accessToken = json['access_token'],
        tokenType = json['token_type'],
        expiresIn = json['expires_in'];

  /// Checks whether the token has expired based on the current date.
  ///
  /// Returns `true` if the token has expired, and `false` otherwise.
  bool isTokenExpired(DateTime currentDate) {
    final expirationDate = createdAt.add(Duration(seconds: expiresIn));
    return currentDate.compareTo(expirationDate) > 0;
  }

  /// Retrieves the token as an HTTP authorization header.
  ///
  /// Returns a map with the token in the format: {'Authorization': 'Bearer $accessToken'}.
  Map<String, String> get header => {'Authorization': 'Bearer $accessToken'};

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, createdAt];
}
