import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/tidal_album.dart';

const _getSingleAlbumEndpointUrl = 'https://openapi.tidal.com/albums';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches a single album by its ID from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request for fetching a single album
/// identified by [id] from Tidal. It requires a [tidalAuthToken] for authentication,
/// the [id] of the album to be retrieved, and the [countryCode].
///
/// If the request is successful, the album is returned as a [TidalAlbum] object.
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [id]: The ID of the album to be fetched.
/// - [countryCode]: The country code for the request.
///
/// Returns: A [TidalAlbum] object representing the retrieved album.
Future<TidalAlbum> getSingleAlbumImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String id,
  required String countryCode,
}) async {
  final response = await client.get(
    Uri.parse('$_getSingleAlbumEndpointUrl/$id?countryCode=$countryCode'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: (json) => TidalAlbum.fromJson(json["resource"]),
  );
}
