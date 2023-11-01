import 'package:http/http.dart' as http;

import 'album/album_api.dart';
import 'artist/artist_api.dart';
import 'authorization/authorize.dart';
import 'tidal_base.dart';
import 'track/track_api.dart';

/// An implementation of the [Tidal] interface that provides access to artist and album-related operations.
class TidalImpl implements Tidal {
  final ArtistAPI artistAPI;
  final AlbumAPI albumAPI;
  final TrackAPI trackAPI;
  final http.Client client;

  /// Creates a [TidalImpl] instance with the provided artist and album API implementations and an HTTP client.
  TidalImpl({
    required this.artistAPI,
    required this.albumAPI,
    required this.trackAPI,
    required this.client,
  });

  @override
  ArtistAPI get artist => artistAPI;

  @override
  AlbumAPI get album => albumAPI;

  @override
  TrackAPI get track => trackAPI;

  @override
  void dispose() => client.close();
}

/// Initializes and sets up a Tidal instance for making API requests.
///
/// Parameters:
/// - [clientId]: The client ID for authentication.
/// - [clientSecret]: The client secret for authentication.
///
/// Returns a [Tidal] instance for interacting with the Tidal service.
Future<Tidal> initializeImpl({
  required String clientId,
  required String clientSecret,
}) async {
  final client = http.Client();

  final currentDateTime = DateTime.now();

  final tidalAuthToken = await authorize(
    client,
    clientId: clientId,
    clientSecret: clientSecret,
    currentDateTime: currentDateTime,
  );

  final artistAPI = ArtistAPIImpl(
    client: client,
    tidalAuthToken: tidalAuthToken,
  );

  final albumAPI = AlbumAPIImpl(
    client: client,
    tidalAuthToken: tidalAuthToken,
  );

  final trackAPI = TrackAPIImpl(
    client: client,
    tidalAuthToken: tidalAuthToken,
  );

  return TidalImpl(
    artistAPI: artistAPI,
    albumAPI: albumAPI,
    trackAPI: trackAPI,
    client: client,
  );
}
