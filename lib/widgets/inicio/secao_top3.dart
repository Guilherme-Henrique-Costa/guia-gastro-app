import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante.dart';
import 'package:guia_gastro_app/widgets/inicio/top3_card.dart';

class SecaoTop3 extends StatelessWidget {
  final List<RestauranteItem> items;
  final void Function(RestauranteItem item) onTap;
  final bool Function(int restauranteId) isFavorito;
  final void Function(int restauranteId) onToggleFavorito;

  const SecaoTop3({
    super.key,
    required this.items,
    required this.onTap,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: Row(
            children: [
              Icon(Icons.local_fire_department, size: 18),
              SizedBox(width: 8),
              Text(
                'Top 3 agora',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Top3Card(
                  item: item,
                  posicao: index + 1,
                  onTap: () => onTap(item),
                  isFavorito: isFavorito(item.id),
                  onToggleFavorito: () => onToggleFavorito(item.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
