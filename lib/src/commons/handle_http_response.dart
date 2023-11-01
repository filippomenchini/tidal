import 'dart:convert';

import 'package:http/http.dart' as http;

import '../types/tidal_error.dart';

/// Handles an HTTP response and processes it based on the provided functions.
///
/// This method handles an HTTP response, checks its status code, and processes
/// the response data using the [onSuccessfulResponse] function when the response
/// is successful (status code 200). If the status code is 400, it handles it as a
/// BadRequest error and if the status code is greater than 400, it handles it
/// as a general Tidal error.
///
/// Parameters:
/// - [response]: The HTTP response to handle.
/// - [onSuccessfulResponse]: A function that processes the JSON response data in case of a successful response.
///
/// Returns: The result of processing the response based on the [onSuccessfulResponse] function.
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
