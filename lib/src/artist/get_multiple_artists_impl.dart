import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_artist.dart';

const _getMultipleArtistsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple Tidal artists using the Tidal API.
///
/// [client] is an HTTP client for making the request.
/// [tidalAuthToken] is the Tidal authentication token required for the request.
/// [ids] is a list of artist IDs to retrieve.
/// [countryCode] is the country code for the request.
///
/// Returns a [MultipleTidalArtists] object representing the retrieved artists and their metadata.
///
/// Throws [BadRequestTidalArtistError] if the HTTP response status code is 400, indicating a bad request.
/// Throws [TidalArtistError] for any other non-207 HTTP response status code.
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
