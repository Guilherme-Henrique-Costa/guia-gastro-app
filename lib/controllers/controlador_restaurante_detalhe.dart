import 'package:flutter/material.dart';
import 'package:guia_gastro_app/models/modelo_restaurante_detalhe.dart';
import '../services/api_service.dart';

class RestauranteDetalheController extends ChangeNotifier {
  final ApiService apiService;
  final int restauranteId;

  RestauranteDetalheController({
    required this.apiService,
    required this.restauranteId,
  });

  RestauranteDetalheData? data;
  bool loading = false;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final detalhe = await apiService.getDetalheRestaurante(restauranteId);
      final horarios = await apiService.getHorarios(restauranteId, days: 30);

      data = RestauranteDetalheData.fromResponses(
        detalhe: detalhe,
        horarios: horarios,
      );
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
