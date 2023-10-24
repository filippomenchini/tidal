import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tidal/src/album/handle_album_http_status_code.dart';
import 'package:tidal/src/album/tidal_album_error.dart';

void main() {
  group('Given an http Response function', () {
    test('Should throw BadRequestTidalAlbumError when status code is 400', () {
      // Arrange
      final response = Response(
        '{  "errors": [    {      "category": "INVALID_REQUEST_ERROR",      "code": "INVALID_ENUM_VALUE",      "detail": "country code must be in ISO2 format",      "field": "countryCode"    },    {      "category": "INVALID_REQUEST_ERROR",      "code": "VALUE_REGEX_MISMATCH",      "detail": "barcode should have a valid EAN-13 or UPC-A format",      "field": "barcodeId"    }  ]}',
        400,
      );

      // Act
      try {
        final json = jsonDecode(response.body);
        handleAlbumHttpStatusCode(response: response, json: json);
      } catch (e) {
        // Assert
        expect(e.runtimeType, List<BadRequestTidalAlbumError>);
      }
    });

    test('Should throw TidalAlbumError when status code is greater than 400',
        () {
      // Arrange
      final response = Response(
        '{  "errors": [    {      "category": "INVALID_REQUEST_ERROR",      "code": "NOT_FOUND",      "detail": "The requested resource (http://foo.bar/my-albums) could not be found"    }  ]}',
        404,
      );

      // Act
      try {
        final json = jsonDecode(response.body);
        handleAlbumHttpStatusCode(response: response, json: json);
      } catch (e) {
        // Assert
        expect(e.runtimeType, List<TidalAlbumError>);
      }
    });
  });
}
