import 'package:equatable/equatable.dart';

import 'tidal_artist.dart';
import 'tidal_image.dart';

class TidalMedia extends Equatable {
  final String id;
  final String version;
  final int duration;
  final String title;
  final String copyright;
  final List<TidalMediaArtist> artists;
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

  TidalMedia.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        version = json["version"],
        duration = json["duration"],
        title = json["title"],
        copyright = json["copyright"],
        artists = (json["artists"] as List)
            .map((e) => TidalMediaArtist.fromJson(e))
            .toList(),
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
        trackNumber,
        volumeNumber,
        isrc,
        providerId,
        albumId,
        artifactType,
        mediaMetadata,
        mediaMetadata,
        image,
      ];
}
