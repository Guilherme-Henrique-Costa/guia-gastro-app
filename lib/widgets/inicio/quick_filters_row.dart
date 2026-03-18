import 'package:flutter/material.dart';

class QuickFilterData {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const QuickFilterData({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
}

class QuickFiltersRow extends StatelessWidget {
  final List<QuickFilterData> items;

  const QuickFiltersRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return _QuickChip(item: items[index]);
        },
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final QuickFilterData item;

  const _QuickChip({required this.item});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = item.selected
        ? Colors.deepPurple.withOpacity(0.10)
        : Colors.white;

    final borderColor = item.selected ? Colors.deepPurple : Colors.black12;

    final foregroundColor = item.selected ? Colors.deepPurple : Colors.black87;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: item.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 16, color: foregroundColor),
            const SizedBox(width: 8),
            Text(
              item.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
