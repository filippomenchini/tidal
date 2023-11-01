import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../types/multiple_response.dart';
import '../types/tidal_media.dart';
import 'get_multiple_tracks_impl.dart';

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
      getSingleTrack(
        id: id,
        countryCode: countryCode,
      );
}
