import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/albums';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

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
