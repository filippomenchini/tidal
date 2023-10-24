import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/get_single_album_impl.dart';
import 'package:tidal/src/album/tidal_album.dart';
import 'package:tidal/src/album/tidal_album_error.dart';
import 'package:tidal/src/artist/tidal_artist.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:http/testing.dart' as http_testing;

void main() {
  group('Given a getSingleAlbum function', () {
    test('Should throw TidalAlbumError when status code is not 200 and not 400',
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
      const id = '234815507';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/albums/234815507?countryCode=US';

      // Act
      try {
        await getSingleAlbumImpl(
          client,
          tidalAuthToken: tidalAuthToken,
          id: id,
          countryCode: countryCode,
        );
      } catch (e) {
        // Assert
        expect(actualUrl, expectedUrl);
        expect(e.runtimeType, List<TidalAlbumError>);
      }
    });

    test('Should throw BadRequestTidalAlbumError when status code is 400',
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
      const id = '234815507';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/albums/234815507?countryCode=US';

      // Act
      try {
        await getSingleAlbumImpl(
          client,
          tidalAuthToken: tidalAuthToken,
          id: id,
          countryCode: countryCode,
        );
      } catch (e) {
        // Assert
        expect(actualUrl, expectedUrl);
        expect(e.runtimeType, List<BadRequestTidalAlbumError>);
      }
    });

    test('Should return an artist when status code is 200', () async {
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
              TidalArtistPicture(
                url:
                    "https://resources.tidal.com/images/bae5a813/8e6c/4655/9f5b/659d27a843b5/1080x720.jpg",
                width: 1080,
                height: 720,
              ),
            ],
          ),
        ],
        imageCover: [
          TidalImageCover(
            url:
                "https://resources.tidal.com/images/c580b6f1/4768/471d/a198/900c6f09570d/1080x1080.jpg",
            width: 1080,
            height: 1080,
          ),
        ],
        videoCover: [],
        mediaMetadata: TidalAlbumMetadata(tags: ["HIRES_LOSSLESS", "LOSSLESS"]),
        properties: TidalAlbumProperties(content: ['explicit']),
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
