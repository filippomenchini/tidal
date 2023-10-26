import 'tidal_image.dart';
import 'tidal_media.dart';

class TidalMediaVideo extends TidalMedia {
  final TidalImage image;

  TidalMediaVideo({
    required this.image,
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

  TidalMediaVideo.fromJson(Map<String, dynamic> json)
      : image = TidalImage.fromJson(json["image"]),
        super.fromJson(json);
}
