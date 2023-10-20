import 'dart:convert';

import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import 'tidal_artist.dart';
import 'tidal_artist_error.dart';

const _getSingleArtistEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches a single Tidal artist using the Tidal API.
///
/// [client] is an HTTP client for making the request.
/// [tidalAuthToken] is the Tidal authentication token required for the request.
/// [id] is the ID of the artist to retrieve.
/// [countryCode] is the country code for the request.
///
/// Returns a [TidalArtist] object representing the retrieved artist.
///
/// Throws [BadRequestTidalArtistError] if the HTTP response status code is 400, indicating a bad request.
/// Throws [TidalArtistError] for any other non-200 HTTP response status code.
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

  final json = jsonDecode(response.body);

  if (response.statusCode == 400) {
    throw (json['errors'] as List)
        .map((errorJson) => BadRequestTidalArtistError.fromJson(errorJson))
        .toList();
  }

  if (response.statusCode != 200) {
    throw (json['errors'] as List)
        .map((errorJson) => TidalArtistError.fromJson(errorJson))
        .toList();
  }

  return TidalArtist.fromJson(json["resource"]);
}
