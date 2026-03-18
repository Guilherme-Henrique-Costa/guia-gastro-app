import 'package:flutter/material.dart';

class BarraTagsSelecionadas extends StatelessWidget {
  final Set<String> selectedTags;
  final void Function(String tag) onRemove;
  final VoidCallback onClear;

  const BarraTagsSelecionadas({
    super.key,
    required this.selectedTags,
    required this.onRemove,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTags.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: Colors.deepPurple,
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Filtros ativos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              TextButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.close, size: 16),
                label: const Text('Limpar'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTags.map((tag) {
              return _TagChip(
                label: _formatTag(tag),
                onRemove: () => onRemove(tag),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatTag(String tag) {
    switch (tag) {
      case 'delivery':
        return 'Delivery';
      case 'romantico':
        return 'Date';
      case 'familiar':
        return 'Família';
      case 'pizza':
        return 'Pizza';
      case 'marmita':
        return 'Marmita';
      case 'hamburguer':
        return 'Lanche';
      default:
        if (tag.isEmpty) return tag;
        return tag[0].toUpperCase() + tag.substring(1);
    }
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _TagChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 6, top: 7, bottom: 7),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(width: 6),
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onRemove,
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.close, size: 16, color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}
