import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';

const _getMultipleTracksEndpointUrl = 'https://openapi.tidal.com/tracks';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Retrieves multiple Tidal tracks based on their unique IDs.
///
/// Parameters:
/// - [client]: The HTTP client for making the API request.
/// - [tidalAuthToken]: The Tidal authentication token for authorization.
/// - [ids]: A list of unique track IDs to retrieve.
/// - [countryCode]: The country code for the requested tracks.
///
/// Returns a [Future] containing a [MultipleResponse] of [TidalMedia] instances.
///
/// Throws a [TidalError] in case of API errors, which includes [TidalErrorItem] details.
Future<MultipleResponse<TidalMedia>> getMultipleTracksImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required List<String> ids,
  required String countryCode,
}) async {
  final urlIds = ids.map((id) => "ids=$id").join("&");
  final response = await client.get(
    Uri.parse(
      '$_getMultipleTracksEndpointUrl?$urlIds&countryCode=$countryCode',
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
      itemFactory: TidalMedia.fromJson,
    ),
  );
}
