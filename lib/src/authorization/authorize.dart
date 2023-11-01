import 'dart:convert';

import 'package:http/http.dart' as http;

import 'tidal_auth_error.dart';
import 'tidal_auth_token.dart';

const _authorizeEndpointUrl = 'https://auth.tidal.com/v1/oauth2/token';
const _contentTypeHeader = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
const _authorizationRequestBody = 'grant_type=client_credentials';

/// Authorizes access to the Tidal API by obtaining an authentication token.
///
/// This method performs the necessary steps to obtain an authentication token
/// for accessing the Tidal API. It requires the [clientId] and [clientSecret]
/// for authentication. The [currentDateTime] is used to set the token's
/// creation time.
///
/// Parameters:
/// - [client]: The HTTP client used to make the API request.
/// - [clientId]: The client ID for authentication.
/// - [clientSecret]: The client secret for authentication.
/// - [currentDateTime]: The current date and time used to set the token's creation time.
///
/// Returns: A [TidalAuthToken] object containing the obtained authentication token.
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
