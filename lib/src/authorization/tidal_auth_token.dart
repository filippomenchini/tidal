import 'package:equatable/equatable.dart';

class TidalAuthToken extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final DateTime createdAt;

  const TidalAuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.createdAt,
  });

  TidalAuthToken.fromJson({
    required Map<String, dynamic> json,
    required this.createdAt,
  })  : accessToken = json['access_token'],
        tokenType = json['token_type'],
        expiresIn = json['expires_in'];

  bool isTokenExpired(DateTime currentDate) {
    final expirationDate = createdAt.add(Duration(seconds: expiresIn));
    return currentDate.compareTo(expirationDate) > 0;
  }

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, createdAt];
}
