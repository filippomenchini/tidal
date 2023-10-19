import 'package:test/test.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';

void main() {
  group('Given a TidalAuthToken', () {
    test('Should return true when token is expired', () {
      // Arrange
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2022),
      );

      // Act
      final result = tidalAuthToken.isTokenExpired(DateTime(2023));

      // Assert
      expect(result, true);
    });

    test('Should return false when token is not expired', () {
      // Arrange
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023, 10, 18, 17),
      );

      // Act
      final result = tidalAuthToken.isTokenExpired(DateTime(2023, 10, 19, 16));

      // Assert
      expect(result, false);
    });
  });
}
