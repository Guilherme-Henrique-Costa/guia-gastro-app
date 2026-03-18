import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String titulo;
  final String? mensagem;
  final String? acaoTexto;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    this.titulo = 'Ops, algo deu errado',
    this.mensagem,
    this.acaoTexto = 'Tentar novamente',
    this.onRetry,
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
              Icon(
                Icons.error_outline_rounded,
                size: 54,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 14),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (mensagem != null) ...[
                const SizedBox(height: 8),
                Text(
                  mensagem!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.35,
                    fontSize: 14,
                  ),
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(acaoTexto ?? 'Tentar novamente'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
