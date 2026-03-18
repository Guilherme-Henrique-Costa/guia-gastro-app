import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante.dart';

class CardRestaurante extends StatelessWidget {
  final RestauranteItem item;
  final int index;
  final VoidCallback onTap;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;

  const CardRestaurante({
    super.key,
    required this.item,
    required this.index,
    required this.onTap,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final descricao = (item.descricaoCurta ?? '').trim();
    final endereco = (item.enderecoTexto ?? '').trim();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RankingBadge(posicao: index + 1),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.nome,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: isFavorito
                              ? 'Remover dos favoritos'
                              : 'Favoritar',
                          onPressed: onToggleFavorito,
                          icon: Icon(
                            isFavorito ? Icons.favorite : Icons.favorite_border,
                            color: isFavorito
                                ? Colors.redAccent
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _InfoChip(icon: Icons.star, label: item.notaFormatada),
                        _InfoChip(
                          icon: Icons.reviews_outlined,
                          label: item.totalAvaliacoes.toString(),
                        ),
                        _InfoChip(
                          icon: Icons.payments_outlined,
                          label: item.precoMedioFormatado,
                        ),
                        if (item.distanciaKm != null)
                          _InfoChip(
                            icon: Icons.location_on_outlined,
                            label: item.distanciaFormatada,
                          ),
                      ],
                    ),
                    if (descricao.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        descricao,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                      ),
                    ],
                    if (endereco.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 16,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              endereco,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F2FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Ver detalhes',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankingBadge extends StatelessWidget {
  final int posicao;

  const _RankingBadge({required this.posicao});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.10),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$posicao',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
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
          Text(
            label,
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
