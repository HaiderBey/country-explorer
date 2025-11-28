import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String _favoritesKey = 'favoriteCountryCodes';

  List<String> _favoriteCountryCodes = [];
  bool _isLoading = true;

  List<String> get favoriteCountryCodes => _favoriteCountryCodes;
  bool get isLoading => _isLoading;

  FavoritesProvider() {
    _loadFavorites();
  }

  void _loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    final storedList = prefs.getStringList(_favoritesKey);

    _favoriteCountryCodes = storedList ?? [];
    _isLoading = false;
    notifyListeners();
  }

  bool isFavorite(String countryCode) {
    return _favoriteCountryCodes.contains(countryCode);
  }

  Future<void> toggleFavorite(String countryCode) async {
    final countryCodes = List<String>.from(_favoriteCountryCodes);
    final isFav = isFavorite(countryCode);

    if(isFav) {
      countryCodes.remove(countryCode);
    } else {
      countryCodes.add(countryCode);
    }

    _favoriteCountryCodes = countryCodes;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, countryCodes);
  }
}