import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/multiple_response.dart';
import '../types/tidal_album.dart';

const _getAlbumsByBarcodeIdEndpointUrl =
    'https://openapi.tidal.com/albums/byBarcodeId';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums associated with a specific barcode ID from Tidal using an HTTP request.
///
/// This method utilizes the HTTP [client] to make a request for fetching multiple albums
/// linked to a particular barcode ID identified by [barcodeId] from Tidal. It requires a [tidalAuthToken] for
/// authentication, the [barcodeId], and [countryCode].
///
/// If the request is successful, the albums are returned as a [MultipleResponse] of [TidalAlbum].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [barcodeId]: The barcode ID of the albums to be fetched.
/// - [countryCode]: The country code for the request.
///
/// Returns: A [MultipleResponse] of [TidalAlbum] objects containing the retrieved albums.
Future<MultipleResponse<TidalAlbum>> getAlbumsByBarcodeIdImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String barcodeId,
  required String countryCode,
}) async {
  final response = await client.get(
    Uri.parse(
        '$_getAlbumsByBarcodeIdEndpointUrl?barcodeId=$barcodeId&countryCode=$countryCode'),
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
      itemFactory: TidalAlbum.fromJson,
    ),
  );
}
