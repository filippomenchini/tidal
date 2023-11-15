import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/tidal_media.dart';

const _getSingleVideoEndpointUrl = 'https://openapi.tidal.com/videos';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Retrieves a single Tidal video using its unique identifier.
///
/// Parameters:
/// - [client]: The HTTP client for making the API request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [id]: The unique identifier of the video to retrieve.
/// - [countryCode]: The country code for regional data filtering.
///
/// Returns a [TidalMedia] instance representing the retrieved video.
Future<TidalMedia> getSingleVideoImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String id,
  required String countryCode,
}) async {
  final response = await client.get(
    Uri.parse('$_getSingleVideoEndpointUrl/$id?countryCode=$countryCode'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: (json) => TidalMedia.fromJson(json["resource"]),
  );
}
