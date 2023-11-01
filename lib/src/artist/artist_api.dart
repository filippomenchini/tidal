import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../types/multiple_response.dart';
import '../types/tidal_artist.dart';
import 'get_multiple_artists_impl.dart';
import 'get_single_artist_impl.dart';

/// An abstract interface for accessing artist-related operations in the Tidal service.
///
/// This interface defines methods for fetching information about single artists or multiple artists
/// from the Tidal service.
abstract class ArtistAPI {
  /// Fetches information about a single artist based on their [id] and [countryCode].
  ///
  /// This method retrieves information about a single artist from the Tidal service
  /// using their unique [id] and the [countryCode] for the request.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the artist to retrieve.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [TidalArtist] object representing the requested artist.
  Future<TidalArtist> getSingleArtist({
    required String id,
    required String countryCode,
  });

  /// Fetches information about multiple artists based on their [ids] and [countryCode].
  ///
  /// This method retrieves information about multiple artists from the Tidal service
  /// using a list of artist [ids] and the [countryCode] for the request.
  ///
  /// Parameters:
  /// - [ids]: A list of unique identifiers for the artists to retrieve.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [MultipleResponse] containing [TidalArtist] objects for the requested artists.
  Future<MultipleResponse<TidalArtist>> getMultipleArtists({
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
  Future<MultipleResponse<TidalArtist>> getMultipleArtists({
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
