import 'package:flutter/material.dart';

class BarraBusca extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const BarraBusca({
    super.key,
    required this.onChanged,
    this.hintText = 'Buscar por nome, endereço...',
  });

  @override
  State<BarraBusca> createState() => _BarraBuscaState();
}

class _BarraBuscaState extends State<BarraBusca> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    setState(() {});
  }

  void _clearSearch() {
    _textController.clear();
    widget.onChanged('');
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _textController.text.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: TextField(
        controller: _textController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: hasText
              ? IconButton(
                  tooltip: 'Limpar busca',
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.close),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          isDense: true,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
