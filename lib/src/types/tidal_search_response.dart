import 'package:equatable/equatable.dart';

import 'multiple_response.dart';
import 'tidal_album.dart';
import 'tidal_artist.dart';
import 'tidal_media.dart';

/// Represents the response of a search request in the Tidal APIs.
///
/// Parameters:
/// - [albums]: A list of albums matching the search pattern.
/// - [artists]: A list of artists matching the search pattern.
/// - [tracks]: A list of tracks matching the search pattern.
/// - [videos]: A list of videos matching the search pattern.
class TidalSearchResponse extends Equatable {
  final MultipleResponse<TidalAlbum> albums;
  final MultipleResponse<TidalArtist> artists;
  final MultipleResponse<TidalMedia> tracks;
  final MultipleResponse<TidalMedia> videos;

  const TidalSearchResponse({
    required this.albums,
    required this.artists,
    required this.tracks,
    required this.videos,
  });

  /// Constructs a TidalSearchResponse object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing search data.
  TidalSearchResponse.fromJson(Map<String, dynamic> json)
      : albums = MultipleResponse.fromJson(
          json: json["albums"],
          itemFactory: TidalAlbum.fromJson,
        ),
        artists = MultipleResponse.fromJson(
          json: json["artists"],
          itemFactory: TidalArtist.fromJson,
        ),
        tracks = MultipleResponse.fromJson(
          json: json["tracks"],
          itemFactory: TidalMedia.fromJson,
        ),
        videos = MultipleResponse.fromJson(
          json: json["videos"],
          itemFactory: TidalMedia.fromJson,
        );

  @override
  List<Object?> get props => [albums, artists, tracks, videos];
}
