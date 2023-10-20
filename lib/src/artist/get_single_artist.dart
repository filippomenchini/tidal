import 'dart:convert';

import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import 'tidal_artist.dart';
import 'tidal_artist_error.dart';

const _getSingleArtistEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

Future<TidalArtist> getSingleArtist(
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
      ...tidalAuthToken.toHeader(),
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
