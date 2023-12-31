import 'package:http/http.dart' as http;

import '../authorization/tidal_auth_token.dart';
import '../search/search_api.dart';
import '../search/search_for_catalog_items_impl.dart';
import '../types/multiple_response.dart';
import '../types/tidal_album.dart';
import 'get_albums_by_artist_impl.dart';
import 'get_albums_by_barcode_id_impl.dart';
import 'get_multiple_albums_impl.dart';
import 'get_similar_albums_for_given_album_impl.dart';
import 'get_single_album_impl.dart';

/// An abstract class that defines the contract for interacting with Tidal album-related operations.
///
/// Implementations of this class are responsible for fetching and managing album-related data
/// from Tidal's APIs. The methods defined in this class include operations to retrieve albums by artist,
/// retrieve a single album by its ID, obtain multiple albums by their IDs, and fetch albums by barcode ID.
abstract class AlbumAPI {
  /// Fetches multiple albums by a specific artist from Tidal.
  ///
  /// This method retrieves multiple albums associated with a particular artist identified by [artistId]
  /// in a specific [countryCode]. Optional [offset] and [limit] parameters can be provided to paginate
  /// the results.
  ///
  /// Parameters:
  /// - [artistId]: The identifier of the artist whose albums are to be fetched.
  /// - [countryCode]: The country code for the request.
  /// - [offset]: Optional. The starting point for fetching albums.
  /// - [limit]: Optional. The maximum number of albums to retrieve.
  ///
  /// Returns: A [Future] containing a [MultipleResponse] of [TidalAlbum] objects.
  Future<MultipleResponse<TidalAlbum>> getAlbumsByArtist({
    required String artistId,
    required String countryCode,
    int? offset,
    int? limit,
  });

  /// Retrieves a single album by its ID from Tidal.
  ///
  /// This method fetches a single album identified by [albumId] in a specific [countryCode].
  ///
  /// Parameters:
  /// - [albumId]: The identifier of the album to be fetched.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [Future] containing the retrieved [TidalAlbum].
  Future<TidalAlbum> getSingleAlbum({
    required String albumId,
    required String countryCode,
  });

  /// Fetches multiple albums by their IDs from Tidal.
  ///
  /// This method retrieves multiple albums identified by their [ids] from Tidal in a specific [countryCode].
  ///
  /// Parameters:
  /// - [ids]: A list of album identifiers to be fetched.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [Future] containing a [MultipleResponse] of [TidalAlbum] objects.
  Future<MultipleResponse<TidalAlbum>> getMultipleAlbums({
    required List<String> ids,
    required String countryCode,
  });

  /// Fetches multiple albums by their barcode identifier from Tidal.
  ///
  /// This method retrieves multiple albums identified by their [barcodeId] from Tidal in a specific [countryCode].
  ///
  /// Parameters:
  /// - [barcodeId]: The barcode identifier of the albums to be fetched.
  /// - [countryCode]: The country code for the request.
  ///
  /// Returns: A [Future] containing a [MultipleResponse] of [TidalAlbum] objects.
  Future<MultipleResponse<TidalAlbum>> getAlbumsByBarcodeId({
    required String barcodeId,
    required String countryCode,
  });

  /// Searches albums by given query string.
  ///
  /// This methods returns multiple albums by searching the database with the [query] parameter in a specific [countryCode].
  ///
  /// Parameters:
  /// - [query]: The query string to search.
  /// - [countryCode]: The country code for the request.
  /// - [offset]: Optional. The starting point for fetching albums.
  /// - [limit]: Optional. The maximum number of albums to retrieve.
  /// - [popularity]: Optional. The level popularity of the searched album.
  Future<MultipleResponse<TidalAlbum>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  });

  /// Retrieves a list of similar albums for a given album.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the target album.
  /// - [countryCode]: The country code for which the search is performed.
  /// - [offset]: The index from which to start retrieving similar albums (default is 0).
  /// - [limit]: The maximum number of similar albums to retrieve (default is 10).
  ///
  /// Returns:
  /// A [Future<List<String>>] representing the unique identifiers of similar albums.
  Future<List<String>> getSimilarAlbumsForGivenAlbum({
    required String id,
    required String countryCode,
    int offset = 0,
    int limit = 10,
  });
}

/// An implementation of the [AlbumAPI] interface that interacts with the Tidal API.
class AlbumAPIImpl implements AlbumAPI {
  final http.Client client;
  final TidalAuthToken tidalAuthToken;

  const AlbumAPIImpl({
    required this.client,
    required this.tidalAuthToken,
  });

  @override
  Future<MultipleResponse<TidalAlbum>> getAlbumsByArtist({
    required String artistId,
    required String countryCode,
    int? offset,
    int? limit,
  }) =>
      getAlbumsByArtistImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        artistId: artistId,
        countryCode: countryCode,
      );

  @override
  Future<MultipleResponse<TidalAlbum>> getAlbumsByBarcodeId({
    required String barcodeId,
    required String countryCode,
  }) =>
      getAlbumsByBarcodeIdImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        barcodeId: barcodeId,
        countryCode: countryCode,
      );

  @override
  Future<MultipleResponse<TidalAlbum>> getMultipleAlbums({
    required List<String> ids,
    required String countryCode,
  }) =>
      getMultipleAlbumsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        ids: ids,
        countryCode: countryCode,
      );

  @override
  Future<TidalAlbum> getSingleAlbum({
    required String albumId,
    required String countryCode,
  }) =>
      getSingleAlbumImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: albumId,
        countryCode: countryCode,
      );

  @override
  Future<MultipleResponse<TidalAlbum>> search({
    required String query,
    required String countryCode,
    int offset = 0,
    int limit = 10,
    TidalSearchPopularity popularity = TidalSearchPopularity.UNDEFINED,
  }) =>
      searchForCatalogItemsImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        query: query,
        countryCode: countryCode,
        offset: offset,
        limit: limit,
        popularity: popularity,
        type: TidalSearchType.ALBUMS,
      ).then((result) => result.albums);

  @override
  Future<List<String>> getSimilarAlbumsForGivenAlbum({
    required String id,
    required String countryCode,
    int offset = 0,
    int limit = 10,
  }) =>
      getSimilarAlbumsForGivenAlbumImpl(
        client,
        tidalAuthToken: tidalAuthToken,
        id: id,
        countryCode: countryCode,
      );
}
