import 'package:flutter/material.dart';
import 'package:guia_gastro_app/controllers/controlador_favoritos.dart';
import 'package:guia_gastro_app/controllers/controlador_inicio.dart';
import 'package:guia_gastro_app/core/app_constants.dart';
import 'package:guia_gastro_app/core/app_dependencies.dart';
import 'package:guia_gastro_app/core/modo_ordenacao.dart';
import 'package:guia_gastro_app/widgets/estado/error_state.dart';
import 'package:guia_gastro_app/widgets/filtros/filtros_avancados_sheet.dart';
import 'package:guia_gastro_app/widgets/inicio/barra_busca.dart';
import 'package:guia_gastro_app/widgets/inicio/barra_tags_selecionadas.dart';
import 'package:guia_gastro_app/widgets/inicio/quick_filters_row.dart';
import 'package:guia_gastro_app/widgets/inicio/secao_top3.dart';
import 'package:guia_gastro_app/widgets/inicio/tag_carousel_section.dart';
import 'package:guia_gastro_app/widgets/skeleton/top3_skeleton_section.dart';

class TelaInicio extends StatefulWidget {
  final VoidCallback? onVerRankingCompleto;
  final VoidCallback? onMostrarProximos;

  const TelaInicio({
    super.key,
    this.onVerRankingCompleto,
    this.onMostrarProximos,
  });

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller, favoritosController]),
      builder: (context, _) {
        if (controller.loading && controller.items.isEmpty) {
          return SafeArea(
            child: ListView(
              children: const [SizedBox(height: 12), Top3SkeletonSection()],
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
                    FilterChip(
                      label: const Text('Aberto agora'),
                      selected: controller.abertoAgora,
                      onSelected: controller.setAbertoAgora,
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
                        PopupMenuItem(
                          value: SortMode.proximidade,
                          child: Text('Proximidade'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QuickFiltersRow(
                items: [
                  QuickFilterData(
                    label: 'Ranking geral',
                    icon: Icons.emoji_events,
                    selected: controller.selectedTags.isEmpty,
                    onTap: () => controller.setOnlyTags([]),
                  ),
                  QuickFilterData(
                    label: 'Delivery',
                    icon: Icons.delivery_dining,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('delivery'),
                    onTap: () => controller.setOnlyTags(['delivery']),
                  ),
                  QuickFilterData(
                    label: 'Date',
                    icon: Icons.favorite,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('romantico'),
                    onTap: () => controller.setOnlyTags(['romantico']),
                  ),
                  QuickFilterData(
                    label: 'Família',
                    icon: Icons.family_restroom,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('familiar'),
                    onTap: () => controller.setOnlyTags(['familiar']),
                  ),
                  QuickFilterData(
                    label: 'Pizza',
                    icon: Icons.local_pizza,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('pizza'),
                    onTap: () => controller.setOnlyTags(['pizza']),
                  ),
                  QuickFilterData(
                    label: 'Marmita',
                    icon: Icons.lunch_dining,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('marmita'),
                    onTap: () => controller.setOnlyTags(['marmita']),
                  ),
                  QuickFilterData(
                    label: 'Lanche',
                    icon: Icons.fastfood,
                    selected:
                        controller.selectedTags.length == 1 &&
                        controller.selectedTags.contains('hamburguer'),
                    onTap: () => controller.setOnlyTags(['hamburguer']),
                  ),
                ],
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
                child: ListView(
                  children: [
                    SecaoTop3(
                      items: controller.top3,
                      onTap: (item) => _openDetalhe(item.id),
                      isFavorito: favoritosController.isFavorito,
                      onToggleFavorito: favoritosController.toggleFavorito,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: widget.onVerRankingCompleto,
                              icon: const Icon(Icons.emoji_events),
                              label: const Text('Ver ranking completo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                      child: OutlinedButton.icon(
                        onPressed: widget.onMostrarProximos,
                        icon: const Icon(Icons.my_location),
                        label: const Text('Mostrar próximos de mim'),
                      ),
                    ),
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
