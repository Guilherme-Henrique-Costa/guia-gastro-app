import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_horario_movimento.dart';

class RestauranteHorariosCard extends StatelessWidget {
  final List<HorarioMovimentoItem> horarios;

  const RestauranteHorariosCard({super.key, required this.horarios});

  @override
  Widget build(BuildContext context) {
    if (horarios.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Colors.black12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Sem dados de horários ainda."),
        ),
      );
    }

    final maxVisitas = horarios
        .map((h) => h.totalVisitas)
        .reduce((a, b) => a > b ? a : b);

    final horaPico = horarios.firstWhere(
      (h) => h.totalVisitas == maxVisitas,
      orElse: () => horarios.first,
    );

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Horários mais movimentados",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "Pico em ${horaPico.hora}h • ${horaPico.totalVisitas} visitas",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),
            const SizedBox(height: 14),
            ...horarios.map((h) {
              final ratio = maxVisitas == 0 ? 0.0 : h.totalVisitas / maxVisitas;
              final isPeak = h.hora == horaPico.hora;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: _HorarioBar(
                  hora: h.hora,
                  visitas: h.totalVisitas,
                  lotacaoMedia: h.lotacaoMedia,
                  progress: ratio,
                  destaque: isPeak,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _HorarioBar extends StatelessWidget {
  final int hora;
  final int visitas;
  final double lotacaoMedia;
  final double progress;
  final bool destaque;

  const _HorarioBar({
    required this.hora,
    required this.visitas,
    required this.lotacaoMedia,
    required this.progress,
    required this.destaque,
  });

  String get faixaLotacao {
    if (lotacaoMedia >= 4.5) return "Muito cheio";
    if (lotacaoMedia >= 3.5) return "Cheio";
    if (lotacaoMedia >= 2.5) return "Moderado";
    if (lotacaoMedia >= 1.5) return "Tranquilo";
    return "Vazio";
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = destaque ? Colors.deepPurple : Colors.deepPurple.shade200;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 42,
          child: Text(
            "${hora}h",
            style: TextStyle(
              fontWeight: destaque ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "$faixaLotacao • lotação ${lotacaoMedia.toStringAsFixed(1)}",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
          child: Text(
            "$visitas visita${visitas == 1 ? '' : 's'}",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: destaque ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
