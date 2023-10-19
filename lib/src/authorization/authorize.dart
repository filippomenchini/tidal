import 'dart:convert';

import 'package:http/http.dart' as http;

import 'tidal_auth_error.dart';
import 'tidal_auth_token.dart';

const _authorizeEndpointUrl = 'https://auth.tidal.com/v1/oauth2/token';
const _authorizationRequestBody = 'grant_type=client_credentials';

Future<TidalAuthToken> authorize(
  http.Client client, {
  required String clientId,
  required String clientSecret,
  required DateTime currentDateTime,
}) async {
  final credentials = "$clientId:$clientSecret";
  final utf8Credentials = utf8.encode(credentials);
  final encodedCredentials = base64Encode(utf8Credentials);
  final headers = {'Authorization': 'Basic $encodedCredentials'};

  final response = await client.post(
    Uri.parse(_authorizeEndpointUrl),
    headers: headers,
    body: _authorizationRequestBody,
  );

  if (response.statusCode != 200) {
    throw TidalAuthError(
      errorCode: response.statusCode.toString(),
      errorMesssage: response.body,
    );
  }

  final json = jsonDecode(response.body);
  return TidalAuthToken.fromJson(
    json: json,
    createdAt: currentDateTime,
  );
}
