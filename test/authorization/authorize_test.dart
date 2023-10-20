import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:http/testing.dart' as http_testing;
import 'package:tidal/src/authorization/authorize.dart';
import 'package:tidal/src/authorization/tidal_auth_error.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';

void main() {
  group('Given an authorize function', () {
    test('Should throw a TidalAuthError when status code isn\'t 200', () async {
      // Arrange
      final client = http_testing.MockClient(
        (_) async => Response('error', 500),
      );

      // Act
      try {
        await authorize(
          client,
          clientId: 'clientId',
          clientSecret: 'clientSecret',
          currentDateTime: DateTime(2023),
        );
        fail('Should have thrown a TidalAuthError');
      } catch (e) {
        // Assert
        expect(e, TidalAuthError(errorCode: '500', errorMessage: 'error'));
      }
    });

    test('Should return a TidalAuthToken when status code is 200', () async {
      // Arrange
      final client = http_testing.MockClient(
        (_) async => Response(
          '{ "access_token": "a_token", "token_type": "Bearer", "expires_in": 86400 }',
          200,
        ),
      );
      final currentDateTime = DateTime(2023);

      final expected = TidalAuthToken(
        accessToken: "a_token",
        tokenType: "Bearer",
        expiresIn: 86400,
        createdAt: currentDateTime,
      );

      // Act
      final result = await authorize(
        client,
        clientId: 'clientId',
        clientSecret: 'clientSecret',
        currentDateTime: currentDateTime,
      );

      // Assert
      expect(result, expected);
    });
  });
}
