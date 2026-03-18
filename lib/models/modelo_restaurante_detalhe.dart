import 'package:guia_gastro_app/models/modelo_horario_movimento.dart';
import 'package:guia_gastro_app/models/modelo_restaurante_info.dart';
import 'package:guia_gastro_app/models/modelo_restaurante_stats.dart';

class RestauranteDetalheData {
  final RestauranteInfo restaurante;
  final RestauranteStats stats;
  final List<HorarioMovimentoItem> horarios;

  RestauranteDetalheData({
    required this.restaurante,
    required this.stats,
    required this.horarios,
  });

  factory RestauranteDetalheData.fromResponses({
    required Map<String, dynamic> detalhe,
    required Map<String, dynamic> horarios,
  }) {
    final series = (horarios["series"] as List<dynamic>? ?? [])
        .map((e) => HorarioMovimentoItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return RestauranteDetalheData(
      restaurante: RestauranteInfo.fromJson(
        detalhe["restaurante"] as Map<String, dynamic>,
      ),
      stats: RestauranteStats.fromJson(
        detalhe["stats"] as Map<String, dynamic>,
      ),
      horarios: series,
    );
  }
}
