import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:8000';

class BaseClient {
  var client = http.Client();

  //GET request
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      "Access-Control-Allow-Origin": "*",
    };
    var response = await client.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return response.body;
    }
  }

  //POST request
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var response = await client.post(url, body: _payload);
    if (response.statusCode == 201) {
      return response.body;
    }
  }

  Future<dynamic> put() async {}
}
