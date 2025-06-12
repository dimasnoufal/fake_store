import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String baseUrl;
  Api(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'), headers: {
      'Content-Type': 'application/json',
    });
    return json.decode(response.body);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return json.decode(response.body);
  }
}
