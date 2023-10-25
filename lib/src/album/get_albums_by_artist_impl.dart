import 'dart:convert';

import 'package:http/http.dart' as http;
import 'handle_album_http_status_code.dart';
import '../authorization/tidal_auth_token.dart';
import 'tidal_album.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums by a specific artist from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request to obtain multiple
/// albums associated with a particular [artistId] from Tidal. It requires a
/// [tidalAuthToken] for authentication, the [artistId] of the artist, the
/// [countryCode], and optional parameters for [offset] and [limit] to paginate
/// the results.
///
/// The optional [offset] parameter specifies the starting point for fetching
/// albums, while the [limit] parameter defines the maximum number of albums to
/// retrieve in a single request.
///
/// If the request is successful, the albums are returned as an instance of
/// [MultipleTidalAlbums].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [artistId]: The identifier of the artist whose albums are to be fetched.
/// - [countryCode]: The country code for the request.
/// - [offset]: Optional. The starting point for fetching albums.
/// - [limit]: Optional. The maximum number of albums to retrieve.
///
/// Returns: An instance of [MultipleTidalAlbums] containing the retrieved albums.
Future<MultipleTidalAlbums> getAlbumsByArtistImpl(
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

  final json = jsonDecode(response.body);

  handleAlbumHttpStatusCode(response: response, json: json);
  return MultipleTidalAlbums.fromJson(json);
}
