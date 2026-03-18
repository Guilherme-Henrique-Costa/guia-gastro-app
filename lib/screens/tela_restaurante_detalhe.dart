import 'package:flutter/material.dart';
import 'package:guia_gastro_app/controllers/controlador_favoritos.dart';
import 'package:guia_gastro_app/controllers/controlador_restaurante_detalhe.dart';
import 'package:guia_gastro_app/core/app_dependencies.dart';
import 'package:guia_gastro_app/widgets/estado/empty_state.dart';
import 'package:guia_gastro_app/widgets/estado/error_state.dart';
import 'package:guia_gastro_app/widgets/estado/loading_state.dart';
import 'package:guia_gastro_app/widgets/restaurante/restaurante_header_card.dart';
import 'package:guia_gastro_app/widgets/restaurante/restaurante_horarios_card.dart';
import 'package:guia_gastro_app/widgets/restaurante/restaurante_stats_card.dart';

class TelaRestauranteDetalhe extends StatefulWidget {
  final int id;

  const TelaRestauranteDetalhe({super.key, required this.id});

  @override
  State<TelaRestauranteDetalhe> createState() => _TelaRestauranteDetalheState();
}

class _TelaRestauranteDetalheState extends State<TelaRestauranteDetalhe> {
  late final RestauranteDetalheController controller;
  late final FavoritosController favoritosController;

  @override
  void initState() {
    super.initState();
    controller = AppDependencies.createRestauranteDetalheController(
      restauranteId: widget.id,
    );
    favoritosController = AppDependencies.favoritosController;
    controller.load();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe')),
      body: ListenableBuilder(
        listenable: Listenable.merge([controller, favoritosController]),
        builder: (context, _) {
          if (controller.loading && controller.data == null) {
            return const LoadingState(mensagem: 'Carregando detalhes...');
          }

          if (controller.error != null && controller.data == null) {
            return ErrorState(
              mensagem: controller.error,
              onRetry: controller.load,
            );
          }

          final data = controller.data;
          if (data == null) {
            return const EmptyState(
              icon: Icons.restaurant_outlined,
              titulo: 'Sem dados do restaurante',
              subtitulo: 'Não foi possível carregar os detalhes neste momento.',
            );
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              RestauranteHeaderCard(
                restaurante: data.restaurante,
                isFavorito: favoritosController.isFavorito(widget.id),
                onToggleFavorito: () =>
                    favoritosController.toggleFavorito(widget.id),
              ),
              RestauranteStatsCard(stats: data.stats),
              RestauranteHorariosCard(horarios: data.horarios),
            ],
          );
        },
      ),
    );
  }
}
