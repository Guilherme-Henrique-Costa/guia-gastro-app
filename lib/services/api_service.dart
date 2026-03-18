import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';

class ApiService {
  Uri _uri(String path, [Map<String, String>? query]) {
    return Uri.parse(
      "${ApiConfig.baseUrl}$path",
    ).replace(queryParameters: query);
  }

  Future<List<Map<String, dynamic>>> getTags(String slug) async {
    final res = await http.get(_uri("/api/regioes/$slug/tags"));
    if (res.statusCode != 200) {
      throw Exception("Erro ${res.statusCode}: ${res.body}");
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data["items"] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getTop(
    String slug, {
    int days = 7,
    int limit = 10,
    String? tags,
  }) async {
    final q = <String, String>{"days": "$days", "limit": "$limit"};
    if (tags != null && tags.trim().isNotEmpty) {
      q["tags"] = tags;
    }

    final res = await http.get(_uri("/api/regioes/$slug/top", q));
    if (res.statusCode != 200) {
      throw Exception("Erro ${res.statusCode}: ${res.body}");
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data["items"] as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getRestaurantes(
    String slug, {
    String? tags,
    bool? abertoAgora,
  }) async {
    final q = <String, String>{};
    if (tags != null && tags.trim().isNotEmpty) {
      q["tags"] = tags;
    }
    if (abertoAgora == true) {
      q["abertoAgora"] = "true";
    }

    final res = await http.get(_uri("/api/regioes/$slug/restaurantes", q));
    if (res.statusCode != 200) {
      throw Exception("Erro ${res.statusCode}: ${res.body}");
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data["items"] as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getDetalheRestaurante(int id) async {
    final res = await http.get(_uri("/api/restaurantes/$id"));
    if (res.statusCode != 200) {
      throw Exception("Erro ${res.statusCode}: ${res.body}");
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getHorarios(int id, {int days = 30}) async {
    final res = await http.get(
      _uri("/api/restaurantes/$id/horarios", {"days": "$days"}),
    );
    if (res.statusCode != 200) {
      throw Exception("Erro ${res.statusCode}: ${res.body}");
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
