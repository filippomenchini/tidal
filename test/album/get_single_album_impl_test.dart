import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/get_single_album_impl.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;
import 'package:tidal/src/types/tidal_album.dart';
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';

void main() {
  group('Given an album id and a contry code', () {
    test('Should return an album when status code is 200', () async {
      // Arrange
      String actualUrl = '';
      final client = http_testing.MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '{  "resource": {    "id": "234815507",    "barcodeId": "196626707819",    "title": "Drill Music in Zion",    "artists": [      {        "id": "15356",        "name": "Lupe Fiasco",        "picture": [          {            "url": "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1024x256.jpg",            "width": 1024,            "height": 256          },          {            "url": "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1080x720.jpg",            "width": 1080,            "height": 720          }        ],        "main": true      }    ],    "duration": 2457,    "releaseDate": "2022-06-24",    "imageCover": [      {        "url": "https://resources.tidal.com/images/c580b6f1/4768/471d/a198/900c6f09570d/1080x1080.jpg",        "width": 1080,        "height": 1080      }    ],    "videoCover": [],    "numberOfVolumes": 1,    "numberOfTracks": 10,    "numberOfVideos": 0,    "type": "ALBUM",    "copyright": "(C) 2022 1st and 15th Too marketed and distributed by Thirty Tigers",    "mediaMetadata": {      "tags": [        "HIRES_LOSSLESS",        "LOSSLESS"      ]    },    "properties": {      "content": [        "explicit"      ]    }  }}',
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
          'https://openapi.tidal.com/albums/234815507?countryCode=US';
      final expectedResult = TidalAlbum(
        id: '234815507',
        barcodeId: '196626707819',
        title: "Drill Music in Zion",
        duration: 2457,
        releaseDate: DateTime(2022, 6, 24),
        numberOfVolumes: 1,
        numberOfTracks: 10,
        numberOfVideos: 0,
        type: "ALBUM",
        copyright:
            "(C) 2022 1st and 15th Too marketed and distributed by Thirty Tigers",
        artists: [
          TidalMediaArtist(
            main: true,
            id: "15356",
            name: "Lupe Fiasco",
            picture: [
              TidalImage(
                url:
                    "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1024x256.jpg",
                width: 1024,
                height: 1024,
              ),
              TidalImage(
                url:
                    "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1080x720.jpg",
                width: 1080,
                height: 1080,
              ),
            ],
          ),
        ],
        imageCover: [
          TidalImage(
            url:
                "https://resources.tidal.com/images/c580b6f1/4768/471d/a198/900c6f09570d/1080x1080.jpg",
            width: 1080,
            height: 1080,
          ),
        ],
        videoCover: [],
        mediaMetadata: {
          'tags': ["HIRES_LOSSLESS", "LOSSLESS"]
        },
        properties: {
          'content': ['explicit']
        },
      );
      // Act
      final result = await getSingleAlbumImpl(
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
