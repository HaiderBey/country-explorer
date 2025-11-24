import 'package:bolden/models/country.dart';
import 'package:bolden/services/country_service.dart';
import 'package:flutter/material.dart';

enum Status { loading, loaded, error}

class CountryProvider extends ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> _countries = [];
  Status _status = Status.loading;
  String? _errorMessage;

  List<Country> get countries => _countries;
  Status get status => _status;
  String? get errorMessage => _errorMessage;

  CountryProvider() {
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    _status = Status.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _countries = await _service.fetchAllCountries();
      _status = Status.loaded;
    } catch (e) {
      _status = Status.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _countries = [];
    } finally {
      notifyListeners();
    }

  }

}