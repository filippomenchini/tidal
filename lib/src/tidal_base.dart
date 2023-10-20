import 'artist/artist_api.dart';
import 'tidal_impl.dart';

/// An interface representing Tidal music streaming service functionality.
abstract class Tidal {
  /// Provides access to artist-related operations through the [ArtistAPI] interface.
  ArtistAPI get artist;

  /// Initializes and sets up a Tidal instance for making API requests.
  ///
  /// [clientId] is the client ID for authentication.
  /// [clientSecret] is the client secret for authentication.
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

  /// Disposes the Tidal instance.
  void dispose();
}
