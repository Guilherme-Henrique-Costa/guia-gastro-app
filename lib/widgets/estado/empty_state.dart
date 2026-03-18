import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String? subtitulo;
  final String? acaoTexto;
  final VoidCallback? onAcao;

  const EmptyState({
    super.key,
    this.icon = Icons.search_off_rounded,
    required this.titulo,
    this.subtitulo,
    this.acaoTexto,
    this.onAcao,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 54, color: Colors.grey.shade500),
              const SizedBox(height: 14),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitulo != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitulo!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.35,
                    fontSize: 14,
                  ),
                ),
              ],
              if (acaoTexto != null && onAcao != null) ...[
                const SizedBox(height: 16),
                FilledButton(onPressed: onAcao, child: Text(acaoTexto!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
