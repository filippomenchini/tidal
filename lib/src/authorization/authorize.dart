import 'dart:convert';

import 'package:http/http.dart' as http;

import 'tidal_auth_error.dart';
import 'tidal_auth_token.dart';

const _authorizeEndpointUrl = 'https://auth.tidal.com/v1/oauth2/token';
const _contentTypeHeader = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
const _authorizationRequestBody = 'grant_type=client_credentials';

/// Authorizes and retrieves a Tidal authentication token.
///
/// [client] is an HTTP client for making the authorization request.
/// [clientId] is the client ID for authentication.
/// [clientSecret] is the client secret for authentication.
/// [currentDateTime] is the current date and time for token creation.
///
/// Returns a [TidalAuthToken] object representing the obtained authentication token.
///
/// Throws a [TidalAuthError] in case of an unsuccessful authorization, including the error code and message.
Future<TidalAuthToken> authorize(
  http.Client client, {
  required String clientId,
  required String clientSecret,
  required DateTime currentDateTime,
}) async {
  final credentials = "$clientId:$clientSecret";
  final utf8Credentials = utf8.encode(credentials);
  final encodedCredentials = base64Encode(utf8Credentials);
  final headers = {
    'Authorization': 'Basic $encodedCredentials',
    ..._contentTypeHeader,
  };

  final response = await client.post(
    Uri.parse(_authorizeEndpointUrl),
    headers: headers,
    body: _authorizationRequestBody,
  );

  if (response.statusCode != 200) {
    throw TidalAuthError(
      errorCode: response.statusCode.toString(),
      errorMessage: response.body,
    );
  }

  final json = jsonDecode(response.body);
  return TidalAuthToken.fromJson(
    json: json,
    createdAt: currentDateTime,
  );
}
