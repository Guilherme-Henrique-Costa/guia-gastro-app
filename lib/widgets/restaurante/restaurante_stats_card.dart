import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante_stats.dart';

class RestauranteStatsCard extends StatelessWidget {
  final RestauranteStats stats;

  const RestauranteStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MetricBox(
                    icon: Icons.star_outline,
                    label: "Nota média",
                    value: stats.notaFormatada,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _MetricBox(
                    icon: Icons.reviews_outlined,
                    label: "Avaliações",
                    value: stats.totalAvaliacoes.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _MetricBox(
                    icon: Icons.attach_money,
                    label: "Preço médio",
                    value: stats.precoMedioFormatado,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _MetricBox(
                    icon: Icons.schedule_outlined,
                    label: "Espera média",
                    value: stats.esperaFormatada,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
