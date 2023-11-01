import 'album/album_api.dart';
import 'artist/artist_api.dart';
import 'tidal_impl.dart';

/// The entry point for interacting with the Tidal service.
///
/// The [Tidal] class provides access to different aspects of the Tidal service
/// through its [ArtistAPI] and [AlbumAPI] properties. It allows you to
/// initialize and set up a Tidal instance for making API requests and provides
/// a method to dispose of the instance when it's no longer needed.
abstract class Tidal {
  /// Provides access to artist-related operations through the [ArtistAPI] interface.
  ArtistAPI get artist;

  /// Provides access to album-related operations through the [AlbumAPI] interface.
  AlbumAPI get album;

  /// Initializes and sets up a Tidal instance for making API requests.
  ///
  /// Parameters:
  /// - [clientId]: The client ID for authentication.
  /// - [clientSecret]: The client secret for authentication.
  ///
  /// Returns a [Tidal] instance for interacting with the Tidal service.
  static Future<Tidal> initialize({
    required String clientId,
    required String clientSecret,
  }) =>
      initializeImpl(
        clientId: clientId,
        clientSecret: clientSecret,
      );

  /// Disposes the Tidal instance, releasing any resources associated with it.
  void dispose();
}
