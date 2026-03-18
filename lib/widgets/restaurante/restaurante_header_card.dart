import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante_info.dart';

class RestauranteHeaderCard extends StatelessWidget {
  final RestauranteInfo restaurante;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;

  const RestauranteHeaderCard({
    super.key,
    required this.restaurante,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final abre = restaurante.abreEm;
    final fecha = restaurante.fechaEm;

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    restaurante.nome,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: isFavorito ? 'Remover dos favoritos' : 'Favoritar',
                  onPressed: onToggleFavorito,
                  icon: Icon(
                    isFavorito ? Icons.favorite : Icons.favorite_border,
                    color: isFavorito ? Colors.redAccent : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(restaurante.enderecoTexto)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.sell_outlined, size: 18),
                const SizedBox(width: 6),
                Text("Faixa: ${restaurante.faixaPreco ?? '-'}"),
              ],
            ),
            if (abre != null && fecha != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 18),
                  const SizedBox(width: 6),
                  Text("Horário: $abre às $fecha"),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
