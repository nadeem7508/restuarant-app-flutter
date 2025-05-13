import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<dynamic> _favorites = []; 

  List<dynamic> get favorites => _favorites;

  void toggleFavorite(dynamic item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(dynamic item) {
    return _favorites.contains(item);
  }
}
