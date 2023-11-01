import 'package:equatable/equatable.dart';

import 'tidal_image.dart';

/// Represents an artist in the Tidal music service.
///
/// A [TidalArtist] contains information about the artist, including their ID, name, and pictures.
///
/// This class is used to represent artist data retrieved from the Tidal service.
///
/// Parameters:
/// - [id]: The unique identifier of the artist.
/// - [name]: The name of the artist.
/// - [picture]: A list of images associated with the artist.
class TidalArtist extends Equatable {
  final String id;
  final String name;
  final List<TidalImage> picture;

  const TidalArtist({
    required this.id,
    required this.name,
    required this.picture,
  });

  /// Constructs a TidalArtist object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing artist data.
  TidalArtist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture = (json['picture'] as List)
            .map((pictureJson) => TidalImage.fromJson(pictureJson))
            .toList();

  @override
  List<Object?> get props => [id, name, picture];
}

/// Represents an artist associated with media in the Tidal music service.
///
/// A [TidalMediaArtist] extends [TidalArtist] to include information about whether the artist
/// is the main artist for the media.
///
/// This class is used to represent artist data associated with media retrieved from the Tidal service.
///
/// Parameters:
/// - [main]: Indicates whether the artist is the main artist for the media.
/// - [id]: The unique identifier of the artist.
/// - [name]: The name of the artist.
/// - [picture]: A list of images associated with the artist.
class TidalMediaArtist extends TidalArtist {
  final bool main;

  const TidalMediaArtist({
    required this.main,
    required super.id,
    required super.name,
    required super.picture,
  });

  /// Constructs a TidalMediaArtist object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing artist data.
  TidalMediaArtist.fromJson(Map<String, dynamic> json)
      : main = json["main"],
        super.fromJson(json);

  @override
  List<Object?> get props => [...super.props, main];
}
