import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../search/search_api.dart';
import '../search/search_for_catalog_items_impl.dart';
import '../types/multiple_response.dart';
import '../types/tidal_artist.dart';
import 'get_multiple_artists_impl.dart';
import 'get_single_artist_impl.dart';

/// An abstract interface for accessing artist-related operations in the Tidal service.
///
/// This interface defines methods for fetching information about single artists or multiple artists
/// from the Tidal service.
abstract class ArtistAPI {
  /// Fetches information about a single artist based on their [id] and [countryCode].
  ///
  /// This method retrieves information about a single artist from the Tidal service
  /// using their unique [id] and the [countryCode] for the request.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the artist to retrieve.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [TidalArtist] object representing the requested artist.
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  });

  /// Fetches information about multiple artists based on their [ids] and [countryCode].
  ///
  /// This method retrieves information about multiple artists from the Tidal service
  /// using a list of artist [ids] and the [countryCode] for the request.
  ///
  /// Parameters:
  /// - [ids]: A list of unique identifiers for the artists to retrieve.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [MultipleResponse] containing [TidalArtist] objects for the requested artists.
  Future<MultipleResponse<TidalArtist>> getMultipleArtists({
    required List<String> ids,
    required String countryCode,
  });

  /// Searches artists by given query string.
  ///
  /// This methods returns multiple artists by searching the database with the [query] parameter in a specific [countryCode].
  ///
  /// Parameters:
  /// - [query]: The query string to search.
  /// - [countryCode]: The country code for the request.
  /// - [offset]: Optional. The starting point for fetching albums.
  /// - [limit]: Optional. The maximum number of artists to retrieve.
  /// - [popularity]: Optional. The level popularity of the searched artists.
  Future<MultipleResponse<TidalArtist>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  });
}

/// An implementation of the [ArtistAPI] interface that interacts with the Tidal API.
class ArtistAPIImpl implements ArtistAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  const ArtistAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<MultipleResponse<TidalArtist>> getMultipleArtists({
    required List<String> ids,
    required String countryCode,
  }) =>
      getMultipleArtistsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

  @override
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  }) =>
      getSingleArtistImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );

  @override
  Future<MultipleResponse<TidalArtist>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  }) =>
      searchForCatalogItemsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        query: query,
        countryCode: countryCode,
        offset: offset,
        limit: limit,
        popularity: popularity,
        type: TidalSearchType.ARTISTS,
      ).then((result) => result.artists);
}
