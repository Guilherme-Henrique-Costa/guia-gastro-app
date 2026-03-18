import 'package:guia_gastro_app/core/modo_ordenacao.dart';
import 'package:guia_gastro_app/models/filtro_restaurante.dart';
import 'package:guia_gastro_app/models/modelo_restaurante.dart';

class RestauranteFilterEngine {
  static List<RestauranteItem> apply({
    required List<RestauranteItem> items,
    required FiltroRestaurante filtro,
  }) {
    var result = [...items];

    result = _applySearch(result, filtro);
    result = _applyFaixaPreco(result, filtro);
    result = _applyAdvancedFilters(result, filtro);
    result = _applySort(result, filtro.ordenacao);

    return result;
  }

  static List<RestauranteItem> _applySearch(
    List<RestauranteItem> source,
    FiltroRestaurante filtro,
  ) {
    final q = filtro.busca.trim().toLowerCase();
    if (q.isEmpty) return source;

    return source.where((r) {
      final nome = r.nome.toLowerCase();
      final desc = (r.descricaoCurta ?? "").toLowerCase();
      final endereco = (r.enderecoTexto ?? "").toLowerCase();

      return nome.contains(q) || desc.contains(q) || endereco.contains(q);
    }).toList();
  }

  static List<RestauranteItem> _applyFaixaPreco(
    List<RestauranteItem> source,
    FiltroRestaurante filtro,
  ) {
    if (filtro.faixaPreco == null || filtro.faixaPreco!.isEmpty) {
      return source;
    }

    return source.where((r) => r.faixaPreco == filtro.faixaPreco).toList();
  }

  static List<RestauranteItem> _applyAdvancedFilters(
    List<RestauranteItem> source,
    FiltroRestaurante filtro,
  ) {
    return source.where((r) {
      if (filtro.notaMinima != null &&
          (r.notaMedia ?? 0) < filtro.notaMinima!) {
        return false;
      }

      if (filtro.esperaMaximaMin != null &&
          (r.esperaMediaMin ?? 999999) > filtro.esperaMaximaMin!) {
        return false;
      }

      if (filtro.somenteProximos && r.distanciaKm == null) {
        return false;
      }

      if (filtro.distanciaMaxKm != null &&
          r.distanciaKm != null &&
          r.distanciaKm! > filtro.distanciaMaxKm!) {
        return false;
      }

      return true;
    }).toList();
  }

  static List<RestauranteItem> _applySort(
    List<RestauranteItem> source,
    SortMode sortMode,
  ) {
    final list = [...source];

    switch (sortMode) {
      case SortMode.ranking:
        list.sort((a, b) => (b.score ?? 0).compareTo(a.score ?? 0));
        break;

      case SortMode.nota:
        list.sort((a, b) => (b.notaMedia ?? 0).compareTo(a.notaMedia ?? 0));
        break;

      case SortMode.precoMenor:
        list.sort(
          (a, b) =>
              (a.precoMedioCentavos ?? 0).compareTo(b.precoMedioCentavos ?? 0),
        );
        break;

      case SortMode.esperaMenor:
        list.sort(
          (a, b) => (a.esperaMediaMin ?? 0).compareTo(b.esperaMediaMin ?? 0),
        );
        break;

      case SortMode.maisAvaliacoes:
        list.sort((a, b) => b.totalAvaliacoes.compareTo(a.totalAvaliacoes));
        break;

      case SortMode.proximidade:
        list.sort(
          (a, b) =>
              (a.distanciaKm ?? 999999).compareTo(b.distanciaKm ?? 999999),
        );
        break;
    }

    return list;
  }
}
