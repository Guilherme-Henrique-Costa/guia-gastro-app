import 'package:guia_gastro_app/models/modelo_restaurante.dart';
import 'package:guia_gastro_app/models/modelo_tag.dart';

import '../services/api_service.dart';

class RestauranteRepository {
  final ApiService apiService;

  RestauranteRepository(this.apiService);

  Future<List<TagItem>> getTags(String slug) async {
    final items = await apiService.getTags(slug);
    return items.map(TagItem.fromJson).toList();
  }

  Future<List<RestauranteItem>> getTop(String slug, {String? tags}) async {
    final items = await apiService.getTop(slug, tags: tags);
    return items.map(RestauranteItem.fromJson).toList();
  }

  Future<List<RestauranteItem>> getRestaurantes(
    String slug, {
    String? tags,
    bool? abertoAgora,
  }) async {
    final items = await apiService.getRestaurantes(
      slug,
      tags: tags,
      abertoAgora: abertoAgora,
    );
    return items.map(RestauranteItem.fromJson).toList();
  }
}
