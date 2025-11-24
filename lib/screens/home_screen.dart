import 'package:bolden/models/country.dart';
import 'package:bolden/widgets/country_card.dart';
import 'package:flutter/material.dart';

// ---- DUMMY DATA LIN NEKHDM SERVICE HTTP ----
final List<Country> kamchaBolden = [
  Country(
    name: 'United States',
    capital: 'Washington, D.C.',
    region: 'Americas',
    subregion: 'Northern America',
    timezones: ['UTC-12:00'],
    codes: ['US', 'USA'],
    callingCodes: ['1'],
    demonym: 'American',
    flag: 'https://flagcdn.com/us.svg',
    currencies: [],
    languages: [],
    borders: [],
    population: 331002651,
  ),
  Country(
    name: 'Tunisia',
    capital: 'Tunis',
    region: 'Africa',
    subregion: 'Northern Africa',
    timezones: ['UTC+01:00'],
    codes: ['TN', 'TUN'],
    callingCodes: ['216'],
    demonym: 'Tunisian',
    flag: 'https://flagcdn.com/tn.svg',
    currencies: [],
    languages: [],
    borders: ['DZ', 'LY'],
    population: 11818619,
  ),
  Country(
    name: 'Brazil',
    capital: 'Brasília',
    region: 'Americas',
    subregion: 'South America',
    timezones: ['UTC-05:00'],
    codes: ['BR', 'BRA'],
    callingCodes: ['55'],
    demonym: 'Brazilian',
    flag: 'https://flagcdn.com/br.svg',
    currencies: [],
    languages: [],
    borders: [],
    population: 212559417,
  ),
  Country(
    name: 'Japan',
    capital: 'Tokyo',
    region: 'Asia',
    subregion: 'Eastern Asia',
    timezones: ['UTC+09:00'],
    codes: ['JP', 'JPN'],
    callingCodes: ['81'],
    demonym: 'Japanese',
    flag: 'https://flagcdn.com/jp.svg',
    currencies: [],
    languages: [],
    borders: [],
    population: 126476461,
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bolden',
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: kamchaBolden.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            final country = kamchaBolden[i];
            return CountryCard(country: country);
          }
        )
      ),
      // Bottom Navigation to be added later
    );
  }
}