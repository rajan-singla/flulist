import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper extends GetxController{

  /// Function used to fetch data using `GET` request
  Future<dynamic> get(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: 'jsonplaceholder.typicode.com',
        path: endPoint,
        queryParameters: queryParameters,
      );

      final response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Unable to fetch the data.');
      }
    } on SocketException catch (_) {
      debugPrint('Connection failed');
      rethrow;
    } on Exception catch (_) {
      debugPrint('Unable to process the request');
      rethrow;
    }
  }
}
