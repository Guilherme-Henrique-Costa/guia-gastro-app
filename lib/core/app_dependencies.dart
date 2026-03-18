import 'package:guia_gastro_app/controllers/controlador_favoritos.dart';
import 'package:guia_gastro_app/controllers/controlador_inicio.dart';
import 'package:guia_gastro_app/controllers/controlador_restaurante_detalhe.dart';
import 'package:guia_gastro_app/repositories/restaurante_repository.dart';
import 'package:guia_gastro_app/services/api_service.dart';
import 'package:guia_gastro_app/services/localizacao_service.dart';

class AppDependencies {
  AppDependencies._();

  static final ApiService _apiService = ApiService();
  static final LocalizacaoService _localizacaoService = LocalizacaoService();
  static final RestauranteRepository _restauranteRepository =
      RestauranteRepository(_apiService);
  static final FavoritosController _favoritosController = FavoritosController();

  static ApiService get apiService => _apiService;
  static LocalizacaoService get localizacaoService => _localizacaoService;
  static RestauranteRepository get restauranteRepository =>
      _restauranteRepository;
  static FavoritosController get favoritosController => _favoritosController;

  static InicioController createInicioController({
    required String slug,
    required bool usarRanking,
  }) {
    return InicioController(
      repository: _restauranteRepository,
      localizacaoService: _localizacaoService,
      slug: slug,
      usarRanking: usarRanking,
    );
  }

  static RestauranteDetalheController createRestauranteDetalheController({
    required int restauranteId,
  }) {
    return RestauranteDetalheController(
      apiService: _apiService,
      restauranteId: restauranteId,
    );
  }
}
