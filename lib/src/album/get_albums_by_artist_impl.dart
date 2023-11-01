import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_album.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums associated with a specific artist from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request for fetching multiple albums
/// linked to a particular artist identified by [artistId] from Tidal. It requires a [tidalAuthToken] for
/// authentication, the [artistId], [countryCode], and optional [offset] and [limit] parameters.
///
/// If the request is successful, the albums are returned as a [MultipleResponse] of [TidalAlbum].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [artistId]: The identifier of the artist whose albums are to be fetched.
/// - [countryCode]: The country code for the request.
/// - [offset]: Optional. The starting point for fetching albums.
/// - [limit]: Optional. The maximum number of albums to retrieve.
///
/// Returns: A [MultipleResponse] of [TidalAlbum] objects containing the retrieved albums.
Future<MultipleResponse<TidalAlbum>> getAlbumsByArtistImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String artistId,
  required String countryCode,
  int? offset,
  int? limit,
}) async {
  String queryString = "";
  if (offset != null) queryString += "?offset=$offset";
  if (limit != null) queryString += "?limit=$limit";
  final response = await client.get(
    Uri.parse(
        '$_getMultipleAlbumsEndpointUrl/$artistId/albums?countryCode=$countryCode$queryString'),
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
