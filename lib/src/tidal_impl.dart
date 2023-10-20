import 'package:http/http.dart' as http;
import 'artist/artist_api.dart';
import 'authorization/authorize.dart';

import 'tidal_base.dart';

class TidalImpl implements Tidal {
  final ArtistAPI artistAPI;

  TidalImpl({
    required this.artistAPI,
  });

  @override
  ArtistAPI get artist => artistAPI;
}

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
