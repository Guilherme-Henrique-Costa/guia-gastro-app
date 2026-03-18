import 'package:flutter/material.dart';

class FavoritosController extends ChangeNotifier {
  final Set<int> _favoritos = {};

  Set<int> get favoritos => _favoritos;

  bool isFavorito(int restauranteId) {
    return _favoritos.contains(restauranteId);
  }

  void toggleFavorito(int restauranteId) {
    if (_favoritos.contains(restauranteId)) {
      _favoritos.remove(restauranteId);
    } else {
      _favoritos.add(restauranteId);
    }
    notifyListeners();
  }
}
