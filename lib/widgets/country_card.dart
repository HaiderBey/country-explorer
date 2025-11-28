
import 'package:bolden/models/country.dart';
import 'package:bolden/providers/favorites_provider.dart';
import 'package:bolden/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatelessWidget{
  final Country country;

  const CountryCard({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    final countryCode = country.codes[1];

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(countryCode: countryCode),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Flags
            Expanded(
              child: Stack(
                children: [ 
                  SvgPicture.network(
                    country.flag,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholderBuilder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, child) {
                        final isFav = favoritesProvider.isFavorite(countryCode);
                        return GestureDetector(
                          onTap: () {
                            favoritesProvider.toggleFavorite(countryCode);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 18,
                            child: Icon(
                              isFav ? Icons.favorite: Icons.favorite_border,
                              color: isFav? Colors.red : Colors.white,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Text
            Padding (
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        country.capital,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}