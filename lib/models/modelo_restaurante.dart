class RestauranteItem {
  final int id;
  final String nome;
  final String? descricaoCurta;
  final String? enderecoTexto;
  final String? faixaPreco;
  final double? latitude;
  final double? longitude;
  final String? abreEm;
  final String? fechaEm;

  final int totalAvaliacoes;
  final double? notaMedia;
  final double? score;
  final int? precoMedioCentavos;
  final int? esperaMediaMin;

  final double? distanciaKm;

  RestauranteItem({
    required this.id,
    required this.nome,
    this.descricaoCurta,
    this.enderecoTexto,
    this.faixaPreco,
    this.latitude,
    this.longitude,
    this.abreEm,
    this.fechaEm,
    required this.totalAvaliacoes,
    this.notaMedia,
    this.score,
    this.precoMedioCentavos,
    this.esperaMediaMin,
    this.distanciaKm,
  });

  factory RestauranteItem.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    int? toInt(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString());
    }

    return RestauranteItem(
      id: (json["id"] as num).toInt(),
      nome: (json["nome"] ?? "").toString(),
      descricaoCurta: json["descricao_curta"]?.toString(),
      enderecoTexto: json["endereco_texto"]?.toString(),
      faixaPreco: json["faixa_preco"]?.toString(),
      latitude: toDouble(json["latitude"]),
      longitude: toDouble(json["longitude"]),
      abreEm: json["abre_em"]?.toString(),
      fechaEm: json["fecha_em"]?.toString(),
      totalAvaliacoes: toInt(json["total_avaliacoes"]) ?? 0,
      notaMedia: toDouble(json["nota_media"]),
      score: toDouble(json["score"]),
      precoMedioCentavos: toInt(json["preco_medio_centavos"]),
      esperaMediaMin: toInt(json["espera_media_min"]),
      distanciaKm: toDouble(json["distancia_km"]),
    );
  }

  RestauranteItem copyWith({double? distanciaKm}) {
    return RestauranteItem(
      id: id,
      nome: nome,
      descricaoCurta: descricaoCurta,
      enderecoTexto: enderecoTexto,
      faixaPreco: faixaPreco,
      latitude: latitude,
      longitude: longitude,
      abreEm: abreEm,
      fechaEm: fechaEm,
      totalAvaliacoes: totalAvaliacoes,
      notaMedia: notaMedia,
      score: score,
      precoMedioCentavos: precoMedioCentavos,
      esperaMediaMin: esperaMediaMin,
      distanciaKm: distanciaKm ?? this.distanciaKm,
    );
  }

  String get precoMedioFormatado {
    if (precoMedioCentavos == null) return "-";
    final valor = precoMedioCentavos! / 100;
    return "R\$ ${valor.toStringAsFixed(2)}";
  }

  String get notaFormatada {
    if (notaMedia == null) return "-";
    return notaMedia!.toStringAsFixed(2);
  }

  String get distanciaFormatada {
    if (distanciaKm == null) return "-";
    if (distanciaKm! < 1) {
      return "${(distanciaKm! * 1000).round()} m";
    }
    return "${distanciaKm!.toStringAsFixed(1)} km";
  }
}
