import 'dart:convert';
import 'dart:developer';
import 'package:build_link/data/model/client_model.dart';
import 'package:http/http.dart' as http;

import '../model/house_model.dart';

abstract class HouseRepository {
  static String serverUrl = "127.0.0.1";
  static bool isDebug = false;

  static Future<List<House>?> noteAnalyze({
    required String note,
  }) async {
    var url;
    url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/autoSearch",
      port: 5000,
      queryParameters: {
        "note": note,
      },
    );
    if (isDebug) log(url.normalizePath().toString());
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body) as List<dynamic>;
        List<House> rezult = [];
        for (int i = 0; i < decode.length; i++) {
          var supUrl = Uri(
            scheme: "http",
            host: serverUrl,
            path: "/getImages",
            port: 5000,
            queryParameters: {
              "id": decode[i]["id"]!,
            },
          );
          var supResponse = await http.get(supUrl);
          if (supResponse.statusCode == 200) {
            rezult.add(House.fromJson(decode[i], jsonDecode(supResponse.body)));
          } else {
            log('Request failed with status: ${response.statusCode}.');
            return [];
          }
        }
        return rezult;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Request failed $e');
    }
    return [];
  }

  static Future<List<House>?> searchHouses({
    double? minSq,
    double? maxSq,
    int? maxRooms,
    int? minRooms,
    double? minCost,
    double? maxCost,
    double? maxHeight,
    double? minHeight,
  }) async {
    String where = "where ";
    if (minSq != null || maxSq != null) {
      minSq ??= 0;
      maxSq ??= 10000;
      where += "square_meters <= $maxSq and square_meters >= $minSq and  ";
    }
    if (minRooms != null || maxRooms != null) {
      minRooms ??= 0;
      maxRooms ??= 10000;
      where += "room_count <= $maxRooms and room_count >= $minRooms and  ";
    }
    if (minCost != null || maxCost != null) {
      minCost ??= 0;
      maxCost ??= 100000000000;
      where += "cost <= $maxCost and cost >= $minCost and  ";
    }
    if (minHeight != null || maxHeight != null) {
      minHeight ??= 0;
      maxHeight ??= 10000;
      where += "ceiling_height <= $maxHeight and ceiling_height >= $minHeight and  ";
    }
    where = where.substring(0, where.length - 6);
    var url;
    if (where == "") {
      url = Uri(
        scheme: "http",
        host: serverUrl,
        path: "/searchHouses",
        port: 5000,
        queryParameters: {
          "where": ";",
        },
      );
    } else {
      url = Uri(
        scheme: "http",
        host: serverUrl,
        path: "/searchHouses",
        port: 5000,
        queryParameters: {
          "where": where,
        },
      );
    }
    

    if (isDebug) log(url.normalizePath().toString());
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body) as List<dynamic>;
        List<House> rezult = [];
        for (int i = 0; i < decode.length; i++) {
          var supUrl = Uri(
            scheme: "http",
            host: serverUrl,
            path: "/getImages",
            port: 5000,
            queryParameters: {
              "id": decode[i]["id"]!,
            },
          );
          var supResponse = await http.get(supUrl);
          if (supResponse.statusCode == 200) {
            rezult.add(House.fromJson(decode[i], jsonDecode(supResponse.body)));
          } else {
            log('Request failed with status: ${response.statusCode}.');
            return [];
          }
        }
        return rezult;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Request failed $e');
    }
    return [];
  }

  static Future<House?> getHouse(int id) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/getHome",
      port: 5000,
      queryParameters: {
        "id": (id).toString(),
      },
    );
    var supUrl = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/getImages",
      port: 5000,
      queryParameters: {
        "id": (id).toString(),
      },
    );
    if (isDebug) log(url.normalizePath().toString());
    try {
      var response = await http.get(url);
      var supResponse = await http.get(supUrl);
      if (response.statusCode == 200 && supResponse.statusCode == 200) {
        return House.fromJson(jsonDecode(response.body), jsonDecode(supResponse.body) as List<dynamic>);
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Request failed $e');
    }
    return null;
  }

  static Future<List<Client>> getClients(int agentID) async {
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

        var result = jsonList.map((json) => Client.fromJson(json)).toList();

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
