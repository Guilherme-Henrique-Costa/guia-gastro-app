import 'package:flutter/material.dart';
import 'tela_inicio.dart';
import 'tela_ranking.dart';
import 'tela_restaurantes.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indiceAtual = 0;

  final GlobalKey<TelaRestaurantesState> _restaurantesKey =
      GlobalKey<TelaRestaurantesState>();

  void _irParaRanking() {
    setState(() {
      _indiceAtual = 1;
    });
  }

  Future<void> _irParaRestaurantesProximos() async {
    setState(() {
      _indiceAtual = 2;
    });

    await Future.delayed(const Duration(milliseconds: 100));
    await _restaurantesKey.currentState?.ativarProximosDeMim();
  }

  late final List<Widget> _telas = [
    TelaInicio(
      onVerRankingCompleto: _irParaRanking,
      onMostrarProximos: _irParaRestaurantesProximos,
    ),
    const TelaRanking(),
    TelaRestaurantes(key: _restaurantesKey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _indiceAtual, children: _telas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceAtual,
        onDestinationSelected: (index) {
          setState(() => _indiceAtual = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Restaurantes',
          ),
        ],
      ),
    );
  }
}
