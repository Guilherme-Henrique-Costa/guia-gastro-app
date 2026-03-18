import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante.dart';

class Top3Card extends StatelessWidget {
  final RestauranteItem item;
  final int posicao;
  final VoidCallback onTap;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;

  const Top3Card({
    super.key,
    required this.item,
    required this.posicao,
    required this.onTap,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final descricao = (item.descricaoCurta ?? '').trim();

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 270,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Top3Header(
              nome: item.nome,
              posicao: posicao,
              isFavorito: isFavorito,
              onToggleFavorito: onToggleFavorito,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.star,
                  label: item.notaMedia?.toStringAsFixed(1) ?? '-',
                ),
                _InfoChip(
                  icon: Icons.payments_outlined,
                  label: item.precoMedioFormatado,
                ),
                _InfoChip(
                  icon: Icons.reviews_outlined,
                  label: '${item.totalAvaliacoes}',
                ),
                if (item.distanciaKm != null)
                  _InfoChip(
                    icon: Icons.location_on_outlined,
                    label: item.distanciaFormatada,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (descricao.isNotEmpty)
              Expanded(
                child: Text(
                  descricao,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
                ),
              )
            else
              const Spacer(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.touch_app, size: 16, color: Colors.deepPurple),
                  SizedBox(width: 6),
                  Text(
                    'Abrir detalhes',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Top3Header extends StatelessWidget {
  final String nome;
  final int posicao;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;

  const _Top3Header({
    required this.nome,
    required this.posicao,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  Color get _badgeColor {
    switch (posicao) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.blueGrey;
      case 3:
        return Colors.brown;
      default:
        return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _badgeColor.withOpacity(0.16),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$posicao',
            style: TextStyle(fontWeight: FontWeight.bold, color: _badgeColor),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            nome,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
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
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12.5)),
        ],
      ),
    );
  }
}
