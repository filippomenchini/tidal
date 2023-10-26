import 'tidal_media.dart';

class TidalMediaTrack extends TidalMedia {
  TidalMediaTrack({
    required super.id,
    required super.version,
    required super.duration,
    required super.title,
    required super.copyright,
    required super.artists,
    required super.trackNumber,
    required super.volumeNumber,
    required super.isrc,
    required super.providerId,
    required super.albumId,
    required super.artifactType,
    required super.properties,
  });

  TidalMediaTrack.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
