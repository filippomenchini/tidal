import 'dart:convert';

import 'package:http/http.dart' as http;

import '../types/tidal_error.dart';

T handleHttpResponse<T>({
  required http.Response response,
  required T Function(Map<String, dynamic> json) onSuccessfulResponse,
}) {
  final json = jsonDecode(response.body);

  if (response.statusCode == 400) {
    final errors = (json["errors"] as List)
        .map((json) => BadRequestTidalErrorItem.fromJson(json))
        .toList();
    throw TidalError(errors: errors);
  }

  if (response.statusCode > 400) {
    final errors = (json["errors"] as List)
        .map((json) => TidalErrorItem.fromJson(json))
        .toList();
    throw TidalError(errors: errors);
  }

  return onSuccessfulResponse(json);
}
