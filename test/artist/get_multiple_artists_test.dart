import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:tidal/src/artist/get_multiple_artists.dart';
import 'package:tidal/src/artist/tidal_artist.dart';
import 'package:tidal/src/artist/tidal_artist_error.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;

void main() {
  group('Given a getMultipleArtists function', () {
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
      const ids = [
        '7804',
        '1566',
        '1000',
      ];
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/artists?ids=7804&ids=1566&ids=1000&countryCode=US';

      // Act
      try {
        await getMultipleArtists(
          client,
          tidalAuthToken: tidalAuthToken,
          ids: ids,
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
      const ids = [
        '7804',
        '1566',
        '1000',
      ];
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/artists?ids=7804&ids=1566&ids=1000&countryCode=US';

      // Act
      try {
        await getMultipleArtists(
          client,
          tidalAuthToken: tidalAuthToken,
          ids: ids,
          countryCode: countryCode,
        );
      } catch (e) {
        // Assert
        expect(actualUrl, expectedUrl);
        expect(e.runtimeType, List<BadRequestTidalArtistError>);
      }
    });

    test('Should return an artist when status code is 207', () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '{  "data": [    {      "resource": {        "id": "7804",        "name": "JAY Z",        "picture": [          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1024x256.jpg",            "width": 1024,            "height": 256          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1080x720.jpg",            "width": 1080,            "height": 720          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x107.jpg",            "width": 160,            "height": 107          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x160.jpg",            "width": 160,            "height": 160          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x214.jpg",            "width": 320,            "height": 214          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x320.jpg",            "width": 320,            "height": 320          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/480x480.jpg",            "width": 480,            "height": 480          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/640x428.jpg",            "width": 640,            "height": 428          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x500.jpg",            "width": 750,            "height": 500          },          {            "url": "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x750.jpg",            "width": 750,            "height": 750          }        ]      },      "id": "7804",      "status": 200,      "message": "success"    }  ],  "metadata": {    "requested": 1,    "success": 1,    "failure": 0  }}',
          207,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const ids = [
        '7804',
      ];
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/artists?ids=7804&countryCode=US';

      const expectedResult = MultipleTidalArtists(
        artistResponses: [
          TidalArtistResponse(
            id: "7804",
            status: 200,
            message: "success",
            artist: TidalArtist(
              id: "7804",
              name: "JAY Z",
              picture: [
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1024x256.jpg",
                  width: 1024,
                  height: 256,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1080x720.jpg",
                  width: 1080,
                  height: 720,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x107.jpg",
                  width: 160,
                  height: 107,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x160.jpg",
                  width: 160,
                  height: 160,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x214.jpg",
                  width: 320,
                  height: 214,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x320.jpg",
                  width: 320,
                  height: 320,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/480x480.jpg",
                  width: 480,
                  height: 480,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/640x428.jpg",
                  width: 640,
                  height: 428,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x500.jpg",
                  width: 750,
                  height: 500,
                ),
                TidalArtistPicture(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x750.jpg",
                  width: 750,
                  height: 750,
                ),
              ],
            ),
          ),
        ],
        metadata: MultipleTidalArtistsMetadata(
          requested: 1,
          success: 1,
          failure: 0,
        ),
      );

      // Act
      final result = await getMultipleArtists(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

      // Assert
      expect(actualUrl, expectedUrl);
      expect(result, expectedResult);
    });
  });
}
