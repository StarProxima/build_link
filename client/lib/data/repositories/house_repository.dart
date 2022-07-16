import 'dart:convert';
import 'dart:developer';
import 'package:build_link/data/model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/house_model.dart';

abstract class HouseRepository {
  static String serverUrl = "127.0.0.1";
  static String userId = "5000";
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
      log('Request failed $e');
    }
    return null;
  }

  static Future<List<ClientModel>> getClients(int agentID) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/getCards",
      port: 5000,
      queryParameters: {"id": agentID.toString()},
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonList = const JsonDecoder().convert(response.body) as List<dynamic>;

        print(jsonList.runtimeType);

        var result = jsonList.map((json) => ClientModel.fromJson(json)).toList();

        return result;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Request failed $e');
    }
    return [];
  }
}
