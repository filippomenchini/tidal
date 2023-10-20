import 'dart:convert';

import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import 'tidal_artist.dart';
import 'tidal_artist_error.dart';

const _getMultipleArtistsEndpointUrl = 'https://openapi.tidal.com/artists';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

Future<MultipleTidalArtists> getMultipleArtistsImpl(
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

  final json = jsonDecode(response.body);

  if (response.statusCode == 400) {
    throw (json['errors'] as List)
        .map((errorJson) => BadRequestTidalArtistError.fromJson(errorJson))
        .toList();
  }

  if (response.statusCode != 207) {
    throw (json['errors'] as List)
        .map((errorJson) => TidalArtistError.fromJson(errorJson))
        .toList();
  }

  return MultipleTidalArtists.fromJson(json);
}
