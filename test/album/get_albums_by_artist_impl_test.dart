import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/get_albums_by_artist_impl.dart';
import 'package:tidal/src/album/tidal_album.dart';
import 'package:tidal/src/artist/tidal_artist.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';

void main() {
  group('Given an artist id, a country code an optional query params', () {
    test('Should return multiple artists', () async {
      // Arrange
      String actualUrl = '';
      final client = MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "data": [    {      "resource": {        "id": "304761400",        "barcodeId": "197189404849",        "title": "Roc-A-Fella Y'all",        "artists": [          {            "id": "15356",            "name": "Lupe Fiasco",            "picture": [              {                "url": "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1024x256.jpg",                "width": 1024,                "height": 256              }            ],            "main": true          }        ],        "duration": 300,        "releaseDate": "2023-07-21",        "imageCover": [          {            "url": "https://resources.tidal.com/images/c2a0cf9c/0597/4bda/b615/a94cbeec71a6/1080x1080.jpg",            "width": 1080,            "height": 1080          }        ],        "videoCover": [],        "numberOfVolumes": 1,        "numberOfTracks": 1,        "numberOfVideos": 0,        "type": "SINGLE",        "copyright": "(C) 2023 1st and 15th Too marketed and distributed by Thirty Tigers",        "mediaMetadata": {          "tags": [            "HIRES_LOSSLESS",            "LOSSLESS"          ]        },        "properties": {          "content": [            "explicit"          ]        }      },      "id": "304761400",      "status": 200,      "message": "success"    }  ],  "metadata": {    "total": 1  }}''',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const id = '15356';
      const countryCode = 'US';
      const limit = 1;
      const expectedUrl =
          'https://openapi.tidal.com/artists/15356/albums?countryCode=US';
      final expectedResult = MultipleTidalAlbums(
        albumResponses: [
          TidalAlbumResponse(
            album: TidalAlbum(
              id: "304761400",
              barcodeId: "197189404849",
              title: "Roc-A-Fella Y'all",
              duration: 300,
              releaseDate: DateTime(2023, 07, 21),
              numberOfVolumes: 1,
              numberOfTracks: 1,
              numberOfVideos: 0,
              type: "SINGLE",
              copyright:
                  "(C) 2023 1st and 15th Too marketed and distributed by Thirty Tigers",
              artists: [
                TidalAlbumArtist(
                  main: true,
                  id: "15356",
                  name: "Lupe Fiasco",
                  picture: [
                    TidalArtistPicture(
                      url:
                          "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1024x256.jpg",
                      width: 1024,
                      height: 256,
                    ),
                  ],
                ),
              ],
              imageCover: [
                TidalImageCover(
                  url:
                      "https://resources.tidal.com/images/c2a0cf9c/0597/4bda/b615/a94cbeec71a6/1080x1080.jpg",
                  width: 1080,
                  height: 1080,
                ),
              ],
              videoCover: [],
              mediaMetadata: TidalAlbumMetadata(
                tags: ["HIRES_LOSSLESS", "LOSSLESS"],
              ),
              properties: TidalAlbumProperties(
                content: ["explicit"],
              ),
            ),
            id: "304761400",
            status: 200,
            message: "success",
          ),
        ],
        metadata: MultipleTidalAlbumsMetadata(metadata: {"total": 1}),
      );

      // Act
      final result = await getAlbumsByArtistImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        artistId: id,
        countryCode: countryCode,
        limit: limit,
      );

      // Assert
      expect(actualUrl.startsWith(expectedUrl), true);
      expect(result, expectedResult);
    });
  });
}
