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
  final String width;
  final String height;

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
