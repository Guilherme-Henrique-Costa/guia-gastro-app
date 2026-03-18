import 'package:flutter/material.dart';

class FiltrosAvancadosSheet extends StatefulWidget {
  final double? notaMinimaInicial;
  final int? esperaMaximaInicial;
  final double? distanciaMaxKmInicial;
  final bool somenteProximosInicial;
  final void Function({
    double? notaMinima,
    int? esperaMaxima,
    double? distanciaMaxKm,
    bool? somenteProximos,
  })
  onApply;
  final VoidCallback onClear;

  const FiltrosAvancadosSheet({
    super.key,
    required this.notaMinimaInicial,
    required this.esperaMaximaInicial,
    required this.distanciaMaxKmInicial,
    required this.somenteProximosInicial,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<FiltrosAvancadosSheet> createState() => _FiltrosAvancadosSheetState();
}

class _FiltrosAvancadosSheetState extends State<FiltrosAvancadosSheet> {
  double? notaMinima;
  int? esperaMaxima;
  double? distanciaMaxKm;
  late bool somenteProximos;

  @override
  void initState() {
    super.initState();
    notaMinima = widget.notaMinimaInicial;
    esperaMaxima = widget.esperaMaximaInicial;
    distanciaMaxKm = widget.distanciaMaxKmInicial;
    somenteProximos = widget.somenteProximosInicial;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Filtros avançados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Somente próximos de mim"),
                value: somenteProximos,
                onChanged: (v) => setState(() => somenteProximos = v),
              ),
              const SizedBox(height: 10),
              const _SectionTitle("Nota mínima"),
              Wrap(
                spacing: 8,
                children: [3.0, 4.0, 4.5].map((n) {
                  return ChoiceChip(
                    label: Text("${n.toStringAsFixed(1)}+"),
                    selected: notaMinima == n,
                    onSelected: (_) {
                      setState(() {
                        notaMinima = notaMinima == n ? null : n;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              const _SectionTitle("Espera máxima"),
              Wrap(
                spacing: 8,
                children: [10, 20, 30].map((m) {
                  return ChoiceChip(
                    label: Text("$m min"),
                    selected: esperaMaxima == m,
                    onSelected: (_) {
                      setState(() {
                        esperaMaxima = esperaMaxima == m ? null : m;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              const _SectionTitle("Distância máxima"),
              Wrap(
                spacing: 8,
                children: [1.0, 3.0, 5.0].map((km) {
                  return ChoiceChip(
                    label: Text("${km.toStringAsFixed(0)} km"),
                    selected: distanciaMaxKm == km,
                    onSelected: (_) {
                      setState(() {
                        distanciaMaxKm = distanciaMaxKm == km ? null : km;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        widget.onClear();
                        Navigator.pop(context);
                      },
                      child: const Text("Limpar"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        widget.onApply(
                          notaMinima: notaMinima,
                          esperaMaxima: esperaMaxima,
                          distanciaMaxKm: distanciaMaxKm,
                          somenteProximos: somenteProximos,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Aplicar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
