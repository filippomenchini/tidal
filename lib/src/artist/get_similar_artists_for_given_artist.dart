import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_get_similar_response.dart';
import '../commons/handle_http_response.dart';

const _getSimilarArtistsForGivenArtist = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Retrieves a list of similar artists for a given track.
///
/// Parameters:
/// - [id]: The unique identifier of the target artist.
/// - [countryCode]: The country code for which the search is performed.
/// - [offset]: The index from which to start retrieving similar artists (default is 0).
/// - [limit]: The maximum number of similar artists to retrieve (default is 10).
///
/// Returns:
/// A [Future<List<String>>] representing the unique identifiers of similar artists.
Future<List<String>> getSimilarArtistsForGivenArtistImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String id,
  required String countryCode,
  int offset = 0,
  int limit = 10,
}) async {
  final offsetQuery = "&offset=$offset";
  final limitQuery = "&limit=$limit";
  final response = await client.get(
    Uri.parse(
        '$_getSimilarArtistsForGivenArtist/$id/similar?countryCode=$countryCode$offsetQuery$limitQuery'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: handleGetSimilarResponse,
  );
}
