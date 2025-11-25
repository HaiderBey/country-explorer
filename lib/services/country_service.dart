import 'dart:convert';
import 'package:bolden/models/country.dart';
import 'package:http/http.dart' as http;


class CountryService {
  static const String _baseUrl = "https://www.apicountries.com";

  Future<List<Country>> fetchAllCountries() async {
    final url = Uri.parse('$_baseUrl/countries');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        return jsonList
            .map((json) => Country.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load countries. Server responded with status: ${response.statusCode}'
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print ('Error: $e');
      throw Exception('Network error: Please check your internet connexion.');
    }
  }

  Future<Country> fetchCountryByCode(String code) async {
    final url = Uri.parse('$_baseUrl/alpha/$code');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Country.fromJson(json);
    } else {
      throw Exception('Failed to load country details for code: $code. Status: ${response.statusCode}');
    }
  }

}