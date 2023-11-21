import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/get_similar_albums_for_given_album_impl.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;

void main() {
  group('Given an album id and a contry code', () {
    test('Should return an list of similar album ids', () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "data": [    {      "resource": {        "id": "251380836"      }    }  ],  "metadata": {    "total": 10  }}''',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const id = '234815507';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/albums/234815507/similar?countryCode=US&offset=0&limit=10';
      final expectedResult = ['251380836'];

      // Act
      final result = await getSimilarAlbumsForGivenAlbumImpl(
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
