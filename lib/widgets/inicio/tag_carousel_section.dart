import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_tag.dart';

class TagCarouselSection extends StatelessWidget {
  final List<TagItem> tags;
  final Set<String> selectedTags;
  final void Function(String slug) onToggle;

  const TagCarouselSection({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final selected = selectedTags.contains(tag.slug);

          return ChoiceChip(
            label: Text(tag.nome),
            selected: selected,
            onSelected: (_) => onToggle(tag.slug),
          );
        },
      ),
    );
  }
}
