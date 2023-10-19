import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/artist/get_single_artist.dart';
import 'package:tidal/src/artist/tidal_artist_error.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;

void main() {
  group('Given a getSingleArtist function', () {
    test('Should throw error when status code is not 200', () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '{  "errors": [    {      "category": "INVALID_REQUEST_ERROR",      "code": "INVALID_ENUM_VALUE",      "detail": "country code must be in ISO2 format",      "field": "countryCode"    },    {      "category": "INVALID_REQUEST_ERROR",      "code": "VALUE_REGEX_MISMATCH",      "detail": "barcode should have a valid EAN-13 or UPC-A format",      "field": "barcodeId"    }  ]}',
          400,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const id = '1566';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/artists/1566?countryCode=US';

      // Act
      try {
        await getSingleArtist(
          client,
          tidalAuthToken: tidalAuthToken,
          id: id,
          countryCode: countryCode,
        );
      } catch (e) {
        // Assert
        expect(actualUrl, expectedUrl);
        expect(e.runtimeType, List<TidalArtistError>);
      }
    });
  });
}
