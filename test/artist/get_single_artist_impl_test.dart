import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/artist/get_single_artist_impl.dart';
import 'package:tidal/src/artist/tidal_artist.dart';
import 'package:tidal/src/artist/tidal_artist_error.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;

void main() {
  group('Given a getSingleArtist function', () {
    test(
        'Should throw TidalArtistError when status code is not 200 and not 400',
        () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '{  "errors": [    {      "category": "INVALID_REQUEST_ERROR",      "code": "NOT_FOUND",      "detail": "The requested resource (http://foo.bar/my-albums) could not be found"    }  ]}',
          404,
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
        await getSingleArtistImpl(
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

    test('Should throw BadRequestTidalArtistError when status code is 400',
        () async {
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
        await getSingleArtistImpl(
          client,
          tidalAuthToken: tidalAuthToken,
          id: id,
          countryCode: countryCode,
        );
      } catch (e) {
        // Assert
        expect(actualUrl, expectedUrl);
        expect(e.runtimeType, List<BadRequestTidalArtistError>);
      }
    });

    test('Should return an artist when status code is 200', () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '{  "resource": {    "id": "7804",    "name": "JAY Z",    "picture": [      {        "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",        "width": 80,        "height": 80      }    ]  }}',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const id = '7804';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/artists/7804?countryCode=US';
      const expectedResult = TidalArtist(
        id: id,
        name: 'JAY Z',
        picture: [
          TidalArtistPicture(
            url:
                "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
            width: 80,
            height: 80,
          ),
        ],
      );

      // Act
      final result = await getSingleArtistImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );

      // Assert
      expect(actualUrl, expectedUrl);
      expect(result, expectedResult);
    });
  });
}
