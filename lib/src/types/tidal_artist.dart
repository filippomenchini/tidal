import 'package:equatable/equatable.dart';

import 'tidal_image.dart';

class TidalArtist extends Equatable {
  final String id;
  final String name;
  final List<TidalImage> picture;

  const TidalArtist({
    required this.id,
    required this.name,
    required this.picture,
  });

  TidalArtist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture = (json['picture'] as List)
            .map((pictureJson) => TidalImage.fromJson(pictureJson))
            .toList();

  @override
  List<Object?> get props => [id, name, picture];
}

class TidalMediaArtist extends TidalArtist {
  final bool main;

  const TidalMediaArtist({
    required this.main,
    required super.id,
    required super.name,
    required super.picture,
  });

  TidalMediaArtist.fromJson(Map<String, dynamic> json)
      : main = json["main"],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, main];
}
