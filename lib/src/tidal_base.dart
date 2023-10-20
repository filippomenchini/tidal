import 'artist/artist_api.dart';
import 'tidal_impl.dart';

abstract class Tidal {
  ArtistAPI get artist;

  static Future<Tidal> initialize({
    required String clientId,
    required String clientSecret,
  }) =>
      initializeImpl(
        clientId: clientId,
        clientSecret: clientSecret,
      );
}
