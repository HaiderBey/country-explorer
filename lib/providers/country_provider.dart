import 'package:bolden/models/country.dart';
import 'package:bolden/services/country_service.dart';
import 'package:flutter/material.dart';

enum Status { loading, loaded, error}

enum SortCriteria {nameAsc, nameDesc, populationAsc, populationDesc}

class CountryProvider extends ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  Status _status = Status.loading;
  String? _errorMessage;

  String _searchQuery = '';
  
  SortCriteria _sortCriteria = SortCriteria.nameAsc;

  List<Country> get countries => _filteredCountries;
  Status get status => _status;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  SortCriteria get sortCriteria => _sortCriteria;

  CountryProvider() {
    fetchCountries();
  }

  void setSearchQuery(String query){
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void setSortCriteria(SortCriteria criteria) {
    _sortCriteria = criteria;
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

    switch(_sortCriteria) {
      case SortCriteria.nameAsc:
        _filteredCountries.sort((a,b) => a.name.compareTo(b.name));
        break;
      case SortCriteria.nameDesc:
        _filteredCountries.sort((a,b) => b.name.compareTo(a.name));
        break;
      case SortCriteria.populationAsc:
        _filteredCountries.sort((a,b) => b.population.compareTo(a.population));
        break;
      case SortCriteria.populationDesc:
        _filteredCountries.sort((a,b) => a.population.compareTo(b.population));
        break;
      
    }
  }

  //Simple cleaning (Removes item from the country list)
  List<Country> _applyDataTransformation(List<Country> rawList) {
    
    final List<Country> transformedList = rawList
        .where((c) => !c.codes.contains('ISR'))
        .toList();

    return transformedList;
  }

  Future<void> fetchCountries() async {
    _status = Status.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _countries = await _service.fetchAllCountries();

      _countries = _applyDataTransformation(_countries);
      
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
    final String realCode = (code == 'ISR') ? 'PSE' : code;

    try {
      return await _service.fetchCountryByCode(realCode);
    } catch (e) {
      throw Exception('Failed to load details for $realCode: $e');
    }
  }
}