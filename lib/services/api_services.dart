// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:baca_berita/model/home/home_model.dart';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'utilities/utilities.dart';

enum APIMethod { post, get, delete, put }

class APIServices {
  static var client = http.Client();

  static Future<dynamic> api({
    var requestBodyMap = const {},
    required String endPoint,
    bool withToken = true,
    String param = "",
    required APIMethod type,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

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

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      logPrint('ERROR SERVICES ${json.decode(response.body)}');
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<void> insertBerita(NewsModel berita, File? imageFile) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');

      // Buat MultipartRequest
      var uri = Uri.parse('$kBaseUrl${APIEndpoint.news}');
      var request = http.MultipartRequest('POST', uri);

      // Tambahkan header authorization
      request.headers.addAll({
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'Keep-Alive',
        'Authorization': 'Bearer $token',
      });

      // Tambahkan data berita sebagai fields
      request.fields['title'] = berita.title; // Menambahkan title
      request.fields['description'] =
          berita.description; // Menambahkan description
      request.fields['cover'] = berita.cover; // Menambahkan cover

      // Jika ada gambar, tambahkan sebagai file
      if (imageFile != null) {
        var fileStream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'cover', // Pastikan nama field ini sesuai dengan yang diharapkan API
          fileStream,
          length,
          filename: basename(
              imageFile.path), // Menggunakan basename dari package `path`
        );

        request.files.add(multipartFile);
      }

      // Kirim request dan tunggu respons
      var response = await request.send();

      // Cek status code dari response
      if (response.statusCode == 201) {
        print('Berita berhasil ditambahkan');
      } else {
        print('Gagal menambahkan berita: ${response.statusCode}');
        // Anda dapat menambahkan logika tambahan di sini untuk menangani kesalahan
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      // Anda dapat menambahkan logika tambahan di sini untuk menangani kesalahan
    }
  }
}
