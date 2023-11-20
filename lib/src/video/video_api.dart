import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../search/search_api.dart';
import '../search/search_for_catalog_items_impl.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';
import 'get_multiple_videos_impl.dart';
import 'get_single_video_impl.dart';

/// An abstract class defining the methods for accessing Tidal video information.
abstract class VideoAPI {
  /// Retrieves a single Tidal video based on its unique ID.
  ///
  /// Parameters:
  /// - [id]: The unique ID of the video.
  /// - [countryCode]: The country code for the requested video.
  ///
  /// Returns a [Future] containing a [TidalMedia] instance representing the video.
  Future<TidalMedia> getSingleVideo({
    required String id,
    required String countryCode,
  });

  /// Retrieves multiple Tidal videos based on their unique IDs.
  ///
  /// Parameters:
  /// - [ids]: A list of unique video IDs to retrieve.
  /// - [countryCode]: The country code for the requested videos.
  ///
  /// Returns a [Future] containing a [MultipleResponse] of [TidalMedia] instances.
  Future<MultipleResponse<TidalMedia>> getMultipleVideos({
    required List<String> ids,
    required String countryCode,
  });

  /// Searches videos by given query string.
  ///
  /// This methods returns multiple videos by searching the database with the [query] parameter in a specific [countryCode].
  ///
  /// Parameters:
  /// - [query]: The query string to search.
  /// - [countryCode]: The country code for the request.
  /// - [offset]: Optional. The starting point for fetching albums.
  /// - [limit]: Optional. The maximum number of videos to retrieve.
  /// - [popularity]: Optional. The level popularity of the searched videos.
  Future<MultipleResponse<TidalMedia>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  });
}

/// An implementation of the [TrackAPI] interface for accessing Tidal video information.
class VideoAPIImpl implements VideoAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  /// Creates a [VideoAPIImpl] instance with the specified [client] and [tidalAuthToken].
  const VideoAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<MultipleResponse<TidalMedia>> getMultipleVideos({
    required List<String> ids,
    required String countryCode,
  }) =>
      getMultipleVideosImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

  @override
  Future<TidalMedia> getSingleVideo({
    required String id,
    required String countryCode,
  }) =>
      getSingleVideoImpl(
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
        type: TidalSearchType.VIDEOS,
      ).then((result) => result.videos);
}
