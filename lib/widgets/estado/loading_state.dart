import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final String? mensagem;

  const LoadingState({super.key, this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (mensagem != null) ...[
              const SizedBox(height: 14),
              Text(
                mensagem!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
