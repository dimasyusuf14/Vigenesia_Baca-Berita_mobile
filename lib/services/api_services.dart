import 'dart:convert';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'utilities/utilities.dart';

enum APIMethod { post, get, delete, put }

class APIServices {
  static var client = http.Client();

  static Future<dynamic> api({
    var requestBodyMap =
        const {}, // This is your data parameter for POST/PUT requests
    required String endPoint,
    bool withToken = true,
    String param = "",
    required APIMethod type, // Change var to APIMethod for type safety
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // Add Authorization header if token is available
    if (withToken) {
      final box = GetStorage();
      var token = box.read("token");
      logPrint("Token : $token");
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      } else {
        logPrint("No token found");
      }
    }

    logPrint("REQUEST BODY : ${jsonEncode(requestBodyMap)}");

    var response;

    // Make the request based on the method type
    switch (type) {
      case APIMethod.post:
        response = await client.post(
          Uri.parse("$kBaseUrl$endPoint$param"),
          headers: headers,
          body: requestBodyMap.isNotEmpty ? jsonEncode(requestBodyMap) : null,
        );
        break;

      case APIMethod.get:
        response = await client.get(
          Uri.parse("$kBaseUrl$endPoint$param"),
          headers: headers,
        );
        break;

      case APIMethod.put:
        response = await client.put(
          Uri.parse("$kBaseUrl$endPoint$param"),
          headers: headers,
          body: requestBodyMap.isNotEmpty ? jsonEncode(requestBodyMap) : null,
        );
        break;

      case APIMethod.delete:
        response = await client.delete(
          Uri.parse("$kBaseUrl$endPoint$param"),
          headers: headers,
        );
        break;
    }

    logPrint("URL PARSE : ${Uri.parse("$kBaseUrl$endPoint$param")}");
    logPrint("$endPoint RESPONSE BODY : ${response.body}");

    // Handle the response
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      logPrint('ERROR SERVICES ${json.decode(response.body)}');
      throw Exception(
          'Failed to load data: ${response.statusCode}'); // Throw an exception for error handling
    }
  }
}

