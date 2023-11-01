import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_artist.dart';

const _getMultipleArtistsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches information about multiple artists based on their [ids] and [countryCode].
///
/// This method retrieves information about multiple artists from the Tidal service
/// using a list of artist [ids] and the [countryCode] for the request.
///
/// Parameters:
/// - [client]: The HTTP client used to make the API request.
/// - [tidalAuthToken]: The authentication token required for the request.
/// - [ids]: A list of unique identifiers for the artists to retrieve.
/// - [countryCode]: The country code for the request.
///
/// Returns: A [MultipleResponse] containing [TidalArtist] objects for the requested artists.
Future<MultipleResponse<TidalArtist>> getMultipleArtistsImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required List<String> ids,
  required String countryCode,
}) async {
  final urlIds = ids.map((id) => "ids=$id").join("&");
  final response = await client.get(
    Uri.parse(
      '$_getMultipleArtistsEndpointUrl?$urlIds&countryCode=$countryCode',
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
      itemFactory: TidalArtist.fromJson,
    ),
  );
}
