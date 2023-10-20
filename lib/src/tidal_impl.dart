import 'package:http/http.dart' as http;
import 'artist/artist_api.dart';
import 'authorization/authorize.dart';

import 'tidal_base.dart';

/// Implementation of the Tidal music streaming service interface.
class TidalImpl implements Tidal {
  /// The implementation of the ArtistAPI interface.
  final ArtistAPI artistAPI;

  TidalImpl({
    required this.artistAPI,
  });

  @override
  ArtistAPI get artist => artistAPI;
}

/// Initializes and sets up a Tidal instance for making API requests.
///
/// [clientId] is the client ID for authentication.
/// [clientSecret] is the client secret for authentication.
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

  return TidalImpl(
    artistAPI: artistAPI,
  );
}
