import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:tidal/src/artist/get_multiple_artists_impl.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;
import 'package:tidal/src/types/multiple_response.dart';
import 'package:tidal/src/types/multiple_response_item.dart';
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';

void main() {
  group('Given a list of artist ids', () {
    test('Should return multiple artists when status code is 207', () async {
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

      final expectedResult = MultipleResponse<TidalArtist>(
        items: [
          MultipleResponseItem<TidalArtist>(
            id: "7804",
            status: 200,
            message: "success",
            data: TidalArtist(
              id: "7804",
              name: "JAY Z",
              picture: [
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1024x256.jpg",
                  width: 1024,
                  height: 1024,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/1080x720.jpg",
                  width: 1080,
                  height: 1080,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x107.jpg",
                  width: 160,
                  height: 160,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/160x160.jpg",
                  width: 160,
                  height: 160,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x214.jpg",
                  width: 320,
                  height: 320,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/320x320.jpg",
                  width: 320,
                  height: 320,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/480x480.jpg",
                  width: 480,
                  height: 480,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/640x428.jpg",
                  width: 640,
                  height: 640,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x500.jpg",
                  width: 750,
                  height: 750,
                ),
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/a437c542/e9b5/4050/aced/c75ca0565c4f/750x750.jpg",
                  width: 750,
                  height: 750,
                ),
              ],
            ),
          ),
        ],
        metadata: {
          'requested': 1,
          'success': 1,
          'failure': 0,
        },
      );

      // Act
      final result = await getMultipleArtistsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

      // Assert
      expect(actualUrl, expectedUrl);
      expect(result, expectedResult);
      expect(result.items, expectedResult.items);
    });
  });
}
