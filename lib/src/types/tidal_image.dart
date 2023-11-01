import 'package:equatable/equatable.dart';

/// Represents an image in the Tidal service.
///
/// A [TidalImage] contains information about an image, including its URL, width, and height.
///
/// This class is used to represent image data retrieved from the Tidal service.
///
/// Parameters:
/// - [url]: The URL of the image.
/// - [width]: The width of the image.
/// - [height]: The height of the image.
class TidalImage extends Equatable {
  final String url;
  final int width;
  final int height;

  const TidalImage({
    required this.url,
    required this.width,
    required this.height,
  });

  /// Constructs a TidalImage object from JSON data.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing image data.
  TidalImage.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        width = json["width"],
        height = json["width"];

  @override
  List<Object?> get props => [url, width, height];
}
