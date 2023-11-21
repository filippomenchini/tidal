import 'package:http/http.dart' as http;
import 'package:tidal/src/track/get_similar_tracks_for_given_track.dart';

import '../authorization/tidal_auth_token.dart';
import '../search/search_api.dart';
import '../search/search_for_catalog_items_impl.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';
import 'get_multiple_tracks_impl.dart';
import 'get_single_track_impl.dart';

/// An abstract class defining the methods for accessing Tidal track information.
abstract class TrackAPI {
  /// Retrieves a single Tidal track based on its unique ID.
  ///
  /// Parameters:
  /// - [id]: The unique ID of the track.
  /// - [countryCode]: The country code for the requested track.
  ///
  /// Returns a [Future] containing a [TidalMedia] instance representing the track.
  Future<TidalMedia> getSingleTrack({
    required String id,
    required String countryCode,
  });

  /// Retrieves multiple Tidal tracks based on their unique IDs.
  ///
  /// Parameters:
  /// - [ids]: A list of unique track IDs to retrieve.
  /// - [countryCode]: The country code for the requested tracks.
  ///
  /// Returns a [Future] containing a [MultipleResponse] of [TidalMedia] instances.
  Future<MultipleResponse<TidalMedia>> getMultipleTracks({
    required List<String> ids,
    required String countryCode,
  });

  /// Searches tracks by given query string.
  ///
  /// This methods returns multiple tracks by searching the database with the [query] parameter in a specific [countryCode].
  ///
  /// Parameters:
  /// - [query]: The query string to search.
  /// - [countryCode]: The country code for the request.
  /// - [offset]: Optional. The starting point for fetching albums.
  /// - [limit]: Optional. The maximum number of tracks to retrieve.
  /// - [popularity]: Optional. The level popularity of the searched tracks.
  Future<MultipleResponse<TidalMedia>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  });

  /// Retrieves a list of similar tracks for a given track.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the target track.
  /// - [countryCode]: The country code for which the search is performed.
  /// - [offset]: The index from which to start retrieving similar tracks (default is 0).
  /// - [limit]: The maximum number of similar tracks to retrieve (default is 10).
  ///
  /// Returns:
  /// A [Future<List<String>>] representing the unique identifiers of similar tracks.
  Future<List<String>> getSimilarTracksForGivenTrack({
    required String id,
    required String countryCode,
    int offset = 0,
    int limit = 10,
  });
}

/// An implementation of the [TrackAPI] interface for accessing Tidal track information.
class TrackAPIImpl implements TrackAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  /// Creates a [TrackAPIImpl] instance with the specified [client] and [tidalAuthToken].
  const TrackAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<MultipleResponse<TidalMedia>> getMultipleTracks({
    required List<String> ids,
    required String countryCode,
  }) =>
      getMultipleTracksImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

  @override
  Future<TidalMedia> getSingleTrack({
    required String id,
    required String countryCode,
  }) =>
      getSingleTrackImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );

  @override
  Future<MultipleResponse<TidalMedia>> search({
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
        type: TidalSearchType.TRACKS,
      ).then((result) => result.tracks);

  @override
  Future<List<String>> getSimilarTracksForGivenTrack({
    required String id,
    required String countryCode,
    int offset = 0,
    int limit = 10,
  }) =>
      getSimilarTracksForGivenTrackImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );
}
