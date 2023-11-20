// ignore_for_file: constant_identifier_names

import '../types/tidal_search_response.dart';

enum TidalSearchType {
  UNDEFINED,
  ARTISTS,
  ALBUMS,
  TRACKS,
  VIDEOS,
}

enum TidalSearchPopularity {
  UNDEFINED,
  WORLDWIDE,
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
