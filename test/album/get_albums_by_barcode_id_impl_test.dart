import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/get_albums_by_barcode_id_impl.dart';
import 'package:tidal/src/album/tidal_album.dart';
import 'package:tidal/src/artist/tidal_artist.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';

void main() {
  group('Given a barcode id', () {
    test('Should return multiple tidal albums', () async {
      // Arrange
      String actualUrl = "";
      final client = MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "data": [    {      "resource": {        "id": "75413011",        "barcodeId": "00854242007552",        "title": "4:44",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "duration": 2777,        "releaseDate": "2017-06-30",        "imageCover": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "videoCover": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "numberOfVolumes": 1,        "numberOfTracks": 13,        "numberOfVideos": 0,        "type": "ALBUM",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "mediaMetadata": {          "tags": "HIRES_LOSSLESS"        },        "properties": {          "content": "explicit"        }      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "metadata": {    "requested": 10,    "success": 8,    "failure": 2  }}''',
          207,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      final barcodeId = '00854242007552';
      final expectedUrl =
          "https://openapi.tidal.com/albums/byBarcodeId?barcodeId=00854242007552&countryCode=US";
      final expectedResult = MultipleTidalAlbums(
        albumResponses: [
          TidalAlbumResponse(
            album: TidalAlbum(
              id: '75413011',
              barcodeId: "00854242007552",
              title: "4:44",
              duration: 2777,
              releaseDate: DateTime(2017, 6, 30),
              numberOfVolumes: 1,
              numberOfTracks: 13,
              numberOfVideos: 0,
              type: "ALBUM",
              copyright:
                  "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",
              artists: [
                TidalAlbumArtist(
                  main: true,
                  id: "7804",
                  name: "JAY Z",
                  picture: [
                    TidalArtistPicture(
                      url:
                          "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ],
              imageCover: [
                TidalImageCover(
                  url:
                      "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                  width: 80,
                  height: 80,
                ),
              ],
              videoCover: [
                TidalVideoCover(
                  url:
                      "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                  width: 80,
                  height: 80,
                ),
              ],
              mediaMetadata: TidalAlbumMetadata(tags: ["HIRES_LOSSLESS"]),
              properties: TidalAlbumProperties(content: ["explicit"]),
            ),
            id: "4328473",
            status: 200,
            message: "success",
          ),
        ],
        metadata: MultipleTidalAlbumsMetadata(metadata: {
          "requested": 10,
          "success": 8,
          "failure": 2,
        }),
      );

      // Act
      final result = await getAlbumsByBarcodeId(
        client,
        tidalAuthToken: tidalAuthToken,
        barcodeId: barcodeId,
        countryCode: 'US',
      );

      // Assert
      expect(actualUrl, expectedUrl);
      expect(result, expectedResult);
    });
  });
}
