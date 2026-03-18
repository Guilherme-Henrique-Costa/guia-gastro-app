class RestauranteStats {
  final double? notaMedia;
  final int totalAvaliacoes;
  final int? esperaMediaMin;
  final int? precoMedioCentavos;

  const RestauranteStats({
    this.notaMedia,
    required this.totalAvaliacoes,
    this.esperaMediaMin,
    this.precoMedioCentavos,
  });

  factory RestauranteStats.fromJson(Map<String, dynamic> json) {
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

    return RestauranteStats(
      notaMedia: toDouble(json['nota_media']),
      totalAvaliacoes: toInt(json['total_avaliacoes']) ?? 0,
      esperaMediaMin: toInt(json['espera_media_min']),
      precoMedioCentavos: toInt(json['preco_medio_centavos']),
    );
  }

  String get notaFormatada {
    if (notaMedia == null) return '-';
    return notaMedia!.toStringAsFixed(1);
  }

  String get precoMedioFormatado {
    if (precoMedioCentavos == null) return '-';
    final valor = precoMedioCentavos! / 100;
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  String get esperaFormatada {
    if (esperaMediaMin == null) return '-';
    return '${esperaMediaMin!} min';
  }
}
