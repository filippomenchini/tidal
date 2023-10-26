import 'package:equatable/equatable.dart';

import 'tidal_artist.dart';
import 'tidal_image.dart';

class TidalAlbum extends Equatable {
  final String id;
  final String barcodeId;
  final String title;
  final int duration;
  final DateTime releaseDate;
  final int numberOfVolumes;
  final int numberOfTracks;
  final int numberOfVideos;
  final String type;
  final String copyright;
  final List<TidalMediaArtist> artists;
  final List<TidalImage> imageCover;
  final List<TidalImage> videoCover;
  final Map<String, dynamic> mediaMetadata;
  final Map<String, dynamic> properties;

  const TidalAlbum({
    required this.id,
    required this.barcodeId,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.numberOfVolumes,
    required this.numberOfTracks,
    required this.numberOfVideos,
    required this.type,
    required this.copyright,
    required this.artists,
    required this.imageCover,
    required this.videoCover,
    required this.mediaMetadata,
    required this.properties,
  });

  /// Returns the main artist of the album.
  TidalArtist get mainArtist => artists.singleWhere((artist) => artist.main);

  /// Constructs a TidalAlbum object from JSON data.
  TidalAlbum.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        barcodeId = json["barcodeId"],
        title = json["title"],
        duration = json["duration"],
        releaseDate = DateTime.parse(json["releaseDate"]),
        numberOfVolumes = json["numberOfVolumes"],
        numberOfTracks = json["numberOfTracks"],
        numberOfVideos = json["numberOfVideos"],
        type = json["type"],
        copyright = json["copyright"],
        imageCover = (json["imageCover"] as List)
            .map((e) => TidalImage.fromJson(e))
            .toList(),
        videoCover = (json["videoCover"] as List)
            .map((e) => TidalImage.fromJson(e))
            .toList(),
        mediaMetadata = json["mediaMetadata"],
        properties = json["properties"],
        artists = (json["artists"] as List)
            .map((e) => TidalMediaArtist.fromJson(e))
            .toList();

  @override
  List<Object?> get props => [
        id,
        barcodeId,
        title,
        duration,
        releaseDate,
        numberOfVolumes,
        numberOfTracks,
        numberOfVideos,
        type,
        copyright,
        artists,
        imageCover,
        videoCover,
        mediaMetadata,
        properties,
      ];
}
