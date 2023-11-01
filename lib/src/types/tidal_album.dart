import 'package:equatable/equatable.dart';

import 'tidal_artist.dart';
import 'tidal_image.dart';

/// Represents the basic informations of an album in the Tidal music service.
///
/// Parameters:
/// - [id]: The unique identifier of the album.
/// - [title]: The title of the album.
/// - [imageCover]: A list of image covers associated with the album.
/// - [videoCover]: A list of video covers associated with the album.
class TidalBaseAlbum extends Equatable {
  final String id;
  final String title;
  final List<TidalImage> imageCover;
  final List<TidalImage> videoCover;

  const TidalBaseAlbum({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.videoCover,
  });

  /// Constructs a TidalBaseAlbum object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing album data.
  TidalBaseAlbum.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        imageCover = (json["imageCover"] as List)
            .map((e) => TidalImage.fromJson(e))
            .toList(),
        videoCover = (json["videoCover"] as List)
            .map((e) => TidalImage.fromJson(e))
            .toList();

  @override
  List<Object?> get props => [id, title, imageCover, videoCover];
}

/// Represents an album in the Tidal music service.
///
/// A [TidalAlbum] is an extendion of [TidalBaseAlbum] and contains information about the album, including its ID, barcode ID, title,
/// duration, release date, number of volumes, number of tracks, number of videos, type, copyright,
/// artists, image cover, video cover, media metadata, and properties.
///
/// This class is used to represent album data retrieved from the Tidal service.
///
/// Parameters:
/// - [id]: The unique identifier of the album.
/// - [barcodeId]: The barcode ID of the album.
/// - [title]: The title of the album.
/// - [duration]: The duration of the album in seconds.
/// - [releaseDate]: The release date of the album.
/// - [numberOfVolumes]: The number of volumes in the album.
/// - [numberOfTracks]: The number of tracks in the album.
/// - [numberOfVideos]: The number of videos in the album.
/// - [type]: The type of the album.
/// - [copyright]: The copyright information related to the album.
/// - [artists]: A list of artists who contributed to the album.
/// - [imageCover]: A list of image covers associated with the album.
/// - [videoCover]: A list of video covers associated with the album.
/// - [mediaMetadata]: Metadata related to the media of the album.
/// - [properties]: Additional properties of the album.
class TidalAlbum extends TidalBaseAlbum {
  final String barcodeId;
  final int duration;
  final DateTime releaseDate;
  final int numberOfVolumes;
  final int numberOfTracks;
  final int numberOfVideos;
  final String type;
  final String copyright;
  final List<TidalMediaArtist> artists;
  final Map<String, dynamic> mediaMetadata;
  final Map<String, dynamic> properties;

  const TidalAlbum({
    required super.id,
    required this.barcodeId,
    required super.title,
    required this.duration,
    required this.releaseDate,
    required this.numberOfVolumes,
    required this.numberOfTracks,
    required this.numberOfVideos,
    required this.type,
    required this.copyright,
    required this.artists,
    required super.imageCover,
    required super.videoCover,
    required this.mediaMetadata,
    required this.properties,
  });

  /// Returns the main artist of the album.
  TidalArtist get mainArtist => artists.singleWhere((artist) => artist.main);

  /// Constructs a TidalAlbum object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing album data.
  TidalAlbum.fromJson(Map<String, dynamic> json)
      : barcodeId = json["barcodeId"],
        duration = json["duration"],
        releaseDate = DateTime.parse(json["releaseDate"]),
        numberOfVolumes = json["numberOfVolumes"],
        numberOfTracks = json["numberOfTracks"],
        numberOfVideos = json["numberOfVideos"],
        type = json["type"],
        copyright = json["copyright"],
        mediaMetadata = json["mediaMetadata"],
        properties = json["properties"],
        artists = (json["artists"] as List)
            .map((e) => TidalMediaArtist.fromJson(e))
            .toList(),
        super.fromJson(json);

  @override
  List<Object?> get props => [
        ...super.props,
        barcodeId,
        duration,
        releaseDate,
        numberOfVolumes,
        numberOfTracks,
        numberOfVideos,
        type,
        copyright,
        artists,
        mediaMetadata,
        properties,
      ];
}
