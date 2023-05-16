import 'dart:convert';

import 'package:http/http.dart' as http;

class RestApiProvider {
  final String baseUrl; // The base URL of your API

  RestApiProvider(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.get(url);
      return _handleResponse(response);
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      return _handleResponse(response);
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      // Successful response
      return json.decode(responseBody);
    } else {
      // Error response
      final error = 'Error - Status Code: $statusCode\n$responseBody';
      throw Exception(error);
    }
  }
}
