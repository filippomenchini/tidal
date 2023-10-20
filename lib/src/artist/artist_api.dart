import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import 'get_multiple_artists_impl.dart';
import 'get_single_artist_impl.dart';
import 'tidal_artist.dart';

abstract class ArtistAPI {
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  });

  Future<MultipleTidalArtists> getMultipleArtists({
    required List<String> ids,
    required String countryCode,
  });
}

class ArtistAPIImpl implements ArtistAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  const ArtistAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<MultipleTidalArtists> getMultipleArtists({
    required List<String> ids,
    required String countryCode,
  }) =>
      getMultipleArtistsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

  @override
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  }) =>
      getSingleArtistImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );
}
