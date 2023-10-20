import 'package:equatable/equatable.dart';

class TidalArtist extends Equatable {
  final String id;
  final String name;
  final List<TidalArtistPicture> picture;

  const TidalArtist({
    required this.id,
    required this.name,
    required this.picture,
  });

  TidalArtist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture = (json['picture'] as List)
            .map((pictureJson) => TidalArtistPicture.fromJson(pictureJson))
            .toList();

  @override
  List<Object?> get props => [id, name, picture];
}

class TidalArtistPicture extends Equatable {
  final String url;
  final int width;
  final int height;

  const TidalArtistPicture({
    required this.url,
    required this.width,
    required this.height,
  });

  TidalArtistPicture.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        width = json['width'],
        height = json['height'];

  @override
  List<Object?> get props => [url, width, height];
}

class TidalArtistResponse extends Equatable {
  final String id;
  final int status;
  final String message;
  final TidalArtist artist;

  const TidalArtistResponse({
    required this.id,
    required this.status,
    required this.message,
    required this.artist,
  });

  TidalArtistResponse.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"],
        message = json["message"],
        artist = TidalArtist.fromJson(json["resource"]);

  @override
  List<Object?> get props => [id, status, message, artist];
}

class MultipleTidalArtistsMetadata extends Equatable {
  final int requested;
  final int success;
  final int failure;

  const MultipleTidalArtistsMetadata({
    required this.requested,
    required this.success,
    required this.failure,
  });

  MultipleTidalArtistsMetadata.fromJson(Map<String, dynamic> json)
      : requested = json["requested"],
        success = json["success"],
        failure = json["failure"];

  @override
  List<Object?> get props => [requested, success, failure];
}

class MultipleTidalArtists extends Equatable {
  final List<TidalArtistResponse> artistResponses;
  final MultipleTidalArtistsMetadata metadata;

  const MultipleTidalArtists({
    required this.artistResponses,
    required this.metadata,
  });

  MultipleTidalArtists.fromJson(Map<String, dynamic> json)
      : artistResponses = (json["data"] as List)
            .map((e) => TidalArtistResponse.fromJson(e))
            .toList(),
        metadata = MultipleTidalArtistsMetadata.fromJson(json["metadata"]);

  List<TidalArtist> get artists =>
      artistResponses.map((response) => response.artist).toList();

  @override
  List<Object?> get props => [artistResponses, metadata];
}
