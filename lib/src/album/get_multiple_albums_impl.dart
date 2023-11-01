import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_album.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/albums/byIds';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums by their IDs from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request for fetching multiple albums
/// identified by a list of [ids] from Tidal. It requires a [tidalAuthToken] for
/// authentication, the list of [ids], and the [countryCode].
///
/// If the request is successful, the albums are returned as a [MultipleResponse] of [TidalAlbum].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [ids]: A list of album IDs to be fetched.
/// - [countryCode]: The country code for the request.
///
/// Returns: A [MultipleResponse] of [TidalAlbum] objects containing the retrieved albums.
Future<MultipleResponse<TidalAlbum>> getMultipleAlbumsImpl(
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

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: (json) => MultipleResponse.fromJson(
      json: json,
      itemFactory: TidalAlbum.fromJson,
    ),
  );
}
