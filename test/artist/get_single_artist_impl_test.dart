import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/artist/get_single_artist_impl.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';

void main() {
  group('Given a getSingleArtist function', () {
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
      final expectedResult = TidalArtist(
        id: id,
        name: 'JAY Z',
        picture: [
          TidalImage(
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
