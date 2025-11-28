import 'package:bolden/providers/country_provider.dart';
import 'package:bolden/providers/favorites_provider.dart';
import 'package:bolden/widgets/country_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CountryProvider, FavoritesProvider>(
        builder: (context, countryProvider, favoritesProvider, child) {
          if (countryProvider.status == Status.loading || favoritesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final allCountries = countryProvider.countries;
          final favoriteCodes = favoritesProvider.favoriteCountryCodes;

          final favoriteCountries = allCountries
              .where((country) => favoriteCodes.contains(country.codes[1]))
              .toList();
          
          if (favoriteCountries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Theme.of(context).colorScheme.primary.withAlpha(128)),
                  const SizedBox(height: 16),
                  const Text(
                    "You haven't added any favorites yet!",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "Tap the heart icons to add countries to favorites.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: favoriteCountries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, i) {
              final country = favoriteCountries[i];
              return CountryCard(country: country);
            },
          );
        },
      ),
    );
  }
}