import 'package:guia_gastro_app/core/modo_ordenacao.dart';

class FiltroRestaurante {
  final String busca;
  final Set<String> tagsSelecionadas;
  final bool abertoAgora;
  final String? faixaPreco;
  final SortMode ordenacao;
  final double? notaMinima;
  final int? esperaMaximaMin;
  final double? distanciaMaxKm;
  final bool somenteProximos;

  const FiltroRestaurante({
    this.busca = '',
    this.tagsSelecionadas = const {},
    this.abertoAgora = false,
    this.faixaPreco,
    this.ordenacao = SortMode.ranking,
    this.notaMinima,
    this.esperaMaximaMin,
    this.distanciaMaxKm,
    this.somenteProximos = false,
  });

  FiltroRestaurante copyWith({
    String? busca,
    Set<String>? tagsSelecionadas,
    bool? abertoAgora,
    String? faixaPreco,
    SortMode? ordenacao,
    double? notaMinima,
    int? esperaMaximaMin,
    double? distanciaMaxKm,
    bool? somenteProximos,
    bool limparFaixaPreco = false,
    bool limparNotaMinima = false,
    bool limparEsperaMaxima = false,
    bool limparDistanciaMaxima = false,
  }) {
    return FiltroRestaurante(
      busca: busca ?? this.busca,
      tagsSelecionadas: tagsSelecionadas ?? this.tagsSelecionadas,
      abertoAgora: abertoAgora ?? this.abertoAgora,
      faixaPreco: limparFaixaPreco ? null : (faixaPreco ?? this.faixaPreco),
      ordenacao: ordenacao ?? this.ordenacao,
      notaMinima: limparNotaMinima ? null : (notaMinima ?? this.notaMinima),
      esperaMaximaMin: limparEsperaMaxima
          ? null
          : (esperaMaximaMin ?? this.esperaMaximaMin),
      distanciaMaxKm: limparDistanciaMaxima
          ? null
          : (distanciaMaxKm ?? this.distanciaMaxKm),
      somenteProximos: somenteProximos ?? this.somenteProximos,
    );
  }

  FiltroRestaurante limparFiltrosAvancados() {
    return copyWith(
      limparNotaMinima: true,
      limparEsperaMaxima: true,
      limparDistanciaMaxima: true,
      somenteProximos: false,
    );
  }
}
