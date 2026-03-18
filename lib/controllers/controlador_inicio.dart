import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guia_gastro_app/core/filtros/restaurante_filter_engine.dart';
import 'package:guia_gastro_app/core/modo_ordenacao.dart';
import 'package:guia_gastro_app/models/filtro_restaurante.dart';
import 'package:guia_gastro_app/models/modelo_restaurante.dart';
import 'package:guia_gastro_app/models/modelo_tag.dart';
import '../repositories/restaurante_repository.dart';
import '../services/localizacao_service.dart';

class InicioController extends ChangeNotifier {
  final RestauranteRepository repository;
  final LocalizacaoService localizacaoService;
  final String slug;
  final bool usarRanking;

  InicioController({
    required this.repository,
    required this.localizacaoService,
    required this.slug,
    this.usarRanking = true,
  });

  List<TagItem> tags = [];
  List<RestauranteItem> items = [];

  FiltroRestaurante filtro = const FiltroRestaurante();

  Position? currentPosition;

  bool loading = false;
  String? error;

  Timer? _searchDebounce;

  Future<void> init() async {
    await Future.wait([loadTags(), refreshLocationSilently(), loadItems()]);
  }

  Future<void> refreshLocationSilently() async {
    try {
      currentPosition = await localizacaoService.getCurrentPosition();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> loadTags() async {
    try {
      tags = await repository.getTags(slug);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadItems() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final tagsParam = filtro.tagsSelecionadas.isEmpty
          ? null
          : filtro.tagsSelecionadas.join(',');

      List<RestauranteItem> result;

      if (usarRanking && !filtro.abertoAgora) {
        result = await repository.getTop(slug, tags: tagsParam);
      } else {
        result = await repository.getRestaurantes(
          slug,
          tags: tagsParam,
          abertoAgora: filtro.abertoAgora,
        );
      }

      result = _attachDistance(result);

      result = RestauranteFilterEngine.apply(items: result, filtro: filtro);

      items = result;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  List<RestauranteItem> _attachDistance(List<RestauranteItem> source) {
    if (currentPosition == null) return source;

    return source.map((r) {
      if (r.latitude == null || r.longitude == null) return r;

      final km = localizacaoService.distanceKm(
        startLat: currentPosition!.latitude,
        startLng: currentPosition!.longitude,
        endLat: r.latitude!,
        endLng: r.longitude!,
      );

      return r.copyWith(distanciaKm: km);
    }).toList();
  }

  void setSearchText(String value) {
    filtro = filtro.copyWith(busca: value);

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      loadItems();
    });
  }

  void setAbertoAgora(bool value) {
    filtro = filtro.copyWith(abertoAgora: value);
    loadItems();
  }

  void setFaixaPreco(String? value) {
    final novaFaixa = filtro.faixaPreco == value ? null : value;
    filtro = filtro.copyWith(faixaPreco: novaFaixa);
    loadItems();
  }

  void setSortMode(SortMode value) {
    filtro = filtro.copyWith(ordenacao: value);
    loadItems();
  }

  void toggleTag(String slug) {
    final novasTags = Set<String>.from(filtro.tagsSelecionadas);

    if (novasTags.contains(slug)) {
      novasTags.remove(slug);
    } else {
      novasTags.add(slug);
    }

    filtro = filtro.copyWith(tagsSelecionadas: novasTags);
    loadItems();
  }

  void removeTag(String slug) {
    final novasTags = Set<String>.from(filtro.tagsSelecionadas)..remove(slug);
    filtro = filtro.copyWith(tagsSelecionadas: novasTags);
    loadItems();
  }

  void clearTags() {
    filtro = filtro.copyWith(tagsSelecionadas: <String>{});
    loadItems();
  }

  void setOnlyTags(List<String> slugs) {
    filtro = filtro.copyWith(tagsSelecionadas: slugs.toSet());
    loadItems();
  }

  Future<void> ativarProximosDeMim() async {
    currentPosition = await localizacaoService.getCurrentPosition();
    filtro = filtro.copyWith(
      somenteProximos: true,
      ordenacao: SortMode.proximidade,
    );
    await loadItems();
  }

  void limparFiltrosAvancados() {
    filtro = filtro.limparFiltrosAvancados();
    loadItems();
  }

  void aplicarFiltrosAvancados({
    double? novaNotaMinima,
    int? novaEsperaMaxima,
    double? novaDistanciaMaxKm,
    bool? novoSomenteProximos,
  }) {
    filtro = filtro.copyWith(
      notaMinima: novaNotaMinima,
      esperaMaximaMin: novaEsperaMaxima,
      distanciaMaxKm: novaDistanciaMaxKm,
      somenteProximos: novoSomenteProximos ?? filtro.somenteProximos,
    );
    loadItems();
  }

  List<RestauranteItem> get top3 => items.take(3).toList();
  List<RestauranteItem> get restantes => items.skip(3).toList();

  Set<String> get selectedTags => filtro.tagsSelecionadas;
  bool get abertoAgora => filtro.abertoAgora;
  SortMode get sortMode => filtro.ordenacao;
  double? get notaMinima => filtro.notaMinima;
  int? get esperaMaximaMin => filtro.esperaMaximaMin;
  double? get distanciaMaxKm => filtro.distanciaMaxKm;
  bool get somenteProximos => filtro.somenteProximos;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
