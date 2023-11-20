import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../commons/handle_http_response.dart';
import '../types/tidal_search_response.dart';
import 'search_api.dart';

const _searchForCatalogItemsEndpointUrl = 'https://openapi.tidal.com/search';
const _acceptHeader = {'accept': 'application/vnd.tidal.v1+json'};
const _contentTypeHeader = {'Content-Type': 'application/vnd.tidal.v1+json'};

/// Retrieves a data set of items given a search query.
///
/// Parameters:
/// - [client]: The HTTP client for making the API request.
/// - [tidalAuthToken]: The Tidal authentication token.
/// - [query]: The search query.
/// - [countryCode]: The country code for localized results.
/// - [offset]: The offset for paginating through search results (default is 0).
/// - [limit]: The maximum number of items to retrieve per request (default is 10).
/// - [type]: Optional parameter to filter results by item type.
/// - [popularity]: Optional parameter to filter results by popularity.
///
/// Returns a [TidalMedia] instance representing the retrieved track.
Future<TidalSearchResponse> searchForCatalogItemsImpl(
  http.Client client, {
  required TidalAuthToken tidalAuthToken,
  required String query,
  required String countryCode,
  int offset = 0,
  int limit = 10,
  TidalSearchType type = TidalSearchType.UNDEFINED,
  TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
}) async {
  String typeQuery =
      type != TidalSearchType.UNDEFINED ? "&type=${type.name}" : "";
  String popularityQuery = popularity != TidalSearchPopularity.UNDEFINED
      ? "&popularity=${popularity.name}"
      : "";
  final response = await client.get(
    Uri.parse(
        '$_searchForCatalogItemsEndpointUrl?query=$query&offset=$offset&limit=$limit&countryCode=$countryCode$typeQuery$popularityQuery'),
    headers: {
      ..._acceptHeader,
      ..._contentTypeHeader,
      ...tidalAuthToken.header,
    },
  );

  return handleHttpResponse(
    response: response,
    onSuccessfulResponse: TidalSearchResponse.fromJson,
  );
}
