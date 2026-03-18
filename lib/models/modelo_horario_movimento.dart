class HorarioMovimentoItem {
  final int hora;
  final int totalVisitas;
  final double lotacaoMedia;

  HorarioMovimentoItem({
    required this.hora,
    required this.totalVisitas,
    required this.lotacaoMedia,
  });

  factory HorarioMovimentoItem.fromJson(Map<String, dynamic> json) {
    return HorarioMovimentoItem(
      hora: (json["hora"] as num).toInt(),
      totalVisitas: (json["total_visitas"] as num).toInt(),
      lotacaoMedia: (json["lotacao_media"] as num).toDouble(),
    );
  }
}
