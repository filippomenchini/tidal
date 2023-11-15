import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
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
}
