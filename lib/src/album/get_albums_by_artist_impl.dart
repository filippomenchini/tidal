import 'dart:convert';

import 'package:http/http.dart' as http;
import 'handle_album_http_status_code.dart';
import '../authorization/tidal_auth_token.dart';
import 'tidal_album.dart';

const _getMultipleAlbumsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

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
