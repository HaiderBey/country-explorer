import 'package:bolden/providers/country_provider.dart';
import 'package:bolden/widgets/country_card.dart';
import 'package:bolden/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  Widget _buildContent(BuildContext context, CountryProvider provider) {
    if (provider.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.status == Status.error){
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox (height: 10),
              Text(
                'Failed to load countries: ${provider.errorMessage}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => provider.fetchCountries(),
                child: const Text('Try Again'),
              )
            ]
          )
        )
      );
    }

    if(provider.countries.isEmpty) {
      return Center(
        child: Text('No countries found matching "${provider.searchQuery}".'),
      );
    }

    if (provider.countries.isNotEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: provider.countries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) {
          final country = provider.countries[i];
          return CountryCard(country: country);
        },
      );
    }

    return const Center(
      child: Text('No Countries found. be3 w rawa7!')
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const SearchBarWidget(),

        Expanded(
          child: Consumer<CountryProvider>(
              builder: (context, provider, child) {
                return RefreshIndicator(
                  onRefresh: provider.fetchCountries,
                  child: _buildContent(context, provider),
                );
              },
          ),
        ),
      ],
    );
  }
}