import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import 'tidal_album.dart';

const _getAlbumsByBarcodeIdEndpointUrl =
    'https://openapi.tidal.com/albums/byBarcodeId';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Fetches multiple albums by their barcode identifier from Tidal using an HTTP request.
///
/// This method uses the HTTP [client] to make a request to obtain multiple albums
/// identified by their [barcodeId] from Tidal. It requires a [tidalAuthToken] for
/// authentication, the [barcodeId], and the [countryCode].
///
/// If the request is successful, the albums are returned as an instance of
/// [MultipleTidalAlbums].
///
/// Parameters:
/// - [client]: The HTTP client used for the request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [barcodeId]: The barcode identifier of the albums to be fetched.
/// - [countryCode]: The country code for the request.
///
/// Returns: An instance of [MultipleTidalAlbums] containing the retrieved albums.
Future<MultipleTidalAlbums> getAlbumsByBarcodeId(
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
    onSuccessfulResponse: (json) => MultipleTidalAlbums.fromJson(json),
  );
}
