
import 'package:bolden/models/country.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget{
  final Country country;

  const CountryCard({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap:() {
          //Placeholder: Should redirect to country information page
          // ignore: avoid_print
          print('Nzelt 3al ${country.name} :)');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Flags from API
            Expanded(
              child: Image.network(
                country.flag,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.public, size:40)),
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