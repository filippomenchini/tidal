import 'package:equatable/equatable.dart';

import 'tidal_album.dart';
import 'tidal_artist.dart';
import 'tidal_image.dart';

/// Represents media information in the Tidal service.
///
/// A [TidalMedia] object contains details about media, including its ID, version, duration,
/// title, copyright, artists involved, track and volume numbers, ISRC code, provider ID,
/// album ID, artifact type, properties, media metadata, and an optional image.
///
/// This class is used to represent media data retrieved from the Tidal service.
///
/// Parameters:
/// - [id]: The ID of the media.
/// - [version]: The version of the media.
/// - [duration]: The duration of the media in seconds.
/// - [title]: The title of the media.
/// - [copyright]: Copyright information related to the media.
/// - [artists]: A list of artists involved in the media.
/// - [album]: The album that the media refers to.
/// - [trackNumber]: The track number of the media.
/// - [volumeNumber]: The volume number of the media.
/// - [isrc]: The ISRC (International Standard Recording Code) of the media.
/// - [providerId]: The provider ID of the media.
/// - [albumId]: The ID of the album to which the media belongs.
/// - [artifactType]: The type of media artifact.
/// - [properties]: Additional properties associated with the media.
/// - [mediaMetadata]: Metadata associated with the media.
/// - [image]: An optional image associated with the media.
class TidalMedia extends Equatable {
  final String id;
  final String version;
  final int duration;
  final String title;
  final String copyright;
  final List<TidalMediaArtist> artists;
  final TidalBaseAlbum album;
  final int trackNumber;
  final int volumeNumber;
  final String isrc;
  final String providerId;
  final String albumId;
  final String artifactType;
  final Map<String, dynamic> properties;
  final Map<String, dynamic> mediaMetadata;
  final TidalImage? image;

  TidalMedia({
    required this.id,
    required this.version,
    required this.duration,
    required this.title,
    required this.copyright,
    required this.artists,
    required this.album,
    required this.trackNumber,
    required this.volumeNumber,
    required this.isrc,
    required this.providerId,
    required this.albumId,
    required this.artifactType,
    required this.properties,
    required this.mediaMetadata,
    this.image,
  });

  /// Constructs a TidalMedia object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing media data.
  TidalMedia.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        version = json["version"],
        duration = json["duration"],
        title = json["title"],
        copyright = json["copyright"],
        artists = (json["artists"] as List)
            .map((e) => TidalMediaArtist.fromJson(e))
            .toList(),
        album = TidalBaseAlbum.fromJson(json["album"]),
        trackNumber = json["trackNumber"],
        volumeNumber = json["volumeNumber"],
        isrc = json["isrc"],
        providerId = json["providerId"],
        albumId = json["albumId"],
        artifactType = json["artifactType"],
        properties = json["properties"],
        mediaMetadata = json["mediaMetadata"],
        image = json["image"];

  @override
  List<Object?> get props => [
        id,
        version,
        duration,
        title,
        copyright,
        artists,
        album,
        trackNumber,
        volumeNumber,
        isrc,
        providerId,
        albumId,
        artifactType,
        properties,
        mediaMetadata,
        image,
      ];
}
