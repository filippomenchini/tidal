import 'package:http/http.dart' as http;

import 'tidal_album_error.dart';

void handleAlbumHttpStatusCode({
  required http.Response response,
  required Map<String, dynamic> json,
}) {
  if (response.statusCode == 400) {
    throw (json['errors'] as List)
        .map((errorJson) => BadRequestTidalAlbumError.fromJson(errorJson))
        .toList();
  }

  if (response.statusCode > 400) {
    throw (json['errors'] as List)
        .map((errorJson) => TidalAlbumError.fromJson(errorJson))
        .toList();
  }
}
