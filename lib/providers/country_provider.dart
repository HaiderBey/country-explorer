import 'package:bolden/models/country.dart';
import 'package:bolden/services/country_service.dart';
import 'package:flutter/material.dart';

enum Status { loading, loaded, error}

class CountryProvider extends ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  Status _status = Status.loading;
  String? _errorMessage;

  String _searchQuery = '';

  List<Country> get countries => _filteredCountries;
  Status get status => _status;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  CountryProvider() {
    fetchCountries();
  }

  void setSearchQuery(String query){
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters(){
    if (_searchQuery.isEmpty) {
      _filteredCountries = List.from(_countries);
    } else {
      _filteredCountries = _countries.where((country) {
        final query = _searchQuery;
        return country.name.toLowerCase().contains(query) ||
               country.capital.toLowerCase().contains(query) ||
               country.region.toLowerCase().contains(query) ||
               country.subregion.toLowerCase().contains(query);
      }).toList();
    }
    // I'll add Filtering system later
  }

  Future<void> fetchCountries() async {
    _status = Status.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _countries = await _service.fetchAllCountries();
      
      if (_countries.isEmpty) {
        _status = Status.error;
        _errorMessage = "Oops! You seem to have been accidentally shifted to a country-less planet! Refresh to return to Earth.";
      } else {
        _status = Status.loaded;
      }

    } catch (e) {
      _status = Status.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _countries = [];
    } finally {
      _applyFilters();
      notifyListeners();
    }
  }

  Future<Country> fetchCountryDetails(String code) async {
    try {
      return await _service.fetchCountryByCode(code);
    } catch (e) {
      throw Exception('Failed to load details for $code: $e');
    }
  }
}