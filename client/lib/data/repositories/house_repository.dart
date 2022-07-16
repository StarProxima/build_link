import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/house_model.dart';
abstract class HouseRepository {
  static String serverUrl = "127.0.0.1";
  static bool isDebug = false;

  static Future<HouseModel?> getHouse() async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/getHome",
      port: 5000,
      queryParameters: {
        "id": "1",
      },
    );
    if (isDebug) log(url.normalizePath().toString());
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        
        return HouseModel.fromJson(jsonDecode(response.body));
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

}