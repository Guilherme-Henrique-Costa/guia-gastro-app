import 'package:flutter/material.dart';
import 'package:guia_gastro_app/controllers/controlador_favoritos.dart';
import 'package:guia_gastro_app/controllers/controlador_inicio.dart';
import 'package:guia_gastro_app/core/app_constants.dart';
import 'package:guia_gastro_app/core/app_dependencies.dart';
import 'package:guia_gastro_app/core/modo_ordenacao.dart';
import 'package:guia_gastro_app/widgets/estado/empty_state.dart';
import 'package:guia_gastro_app/widgets/estado/error_state.dart';
import 'package:guia_gastro_app/widgets/filtros/filtros_avancados_sheet.dart';
import 'package:guia_gastro_app/widgets/inicio/barra_busca.dart';
import 'package:guia_gastro_app/widgets/inicio/barra_tags_selecionadas.dart';
import 'package:guia_gastro_app/widgets/inicio/secao_top3.dart';
import 'package:guia_gastro_app/widgets/inicio/tag_carousel_section.dart';
import 'package:guia_gastro_app/widgets/restaurante/card_restaurante.dart';
import 'package:guia_gastro_app/widgets/skeleton/restaurante_list_skeleton.dart';
import 'package:guia_gastro_app/widgets/skeleton/top3_skeleton_section.dart';

class TelaRanking extends StatefulWidget {
  const TelaRanking({super.key});

  @override
  State<TelaRanking> createState() => _TelaRankingState();
}

class _TelaRankingState extends State<TelaRanking> {
  late final InicioController controller;
  late final FavoritosController favoritosController;

  @override
  void initState() {
    super.initState();
    controller = AppDependencies.createInicioController(
      slug: AppConstants.regiaoPadraoSlug,
      usarRanking: true,
    );
    favoritosController = AppDependencies.favoritosController;
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _openDetalhe(int id) {
    Navigator.pushNamed(context, '/detalhe', arguments: id);
  }

  void _openAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FiltrosAvancadosSheet(
        notaMinimaInicial: controller.notaMinima,
        esperaMaximaInicial: controller.esperaMaximaMin,
        distanciaMaxKmInicial: controller.distanciaMaxKm,
        somenteProximosInicial: controller.somenteProximos,
        onApply:
            ({
              double? notaMinima,
              int? esperaMaxima,
              double? distanciaMaxKm,
              bool? somenteProximos,
            }) {
              controller.aplicarFiltrosAvancados(
                novaNotaMinima: notaMinima,
                novaEsperaMaxima: esperaMaxima,
                novaDistanciaMaxKm: distanciaMaxKm,
                novoSomenteProximos: somenteProximos,
              );
            },
        onClear: controller.limparFiltrosAvancados,
      ),
    );
  }

  void _limparTudo() {
    controller.clearTags();
    controller.limparFiltrosAvancados();
    controller.setSearchText('');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller, favoritosController]),
      builder: (context, _) {
        if (controller.loading && controller.items.isEmpty) {
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: const [
                      Top3SkeletonSection(),
                      SizedBox(height: 8),
                      RestauranteListSkeleton(itemCount: 4),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.error != null && controller.items.isEmpty) {
          return ErrorState(
            mensagem: controller.error,
            onRetry: controller.loadItems,
          );
        }

        return SafeArea(
          child: Column(
            children: [
              BarraBusca(onChanged: controller.setSearchText),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _openAdvancedFilters,
                        icon: const Icon(Icons.tune),
                        label: const Text('Filtros'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<SortMode>(
                      tooltip: 'Ordenar',
                      icon: const Icon(Icons.swap_vert),
                      onSelected: controller.setSortMode,
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: SortMode.ranking,
                          child: Text('Ranking'),
                        ),
                        PopupMenuItem(
                          value: SortMode.nota,
                          child: Text('Nota'),
                        ),
                        PopupMenuItem(
                          value: SortMode.precoMenor,
                          child: Text('Preço menor'),
                        ),
                        PopupMenuItem(
                          value: SortMode.esperaMenor,
                          child: Text('Espera menor'),
                        ),
                        PopupMenuItem(
                          value: SortMode.maisAvaliacoes,
                          child: Text('Mais avaliações'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BarraTagsSelecionadas(
                selectedTags: controller.selectedTags,
                onRemove: controller.removeTag,
                onClear: controller.clearTags,
              ),
              TagCarouselSection(
                tags: controller.tags,
                selectedTags: controller.selectedTags,
                onToggle: controller.toggleTag,
              ),
              const Divider(height: 1),
              Expanded(
                child: controller.items.isEmpty
                    ? EmptyState(
                        icon: Icons.emoji_events_outlined,
                        titulo: 'Sem resultados no ranking',
                        subtitulo:
                            'Tente remover filtros para ver mais restaurantes.',
                        acaoTexto: 'Limpar filtros',
                        onAcao: _limparTudo,
                      )
                    : ListView(
                        children: [
                          SecaoTop3(
                            items: controller.top3,
                            onTap: (item) => _openDetalhe(item.id),
                            isFavorito: favoritosController.isFavorito,
                            onToggleFavorito:
                                favoritosController.toggleFavorito,
                          ),
                          const SizedBox(height: 6),
                          const Divider(height: 1),
                          ...controller.restantes.asMap().entries.map((entry) {
                            return CardRestaurante(
                              item: entry.value,
                              index: entry.key + 3,
                              onTap: () => _openDetalhe(entry.value.id),
                              isFavorito: favoritosController.isFavorito(
                                entry.value.id,
                              ),
                              onToggleFavorito: () => favoritosController
                                  .toggleFavorito(entry.value.id),
                            );
                          }),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
