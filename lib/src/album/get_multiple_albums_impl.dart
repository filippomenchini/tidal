import 'dart:convert';

import 'package:http/http.dart' as http;
import 'handle_album_http_status_code.dart';
import 'tidal_album.dart';

import '../authorization/tidal_auth_token.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/albums/byIds';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums by their IDs from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request to obtain multiple
/// albums identified by their [ids] from Tidal. It requires a [tidalAuthToken] for
/// authentication, a list of [ids], and the [countryCode].
///
/// If the request is successful, the albums are returned as an instance of
/// [MultipleTidalAlbums].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [ids]: A list of album identifiers to be fetched.
/// - [countryCode]: The country code for the request.
///
/// Returns: An instance of [MultipleTidalAlbums] containing the retrieved albums.
Future<MultipleTidalAlbums> getMultipleAlbumsImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required List<String> ids,
  required String countryCode,
}) async {
  final urlIds = ids.map((id) => "ids=$id").join("&");
  final response = await client.get(
    Uri.parse(
      '$_getMultipleAlbumsEndpointUrl?$urlIds&countryCode=$countryCode',
    ),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  final json = jsonDecode(response.body);

  handleAlbumHttpStatusCode(response: response, json: json);
  return MultipleTidalAlbums.fromJson(json);
}
