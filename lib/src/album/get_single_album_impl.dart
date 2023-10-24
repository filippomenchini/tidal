import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tidal/src/album/handle_album_http_status_code.dart';

import '../authorization/tidal_auth_token.dart';
import 'tidal_album.dart';
import 'tidal_album_error.dart';

const _getSingleAlbumEndpointUrl = 'https://openapi.tidal.com/albums';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Gets a single album from Tidal using an HTTP request.
///
/// This method uses the HTTP [client] to make a request to obtain a specific
/// album from Tidal. It requires a [tidalAuthToken] for authentication, the
/// [id] of the album, and the [countryCode].
///
/// If the request is successful and returns an HTTP status of 200, the album
/// is extracted from the received JSON data and returned as a [TidalAlbum] object.
///
/// If the request returns an HTTP status of 400, specific errors for incorrect
/// requests are returned as [BadRequestTidalAlbumError] objects.
///
/// Otherwise, in case of generic errors, [TidalAlbumError] objects are returned.
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [id]: The identifier of the album to fetch.
/// - [countryCode]: The country code for the request.
///
/// Returns: An instance of [TidalAlbum] obtained from the Tidal response.
Future<TidalAlbum> getSingleAlbumImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String id,
  required String countryCode,
}) async {
  final response = await client.get(
    Uri.parse('$_getSingleAlbumEndpointUrl/$id?countryCode=$countryCode'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  final json = jsonDecode(response.body);

  handleAlbumHttpStatusCode(response: response, json: json);
  return TidalAlbum.fromJson(json["resource"]);
}
