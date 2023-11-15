import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:tidal/src/authorization/tidal_auth_token.dart';
import 'package:tidal/src/types/multiple_response.dart';
import 'package:tidal/src/types/multiple_response_item.dart';
import 'package:tidal/src/types/tidal_album.dart';
import 'package:tidal/src/types/tidal_artist.dart';
import 'package:tidal/src/types/tidal_image.dart';
import 'package:tidal/src/types/tidal_media.dart';
import 'package:tidal/src/video/get_multiple_videos_impl.dart';

void main() {
  group('Given a list of ids and a country code', () {
    test('Should return a list of videos', () async {
      // Arrange
      String actualUrl = '';
      final client = MockClient((request) async {
        actualUrl = request.url.toString();
        return Response(
          '''{  "data": [    {      "resource": {        "properties": {          "video-type": "live-stream",          "content": "explicit",          "additionalProp1": [            "string"          ],          "additionalProp2": [            "string"          ],          "additionalProp3": [            "string"          ]        },        "id": "75623239",        "version": "Kill Jay Z",        "duration": 30,        "trackNumber": 30,        "album": {          "id": "75413011",          "title": "4:44",          "imageCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ],          "videoCover": [            {              "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",              "width": 80,              "height": 80            }          ]        },        "title": "Kill Jay Z",        "artists": [          {            "id": "7804",            "name": "JAY Z",            "picture": [              {                "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",                "width": 80,                "height": 80              }            ],            "main": true          }        ],        "volumeNumber": 30,        "isrc": "TIDAL2274",        "copyright": "(p)(c) 2017 S. CARTER ENTERPRISES, LLC. MARKETED BY ROC NATION & DISTRIBUTED BY ROC NATION/UMG RECORDINGS INC.",        "providerId": "string",        "albumId": "string",        "artifactType": "string",        "image": [          {            "url": "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",            "width": 80,            "height": 80          }        ],        "releaseDate": "2017-06-27"      },      "id": "4328473",      "status": 200,      "message": "success"    }  ],  "metadata": {    "requested": 10,    "success": 8,    "failure": 2  }}''',
          200,
        );
      });
      final tidalAuthToken = TidalAuthToken(
        accessToken: 'accessToken',
        tokenType: 'tokenType',
        expiresIn: 86400,
        createdAt: DateTime(2023),
      );
      const ids = ["75623239"];
      const countryCode = 'US';
      const expectedUrl =
          'https://openapi.tidal.com/videos?ids=75623239&countryCode=US';
      final expectedResult = MultipleResponse(
        items: [
          MultipleResponseItem(
            id: "4328473",
            status: 200,
            message: "success",
            data: TidalMedia(
              id: '75623239',
              version: 'Kill Jay Z',
              duration: 30,
              title: 'Kill Jay Z',
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
              trackNumber: 30,
              volumeNumber: 30,
              isrc: "TIDAL2274",
              providerId: "string",
              albumId: "string",
              artifactType: "string",
              properties: {
                "video-type": "live-stream",
                "content": "explicit",
                "additionalProp1": ["string"],
                "additionalProp2": ["string"],
                "additionalProp3": ["string"]
              },
              image: [
                TidalImage(
                  url:
                      "https://resources.tidal.com/images/717dfdae/beb0/4aea/a553/a70064c30386/80x80.jpg",
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
        ],
        metadata: {"requested": 10, "success": 8, "failure": 2},
      );

      // Act
      final result = await getMultipleVideosImpl(
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
