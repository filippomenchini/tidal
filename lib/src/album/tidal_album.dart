import 'package:equatable/equatable.dart';

import '../artist/tidal_artist.dart';

/// Represents a Tidal album.
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
  final List<TidalAlbumArtist> artists;
  final List<TidalImageCover> imageCover;
  final List<TidalVideoCover> videoCover;
  final TidalAlbumMetadata mediaMetadata;
  final TidalAlbumProperties properties;

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
            .map((e) => TidalImageCover.fromJson(e))
            .toList(),
        videoCover = (json["videoCover"] as List)
            .map((e) => TidalVideoCover.fromJson(e))
            .toList(),
        mediaMetadata = TidalAlbumMetadata.fromJson(json["mediaMetadata"]),
        properties = TidalAlbumProperties.fromJson(json["properties"]),
        artists = (json["artists"] as List)
            .map((e) => TidalAlbumArtist.fromJson(e))
            .toList();

  @override
  String toString() {
    return "ID: $id\nTITLE: $title\nARTIST: ${mainArtist.name}\nCOPYRIGHT: $copyright";
  }

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

/// Represents a Tidal artist of a Tidal album.
class TidalAlbumArtist extends TidalArtist {
  final bool main;

  const TidalAlbumArtist({
    required this.main,
    required super.id,
    required super.name,
    required super.picture,
  });

  /// Constructs a TidalAlbumArtist object from JSON data.
  TidalAlbumArtist.fromJson(Map<String, dynamic> json)
      : main = json["main"],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, main];
}

/// Represents an image cover of an album.
class TidalImageCover extends Equatable {
  final String url;
  final int width;
  final int height;

  const TidalImageCover({
    required this.url,
    required this.width,
    required this.height,
  });

  /// Constructs a TidalImageCover object from JSON data.
  TidalImageCover.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        width = json["width"],
        height = json["height"];

  @override
  List<Object?> get props => [url, width, height];
}

/// Represents an video cover of an album.
class TidalVideoCover extends Equatable {
  final String url;
  final int width;
  final int height;

  const TidalVideoCover({
    required this.url,
    required this.width,
    required this.height,
  });

  /// Constructs a TidalVideoCover object from JSON data.
  TidalVideoCover.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        width = json["width"],
        height = json["height"];

  @override
  List<Object?> get props => [url, width, height];
}

/// Represents the properties of an album.
class TidalAlbumProperties extends Equatable {
  final List<String> content;

  const TidalAlbumProperties({
    required this.content,
  });

  /// Constructs a TidalAlbumProperties from JSON data.
  TidalAlbumProperties.fromJson(Map<String, dynamic> json)
      : content = (json["content"] as List).map((e) => e.toString()).toList();

  @override
  List<Object?> get props => [content];
}

/// Represents the metadata of an album.
class TidalAlbumMetadata extends Equatable {
  final List<String> tags;

  const TidalAlbumMetadata({
    required this.tags,
  });

  /// Constructs a TidalAlbumMetadata from JSON data.
  TidalAlbumMetadata.fromJson(Map<String, dynamic> json)
      : tags = (json["tags"] as List).map((e) => e.toString()).toList();

  @override
  List<Object?> get props => [tags];
}

class TidalAlbumResponse extends Equatable {
  final TidalAlbum album;
  final String id;
  final int status;
  final String message;

  const TidalAlbumResponse({
    required this.album,
    required this.id,
    required this.status,
    required this.message,
  });

  TidalAlbumResponse.fromJson(Map<String, dynamic> json)
      : album = TidalAlbum.fromJson(json["resource"]),
        id = json["id"],
        status = json["status"],
        message = json["message"];

  @override
  List<Object?> get props => [album, id, status, message];
}

class MultipleTidalAlbumsMetadata extends Equatable {
  final int total;

  const MultipleTidalAlbumsMetadata({
    required this.total,
  });

  MultipleTidalAlbumsMetadata.fromJson(Map<String, dynamic> json)
      : total = json["total"];

  @override
  List<Object?> get props => [total];
}

class MultipleTidalAlbums extends Equatable {
  final List<TidalAlbumResponse> albumResponses;
  final MultipleTidalAlbumsMetadata metadata;

  const MultipleTidalAlbums({
    required this.albumResponses,
    required this.metadata,
  });

  MultipleTidalAlbums.fromJson(Map<String, dynamic> json)
      : albumResponses = (json["data"] as List)
            .map((e) => TidalAlbumResponse.fromJson(e))
            .toList(),
        metadata = MultipleTidalAlbumsMetadata.fromJson(json["metadata"]);

  @override
  List<Object?> get props => [albumResponses, metadata];
}
