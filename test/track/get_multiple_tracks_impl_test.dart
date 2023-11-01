import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:tidal/src/track/get_multiple_tracks_impl.dart';
import 'package:tidal/src/types/multiple_response.dart';
import 'package:tidal/src/types/multiple_response_item.dart';
import 'package:tidal/src/types/tidal_album.dart';
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';
import 'package:tidal/src/types/tidal_media.dart';

void main() {
  group('Given a list of ids and a country code', () {
    test('Should return a list of tracks', () async {
      // Arrange
      String actualUrl = '';
      final client = MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "data": [    {      "resource": {        "properties": {          "content": "explicit",          "additionalProp1": [            "string"          ],          "additionalProp2": [            "string"          ],          "additionalProp3": [            "string"          ]        },        "id": "75413012",        "version": "Deluxe Edition",        "duration": 178,        "album": {          "id": "75413011",          "title": "4:44",          "imageCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ],          "videoCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ]        },        "title": "Kill Jay Z",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "trackNumber": 1,        "volumeNumber": 1,        "isrc": "QMJMT1701229",        "providerId": "string",        "albumId": "string",        "artifactType": "string",        "mediaMetadata": {          "tags": "HIRES_LOSSLESS"        }      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "metadata": {    "total": 10  }}''',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const ids = ["75413012"];
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/tracks?ids=75413012&countryCode=US';
      final expectedResult = MultipleResponse(
        items: [
          MultipleResponseItem(
            id: "4328473",
            status: 200,
            message: "success",
            data: TidalMedia(
              id: "75413012",
              version: "Deluxe Edition",
              duration: 178,
              title: "Kill Jay Z",
              copyright:
                  "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",
              artists: [
                TidalMediaArtist(
                  main: true,
                  id: "7804",
                  name: "JAY Z",
                  picture: [
                    TidalImage(
                      url:
                          "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ],
              album: TidalBaseAlbum(
                id: "75413011",
                title: "4:44",
                imageCover: [
                  TidalImage(
                    url:
                        "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                    width: 80,
                    height: 80,
                  ),
                ],
                videoCover: [
                  TidalImage(
                    url:
                        "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                    width: 80,
                    height: 80,
                  ),
                ],
              ),
              trackNumber: 1,
              volumeNumber: 1,
              isrc: "QMJMT1701229",
              providerId: "string",
              albumId: "string",
              artifactType: "string",
              properties: {
                "content": "explicit",
                "additionalProp1": ["string"],
                "additionalProp2": ["string"],
                "additionalProp3": ["string"]
              },
              mediaMetadata: {"tags": "HIRES_LOSSLESS"},
            ),
          ),
        ],
        metadata: {'total': 10},
      );

      // Act
      final result = await getMultipleTracksImpl(
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
