import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/tidal_artist.dart';

const _getSingleArtistEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches information about a single artist based on their [id] and [countryCode].
///
/// This method retrieves information about a single artist from the Tidal service
/// using their unique [id] and the [countryCode] for the request.
///
/// Parameters:
/// - [client]: The HTTP client used to make the API request.
/// - [tidalAuthToken]: The authentication token required for the request.
/// - [id]: The unique identifier of the artist to retrieve.
/// - [countryCode]: The country code for the request.
///
/// Returns: A [TidalArtist] object containing information about the requested artist.
Future<TidalArtist> getSingleArtistImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String id,
  required String countryCode,
}) async {
  final response = await client.get(
    Uri.parse('$_getSingleArtistEndpointUrl/$id?countryCode=$countryCode'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: (json) => TidalArtist.fromJson(json["resource"]),
  );
}
