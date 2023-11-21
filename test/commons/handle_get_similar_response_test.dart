import 'dart:convert';

import 'package:test/test.dart';
import 'package:tidal/src/commons/handle_get_similar_response.dart';

void main() {
  group('Given an entity id and a contry code', () {
    test('Should return an list of similar entity ids', () {
      // Arrange
      final json = jsonDecode(
          '''{  "data": [    {      "resource": {        "id": "251380836"      }    }  ],  "metadata": {    "total": 10  }}''');
      final expectedResult = ['251380836'];

      // Act
      final result = handleGetSimilarResponse(json);

      // Assert
      expect(result, expectedResult);
    });
  });
}
