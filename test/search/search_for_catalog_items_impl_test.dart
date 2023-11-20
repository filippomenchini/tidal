import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:tidal/src/search/search_api.dart';
import 'package:tidal/src/search/search_for_catalog_items_impl.dart';
import 'package:tidal/src/types/multiple_response.dart';
import 'package:tidal/src/types/multiple_response_item.dart';
import 'package:tidal/src/types/tidal_album.dart';
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';
import 'package:tidal/src/types/tidal_media.dart';
import 'package:tidal/src/types/tidal_search_response.dart';

void main() {
  group('Given a search query', () {
    test('Should return a dataset of searched items', () async {
      // Arrange
      String actualUrl = '';
      final client = MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "albums": [    {      "resource": {        "id": "75413011",        "barcodeId": "00854242007552",        "title": "4:44",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "duration": 2777,        "releaseDate": "2017-06-30",        "imageCover": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "videoCover": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "numberOfVolumes": 1,        "numberOfTracks": 13,        "numberOfVideos": 0,        "type": "ALBUM",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "mediaMetadata": {          "tags": "HIRES_LOSSLESS"        },        "properties": {          "content": "explicit"        }      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "artists": [    {      "resource": {        "id": "7804",        "name": "JAY Z",        "picture": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ]      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "tracks": [    {      "resource": {        "id": "75623239",        "title": "Kill Jay Z",        "version": "Kill Jay Z",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "album": {          "id": "75413011",          "title": "4:44",          "imageCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ],          "videoCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ]        },        "duration": 30,        "trackNumber": 30,        "volumeNumber": 30,        "isrc": "TIDAL2274",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "mediaMetadata": {          "tags": "HIRES_LOSSLESS"        },        "properties": {          "content": "explicit"        },        "artifactType": "string"      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "videos": [    {      "resource": {        "id": "75623239",        "title": "Kill Jay Z",        "version": "Kill Jay Z",        "image": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "album": {          "id": "75413011",          "title": "4:44",          "imageCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ],          "videoCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ]        },        "releaseDate": "2017-06-27",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "duration": 30,        "trackNumber": 30,        "volumeNumber": 30,        "isrc": "TIDAL2274",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "properties": {          "video-type": "live-stream",          "content": "explicit"        },       "artifactType": "string"      },      "id": "4328473",      "status": 200,      "message": "success"    }  ]}''',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const query = 'jayz';
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/search?query=jayz&offset=0&limit=10&countryCode=US&popularity=WORLDWIDE';

      final expectedImage = TidalImage(
        url:
            "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
        width: 80,
        height: 80,
      );
      final expectedArtist = TidalMediaArtist(
        main: true,
        id: "7804",
        name: "JAY Z",
        picture: [
          expectedImage,
        ],
      );
      final expectedAlbum = TidalAlbum(
        id: "75413011",
        barcodeId: "00854242007552",
        title: "4:44",
        duration: 2777,
        releaseDate: DateTime(2017, 06, 30),
        numberOfVolumes: 1,
        numberOfTracks: 13,
        numberOfVideos: 0,
        type: "ALBUM",
        copyright:
            "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",
        artists: [
          expectedArtist,
        ],
        imageCover: [expectedImage],
        videoCover: [expectedImage],
        mediaMetadata: {"tags": "HIRES_LOSSLESS"},
        properties: {"content": "explicit"},
      );

      final expectedMedia = TidalMedia(
        id: '75623239',
        version: 'Kill Jay Z',
        duration: 30,
        title: 'Kill Jay Z',
        copyright:
            "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",
        artists: [expectedArtist],
        album: expectedAlbum,
        trackNumber: 30,
        volumeNumber: 30,
        isrc: "TIDAL2274",
        providerId: "string",
        albumId: "string",
        artifactType: "string",
        properties: {
          "content": "explicit",
        },
        mediaMetadata: {"tags": "HIRES_LOSSLESS"},
      );

      final expectedResult = TidalSearchResponse(
        albums: MultipleResponse(
          items: [
            MultipleResponseItem(
              id: "4328473",
              status: 200,
              message: "success",
              data: expectedAlbum,
            ),
          ],
        ),
        artists: MultipleResponse(
          items: [
            MultipleResponseItem(
              id: "4328473",
              status: 200,
              message: "success",
              data: expectedArtist,
            ),
          ],
        ),
        tracks: MultipleResponse(
          items: [
            MultipleResponseItem(
              id: "4328473",
              status: 200,
              message: "success",
              data: expectedMedia,
            ),
          ],
        ),
        videos: MultipleResponse(
          items: [
            MultipleResponseItem(
              id: "4328473",
              status: 200,
              message: "success",
              data: expectedMedia,
            ),
          ],
        ),
      );

      // Act
      final result = await searchForCatalogItemsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        query: query,
        countryCode: countryCode,
        popularity: TidalSearchPopularity.WORLDWIDE,
      );
      // Assert
      expect(actualUrl, expectedUrl);
      expect(result, expectedResult);
    });
  });
}
