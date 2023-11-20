// ignore_for_file: constant_identifier_names
import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../types/tidal_search_response.dart';
import 'search_for_catalog_items_impl.dart';

/// Enum representing the types of Tidal catalog items that can be searched.
enum TidalSearchType {
  /// Undefined or unspecified search type.
  UNDEFINED,

  /// Search type for artists.
  ARTISTS,

  /// Search type for albums.
  ALBUMS,

  /// Search type for tracks.
  TRACKS,

  /// Search type for videos.
  VIDEOS,
}

/// Enum representing the popularity levels for Tidal catalog item searches.
enum TidalSearchPopularity {
  /// Undefined or unspecified popularity level.
  UNDEFINED,

  /// Worldwide popularity level.
  WORLDWIDE,

  /// Country-specific popularity level.
  COUNTRY,
}

/// An interface for searching Tidal catalog items.
abstract class SearchAPI {
  /// Searches for Tidal catalog items based on the specified query.
  ///
  /// Parameters:
  /// - [query]: The search query.
  /// - [countryCode]: The country code for localized results.
  /// - [offset]: The offset for paginating through search results (default is 0).
  /// - [limit]: The maximum number of items to retrieve per request (default is 10).
  /// - [type]: Optional parameter to filter results by item type.
  /// - [popularity]: Optional parameter to filter results by popularity.
  ///
  /// Returns a [TidalSearchResponse] containing search results.
  Future<TidalSearchResponse> searchForCatalogItems({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchType type = TidalSearchType.UNDEFINED,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  });
}

/// An implementation of the [SearchAPI] interface for accessing Tidal search interface.
class SearchAPIImpl implements SearchAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  /// Creates a [SearchAPIImpl] instance with the specified [client] and [tidalAuthToken].
  const SearchAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<TidalSearchResponse> searchForCatalogItems({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchType type = TidalSearchType.UNDEFINED,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  }) =>
      searchForCatalogItemsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        query: query,
        countryCode: countryCode,
      );
}
