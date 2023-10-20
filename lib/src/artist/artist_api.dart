import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import 'get_multiple_artists_impl.dart';
import 'get_single_artist_impl.dart';
import 'tidal_artist.dart';

/// An abstract class defining the interface for Tidal artist-related API operations.
abstract class ArtistAPI {
  /// Retrieves a single Tidal artist by ID.
  ///
  /// [id] is the ID of the artist to retrieve.
  /// [countryCode] is the country code for the request.
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  });

  /// Retrieves multiple Tidal artists by their IDs.
  ///
  /// [ids] is a list of artist IDs to retrieve.
  /// [countryCode] is the country code for the request.
  Future<MultipleTidalArtists> getMultipleArtists({
    required List<String> ids,
    required String countryCode,
  });
}

/// An implementation of the [ArtistAPI] interface that interacts with the Tidal API.
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
