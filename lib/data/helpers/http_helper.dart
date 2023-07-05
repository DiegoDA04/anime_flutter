import 'dart:convert';

import 'package:anime_flutter/data/models/anime.dart';

import 'package:http/http.dart' as http;

class HttpHelper {
  static const String baseUrl = "https://api.jikan.moe/v4/top/anime";

  static Future<List<Anime>> fetchTopAnimes(int currentPage) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl?page=$currentPage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['data'] as List)
          .map((e) => Anime.fromJson(e))
          .toList();
    } else {
      return List.empty();
    }
  }
}
