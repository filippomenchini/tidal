import 'package:equatable/equatable.dart';

class TidalImage extends Equatable {
  final String url;
  final int width;
  final int height;

  const TidalImage({
    required this.url,
    required this.width,
    required this.height,
  });

  TidalImage.fromJson(Map<String, dynamic> json)
      : url = json["url"],
        width = json["width"],
        height = json["width"];

  @override
  List<Object?> get props => [url, width, height];
}
