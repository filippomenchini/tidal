import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/albums';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple media items associated with a specific album from Tidal using an HTTP request.
///
/// This method uses the HTTP [client] to make a request to obtain multiple media items
/// linked to a particular album identified by [albumId] from Tidal. It requires a [tidalAuthToken] for
/// authentication, the [albumId], [countryCode], and optional [offset] and [limit] parameters.
///
/// If the request is successful, the media items are returned as a [MultipleResponse] of [TidalMedia].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [albumId]: The identifier of the album whose media items are to be fetched.
/// - [countryCode]: The country code for the request.
/// - [offset]: Optional. The starting point for fetching media items.
/// - [limit]: Optional. The maximum number of media items to retrieve.
///
/// Returns: A [MultipleResponse] of [TidalMedia] objects containing the retrieved media items.
Future<MultipleResponse<TidalMedia>> getAlbumItemsImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String albumId,
  required String countryCode,
  int? offset,
  int? limit,
}) async {
  String queryString = "";
  if (offset != null) queryString += "?offset=$offset";
  if (limit != null) queryString += "?limit=$limit";
  final response = await client.get(
    Uri.parse(
        '$_getMultipleAlbumsEndpointUrl/$albumId/items?countryCode=$countryCode$queryString'),
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
      itemFactory: TidalMedia.fromJson,
    ),
  );
}
